#!powershell

# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.AccessToken
#AnsibleRequires -CSharpUtil Ansible.Basic

Function Test-Credential {
    param(
        [String]$Username,
        [String]$Password,
        [String]$Domain = $null
    )
    if (($Username.ToCharArray()) -contains [char]'@') {
        # UserPrincipalName
        $Domain = $null # force $Domain to be null, to prevent undefined behaviour, as a domain name is already included in the username
    }
    elseif (($Username.ToCharArray()) -contains [char]'\') {
        # Pre Win2k Account Name
        $Domain = ($Username -split '\\')[0]
        $Username = ($Username -split '\\', 2)[-1]
    } # If no domain provided, so maybe local user, or domain specified separately.

    try {
        $handle = [Ansible.AccessToken.TokenUtil]::LogonUser($Username, $Domain, $Password, "Network", "Default")
        $handle.Dispose()
        return $true
    }
    catch [Ansible.AccessToken.Win32Exception] {
        # following errors indicate the creds are correct but the user was
        # unable to log on for other reasons, which we don't care about
        $success_codes = @(
            0x0000052F, # ERROR_ACCOUNT_RESTRICTION
            0x00000530, # ERROR_INVALID_LOGON_HOURS
            0x00000531, # ERROR_INVALID_WORKSTATION
            0x00000569  # ERROR_LOGON_TYPE_GRANTED
        )
        $failed_codes = @(
            0x0000052E, # ERROR_LOGON_FAILURE
            0x00000532, # ERROR_PASSWORD_EXPIRED
            0x00000773, # ERROR_PASSWORD_MUST_CHANGE
            0x00000533  # ERROR_ACCOUNT_DISABLED
        )

        if ($_.Exception.NativeErrorCode -in $failed_codes) {
            return $false
        }
        elseif ($_.Exception.NativeErrorCode -in $success_codes) {
            return $true
        }
        else {
            # an unknown failure, reraise exception
            throw $_
        }
    }
}

$spec = @{
    options = @{
        name = @{ type = 'str'; required = $true }
        state = @{
            type = "str"
            choices = @('present', 'absent', 'query')
            default = "present"
        }
        domain_username = @{ type = 'str' }
        domain_password = @{ type = 'str'; no_log = $true }
        domain_server = @{ type = 'str' }
        multi_domains = @{ type = "bool" ; default = $false }
        groups_action = @{
            type = 'str'
            choices = @('add', 'remove', 'replace')
            default = 'replace'
        }
        spn_action = @{
            type = 'str'
            choices = @('add', 'remove', 'replace')
            default = 'replace'
        }
        spn = @{
            type = 'list'
            elements = 'str'
            aliases = @('spns')
        }
        description = @{ type = 'str' }
        password = @{ type = 'str'; no_log = $true }
        password_expired = @{ type = 'bool' }
        password_never_expires = @{ type = 'bool' }
        user_cannot_change_password = @{ type = 'bool' }
        account_locked = @{ type = 'bool' }
        groups = @{ type = 'list'; elements = 'str' }
        groups_missing_behaviour = @{ type = 'str'; choices = "fail", "ignore", "warn"; default = "fail" }
        enabled = @{ type = 'bool'; default = $true }
        path = @{ type = 'str' }
        upn = @{ type = 'str' }
        sam_account_name = @{ type = 'str' }
        identity = @{ type = 'str' }
        firstname = @{ type = 'str' }
        surname = @{ type = 'str'; aliases = @('lastname') }
        display_name = @{ type = 'str' }
        company = @{ type = 'str' }
        email = @{ type = 'str' }
        street = @{ type = 'str' }
        city = @{ type = 'str' }
        state_province = @{ type = 'str' }
        postal_code = @{ type = 'str' }
        country = @{ type = 'str' }
        attributes = @{ type = 'dict' }
        delegates = @{
            type = 'list'
            elements = 'str'
            aliases = @('principals_allowed_to_delegate')
        }
        update_password = @{
            type = 'str'
            choices = @('always', 'on_create', 'when_changed')
            default = 'always'
        }
    }
    required_together = @(
        , @("domain_username", "domain_password")
    )
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$check_mode = $module.CheckMode

$module.Result.created = $false
$module.Result.password_updated = $false

try {
    Import-Module ActiveDirectory
}
catch {
    $msg = "Failed to import ActiveDirectory PowerShell module."
    $module.FailJson($msg, $_)
}

# Module control parameters
$state = $module.Params.state
$update_password = $module.Params.update_password
$groups_action = $module.Params.groups_action
$domain_username = $module.Params.domain_username
$domain_password = $module.Params.domain_password
$domain_server = $module.Params.domain_server
$multi_domains = $module.Params.multi_domains

# User account parameters
$name = $module.Params.name
$description = $module.Params.description
$password = $module.Params.password
$password_expired = $module.Params.password_expired
$password_never_expires = $module.Params.password_never_expires
$user_cannot_change_password = $module.Params.user_cannot_change_password
$account_locked = $module.Params.account_locked
$groups = $module.Params.groups
$groups_missing_behaviour = $module.Params.groups_missing_behaviour
$enabled = $module.Params.enabled
$path = $module.Params.path
$upn = $module.Params.upn
$spn = $module.Params.spn
$spn_action = $module.Params.spn_action
$sam_account_name = $module.Params.sam_account_name
$delegates = $module.Params.delegates
$identity = $module.Params.identity

if ($null -eq $identity) {
    $identity = $name
}

# User informational parameters
$user_info = @{
    GivenName = $module.Params.firstname
    Surname = $module.Params.surname
    DisplayName = $module.Params.display_name
    Company = $module.Params.company
    EmailAddress = $module.Params.email
    StreetAddress = $module.Params.street
    City = $module.Params.city
    State = $module.Params.state_province
    PostalCode = $module.Params.postal_code
    Country = $module.Params.country
}

# Additional attributes
$attributes = $module.Params.attributes

# Parameter validation
If ($null -ne $account_locked -and $account_locked) {
    $module.FailJson("account_locked must be set to 'no' if provided")
}

If (($null -ne $password_expired) -and ($null -ne $password_never_expires)) {
    $module.FailJson("password_expired and password_never_expires are mutually exclusive but have both been set")
}

If (($null -ne $domain_server) -and $multi_domains) {
    $module.FailJson("domain_server and multi_domains are mutually exclusive. Either unset domain_server or set multi_domains to false")
}

$extra_args = @{}
if ($null -ne $domain_username) {
    $domain_password = ConvertTo-SecureString $domain_password -AsPlainText -Force
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $domain_username, $domain_password
    $extra_args.Credential = $credential
}

# Function to query the global catalog to get user's assigned groups with their
# DistinguishedName, the domain they belong to, and a DC to query this domain
Function Get-UserAccountGroupsList {
    Param ($user_obj)

    $dcgc = "$((Get-ADDomainController).Name):3268"

    $user_groups = @(
        foreach ($groupDN in (@( $user_obj.PrimaryGroup ) + $user_obj.MemberOf)) {
            try {
                Get-ADGroup -Identity $groupDN -Server $dcgc -Property CanonicalName |
                    Select-Object *, @{Name = 'Domain'; Expression = { ($_.CanonicalName -split "/")[0] } } |
                    Select-Object *, @{Name = 'DC'; Expression = { `
                                Get-ADDomainController -Discover -Service "PrimaryDC" | Select-Object -ExpandProperty hostname }
                    }
            }
            catch {
                $module.Warn("Failed to enumerate user groups but continuing on: $($_.Exception.Message)")
            }
        }
    )

    return $user_groups
}

Function Get-UserAccount {
    Param ($identity, $extra_args)

    return Get-ADUser `
        -Identity $identity `
        -Properties ('*', 'msDS-PrincipalName') @extra_args
}


# Build list of domain(s) controller(s) to query when looking
# for user or groups
$domains_controllers = @()

if (-not $multi_domains) {
    if ($null -ne $domain_server) {
        $domains_controllers += @($domain_server)
    }
    else {
        $domains_controllers += @(Get-ADDomainController `
                -Discover `
                -Service "PrimaryDC" |
                Select-Object -ExpandProperty hostname)
    }
}
else {
    try {
        foreach ($domain in $((Get-ADForest).domains)) {
            try {
                $domains_controllers += @(Get-ADDomainController `
                        -Discover `
                        -Domain $domain `
                        -Service "PrimaryDC" |
                        Select-Object -ExpandProperty hostname)
            }
            catch {
                $module.Warn("Failed to get a domain controller for '$domain', but continuing on.: $($_.Exception.Message)")
            }
        }
    }
    catch {
        $module.FailJson("Failed to enumerate forest domains: $($_.Exception.Message)")
    }
}

# Look for user account on DC(s)
ForEach ($dc in $domains_controllers) {
    try {
        $extra_args.Server = $dc
        $user_obj = Get-UserAccount $identity $extra_args
        $user_guid = $user_obj.ObjectGUID
        break
    }
    catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
        # User account not found
        $user_obj = $null
        $user_guid = $null
    }
    catch {
        # Other exceptions
        # Only print warning if there are DC to query left, else fail
        if ($($domains_controllers.indexOf($dc) + 1) -lt $domains_controllers.length) {
            $module.Warn("Failed to look for user '$identity' in domain '$domain' (on DC $($extra_args.Server)) but continuing on..." `
                    + "The exception was: $($_.Exception.Message)")
        }
        else {
            $module.FailJson("Failed to look for user '$identity' in domain '$domain' (on DC $($extra_args.Server))." `
                    + "No more domain controller left to query, aborting. The exception was: $($_.Exception.Message)")
        }
    }
}

If ($state -eq 'present') {
    # If the account does not exist, create it
    If (-not $user_obj) {
        $create_args = @{}
        $create_args.Name = $name
        If ($null -ne $path) {
            $create_args.Path = $path
        }
        If ($null -ne $upn) {
            $create_args.UserPrincipalName = $upn
            $create_args.SamAccountName = $upn.Split('@')[0]
        }
        If ($null -ne $sam_account_name) {
            $create_args.SamAccountName = $sam_account_name
        }
        if ($null -ne $password) {
            $create_args.AccountPassword = ConvertTo-SecureString $password -AsPlainText -Force
        }
        $user_obj = New-ADUser @create_args -WhatIf:$check_mode -PassThru @extra_args
        $user_guid = $user_obj.ObjectGUID
        $module.Result.created = $true
        $module.Result.changed = $true
        If ($check_mode) {
            $module.ExitJson()
        }
        $user_obj = Get-ADUser -Identity $user_guid -Properties ('*', 'msDS-PrincipalName') @extra_args
    }
    ElseIf ($password) {
        # Don't unnecessary check for working credentials.
        # Set the password if we need to.
        If ($update_password -eq "always") {
            $set_new_credentials = $true
        }
        elseif ($update_password -eq "when_changed") {
            $user_identifier = If ($user_obj.UserPrincipalName) {
                $user_obj.UserPrincipalName
            }
            else {
                $user_obj.'msDS-PrincipalName'
            }

            $set_new_credentials = -not (Test-Credential -Username $user_identifier -Password $password)
        }
        else {
            $set_new_credentials = $false
        }
        If ($set_new_credentials) {
            $secure_password = ConvertTo-SecureString $password -AsPlainText -Force
            try {
                Set-ADAccountPassword -Identity $user_guid `
                    -Reset:$true `
                    -Confirm:$false `
                    -NewPassword $secure_password `
                    -WhatIf:$check_mode @extra_args
            }
            catch {
                $module.FailJson("Failed to set password on account: $($_.Exception.Message)", $_)
            }
            $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
            $module.Result.password_updated = $true
            $module.Result.changed = $true
        }
    }

    # Configure password policies
    If (($null -ne $password_never_expires) -and ($password_never_expires -ne $user_obj.PasswordNeverExpires)) {
        Set-ADUser -Identity $user_guid -PasswordNeverExpires $password_never_expires -WhatIf:$check_mode @extra_args
        $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
        $module.Result.changed = $true
    }
    If (($null -ne $password_expired) -and ($password_expired -ne $user_obj.PasswordExpired)) {
        Set-ADUser -Identity $user_guid -ChangePasswordAtLogon $password_expired -WhatIf:$check_mode @extra_args
        $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
        $module.Result.changed = $true
    }
    If (($null -ne $user_cannot_change_password) -and ($user_cannot_change_password -ne $user_obj.CannotChangePassword)) {
        Set-ADUser -Identity $user_guid -CannotChangePassword $user_cannot_change_password -WhatIf:$check_mode @extra_args
        $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
        $module.Result.changed = $true
    }

    # Assign other account settings
    If (($null -ne $upn) -and ($upn -ne $user_obj.UserPrincipalName)) {
        Set-ADUser -Identity $user_guid -UserPrincipalName $upn -WhatIf:$check_mode @extra_args
        $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
        $module.Result.changed = $true
    }
    If (($null -ne $sam_account_name) -and ($sam_account_name -ne $user_obj.SamAccountName)) {
        Set-ADUser -Identity $user_guid -SamAccountName $sam_account_name -WhatIf:$check_mode @extra_args
        $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
        $module.Result.changed = $true
    }
    If (($null -ne $description) -and ($description -ne $user_obj.Description)) {
        Set-ADUser -Identity $user_guid -description $description -WhatIf:$check_mode @extra_args
        $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
        $module.Result.changed = $true
    }
    If ($enabled -ne $user_obj.Enabled) {
        Set-ADUser -Identity $user_guid -Enabled $enabled -WhatIf:$check_mode @extra_args
        $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
        $module.Result.changed = $true
    }
    If ((-not $account_locked) -and ($user_obj.LockedOut -eq $true)) {
        Unlock-ADAccount -Identity $user_guid -WhatIf:$check_mode @extra_args
        $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
        $module.Result.changed = $true
    }
    If ($delegates) {
        if (Compare-Object $delegates $user_obj.PrincipalsAllowedToDelegateToAccount) {
            Set-ADUser -Identity $user_guid -PrincipalsAllowedToDelegateToAccount $delegates
            $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
            $module.Result.changed = $true
        }
    }

    # configure service principal names
    if ($null -ne $spn) {
        $current_spn = [Array]$user_obj.ServicePrincipalNames
        $desired_spn = [Array]$spn
        $spn_diff = @()

        # generate a diff
        $desired_spn | ForEach-Object {
            if ($current_spn -contains $_) {
                $spn_diff += $_
            }
        }

        try {
            switch ($spn_action) {
                "add" {
                    # the current spn list does not have any spn's in the desired list
                    if (-not $spn_diff) {
                        Set-ADUser `
                            -Identity $user_guid `
                            -ServicePrincipalNames @{ Add = $(($spn | ForEach-Object { "$($_)" } )) } `
                            -WhatIf:$check_mode @extra_args
                        $module.Result.changed = $true
                    }
                }
                "remove" {
                    # the current spn list does not have any differences
                    # that means we can remove the desired list
                    if ($spn_diff) {
                        Set-ADUser `
                            -Identity $user_guid `
                            -ServicePrincipalNames @{ Remove = $(($spn | ForEach-Object { "$($_)" } )) } `
                            -WhatIf:$check_mode @extra_args
                        $module.Result.changed = $true
                    }
                }
                "replace" {
                    # the current and desired spn lists do not match
                    if (Compare-Object $current_spn $desired_spn) {
                        Set-ADUser `
                            -Identity $user_guid `
                            -ServicePrincipalNames @{ Replace = $(($spn | ForEach-Object { "$($_)" } )) } `
                            -WhatIf:$check_mode @extra_args
                        $module.Result.changed = $true
                    }
                }
            }
        }
        catch {
            $module.FailJson("Failed to $spn_action SPN(s)", $_)
        }
    }

    # Set user information
    Foreach ($key in $user_info.Keys) {
        If ($null -eq $user_info[$key]) {
            continue
        }
        $value = $user_info[$key]
        If ($value -ne $user_obj.$key) {
            $set_args = $extra_args.Clone()
            $set_args.$key = $value
            Set-ADUser -Identity $user_guid -WhatIf:$check_mode @set_args
            $module.Result.changed = $true
            $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
        }
    }

    # Set additional attributes
    $set_args = $extra_args.Clone()
    $run_change = $false

    if ($null -ne $attributes) {
        $add_attributes = @{}
        $replace_attributes = @{}
        foreach ($attribute in $attributes.GetEnumerator()) {
            $attribute_name = $attribute.Key
            $attribute_value = $attribute.Value

            $valid_property = [bool]($user_obj.PSobject.Properties.name -eq $attribute_name)
            if ($valid_property) {
                $existing_value = $user_obj.$attribute_name
                if ($existing_value -cne $attribute_value) {
                    $replace_attributes.$attribute_name = $attribute_value
                }
            }
            else {
                $add_attributes.$attribute_name = $attribute_value
            }
        }
        if ($add_attributes.Count -gt 0) {
            $set_args.Add = $add_attributes
            $run_change = $true
        }
        if ($replace_attributes.Count -gt 0) {
            $set_args.Replace = $replace_attributes
            $run_change = $true
        }
    }

    if ($run_change) {
        Set-ADUser -Identity $user_guid -WhatIf:$check_mode @set_args
        $module.Result.changed = $true
        $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
    }

    # Configure group assignment
    if ($null -ne $groups) {
        $set_args = $extra_args.Clone()

        $group_list = $groups

        # Groups, provided via module group parameter, may not be distinguished names...
        # Then, we cannot query a global catalog. It is required to query a DC in each
        # forest's domain
        $groups = @(
            Foreach ($group in $group_list) {
                ForEach ($dc in $domains_controllers) {
                    $set_args.Server = $dc

                    try {
                        Get-ADGroup -Identity $group @set_args | Select-Object *, @{Name = 'DC'; Expression = { "$dc" } }
                        break
                    }
                    catch {
                        # If there are DC to query left, and if the exception is not an ADIdentityNotFoundException, print a warning with the exception.
                        # Else follow the $groups_missing_behaviour specified action
                        if ($($domains_controllers.indexOf($dc) + 1) -lt $domains_controllers.length) {
                            if ($_.CategoryInfo.Reason -ne "ADIdentityNotFoundException") {
                                $module.Warn("Failed to look for group '$group' on DC $($set_args.Server)) but continuing on..." `
                                        + "The exception was: $($_.Exception.Message)")
                            }
                        }
                        else {
                            if ($groups_missing_behaviour -eq "fail") {
                                $module.FailJson("Failed to locate group $($group): $($_.Exception.Message)", $_)
                            }
                            elseif ($groups_missing_behaviour -eq "warn") {
                                $module.Warn("Failed to locate group $($group) but continuing on: $($_.Exception.Message)")
                            }
                        }
                    }
                }
            }
        )

        $assigned_groups = Get-UserAccountGroupsList $user_obj

        # Remove the 'Server' key from the $setArgs as we will explicitely
        # set the DC in which we found the group for below queries
        $set_args.Remove("Server")

        switch ($groups_action) {
            "add" {
                Foreach ($group in $groups) {
                    If (-not ($assigned_groups.DistinguishedName -Contains $group.DistinguishedName)) {
                        Add-ADGroupMember `
                            -Identity $group.ObjectGUID `
                            -Members $user_obj `
                            -Server $group.DC `
                            -WhatIf:$check_mode @set_args
                        $module.Result.changed = $true
                    }
                }
            }
            "remove" {
                Foreach ($group in $groups) {
                    If ($assigned_groups.DistinguishedName -Contains $group.DistinguishedName) {
                        Remove-ADGroupMember `
                            -Identity $group.ObjectGUID `
                            -Members $user_obj `
                            -Confirm:$false `
                            -Server $group.DC `
                            -WhatIf:$check_mode @set_args
                        $module.Result.changed = $true
                    }
                }
            }
            "replace" {
                Foreach ($group in $assigned_groups) {
                    If (($group.DistinguishedName -ne $user_obj.PrimaryGroup) -and -not ($groups.DistinguishedName -Contains $group.DistinguishedName)) {
                        Remove-ADGroupMember `
                            -Identity $group.ObjectGUID `
                            -Members $user_obj `
                            -Confirm:$false `
                            -Server $group.DC `
                            -WhatIf:$check_mode @set_args
                        $module.Result.changed = $true
                    }
                }
                Foreach ($group in $groups) {
                    If (-not ($assigned_groups.DistinguishedName -Contains $group.DistinguishedName)) {
                        Add-ADGroupMember `
                            -Identity $group.ObjectGUID `
                            -Members $user_obj `
                            -Server $group.DC `
                            -WhatIf:$check_mode @set_args
                        $module.Result.changed = $true
                    }
                }
            }
        }
    }
}
elseif ($state -eq 'absent') {
    # Ensure user does not exist
    If ($user_obj) {
        Remove-ADUser $user_obj -Confirm:$false -WhatIf:$check_mode @extra_args
        $module.Result.changed = $true
        if ($check_mode) {
            $module.ExitJson()
        }
        $user_obj = $null
    }
}

If ($user_obj) {
    $user_obj = Get-ADUser -Identity $user_guid -Properties * @extra_args
    $module.Result.name = $user_obj.Name
    $module.Result.firstname = $user_obj.GivenName
    $module.Result.surname = $user_obj.Surname
    $module.Result.display_name = $user_obj.DisplayName
    $module.Result.enabled = $user_obj.Enabled
    $module.Result.company = $user_obj.Company
    $module.Result.street = $user_obj.StreetAddress
    $module.Result.email = $user_obj.EmailAddress
    $module.Result.city = $user_obj.City
    $module.Result.state_province = $user_obj.State
    $module.Result.country = $user_obj.Country
    $module.Result.postal_code = $user_obj.PostalCode
    $module.Result.distinguished_name = $user_obj.DistinguishedName
    $module.Result.description = $user_obj.Description
    $module.Result.password_expired = $user_obj.PasswordExpired
    $module.Result.password_never_expires = $user_obj.PasswordNeverExpires
    $module.Result.user_cannot_change_password = $user_obj.CannotChangePassword
    $module.Result.account_locked = $user_obj.LockedOut
    $module.Result.delegates = $user_obj.PrincipalsAllowedToDelegateToAccount
    $module.Result.sid = [string]$user_obj.SID
    $module.Result.spn = [Array]$user_obj.ServicePrincipalNames
    $module.Result.upn = $user_obj.UserPrincipalName
    $module.Result.sam_account_name = $user_obj.SamAccountName
    $module.Result.groups = (Get-UserAccountGroupsList $user_obj).DistinguishedName
    $module.Result.msg = "User '$name' is present"
    $module.Result.state = "present"
}
else {
    $module.Result.name = $name
    $module.Result.msg = "User '$name' is absent"
    $module.Result.state = "absent"
}

$module.ExitJson()
