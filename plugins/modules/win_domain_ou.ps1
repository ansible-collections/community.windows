#!powershell

# Copyright: (c) 2020 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic
#Requires -Module ActiveDirectory

$spec = @{
    options = @{
        state = @{ type = "str"; choices = @("absent", "present"); default = "present" }
        name = @{ type = "str"; required = $true }
        protected = @{ type = "bool"; default = $false }
        path = @{ type = "str"; required = $false }
        filter = @{type = "str"; default = '*' }
        recursive = @{ type = "bool"; default = $false }
        domain_username = @{ type = "str"; }
        domain_password = @{ type = "str"; no_log = $true }
        domain_server = @{ type = "str" }
        properties = @{ type = "dict" }
    }
    required_together = @(
        , @('domain_password', 'domain_username')
    )
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$extra_args = @{}
$onboard_extra_args = @{}
if ($null -ne $module.Params.domain_username) {
    $domain_password = ConvertTo-SecureString $module.Params.domain_password -AsPlainText -Force
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $module.Params.domain_username, $domain_password
    $extra_args.Credential = $credential
    $onboard_extra_args.Credential = $credential
}
if ($null -ne $module.Params.domain_server) {
    $extra_args.Server = $module.Params.domain_server
    $onboard_extra_args.Server = $module.Params.domain_server
}
if ($module.Params.properties.count -ne 0) {
    $Properties = New-Object Collections.Generic.List[string]
    $module.Params.properties.Keys | Foreach-Object {
        $Properties.Add($_)
    }
    $extra_args.Properties = $Properties
}
else {
    $extra_args.Properties = '*'
    $Properties = '*'
}

$extra_args.Filter = $module.Params.filter
$check_mode = $module.CheckMode
$name = $module.Params.name
$protected = $module.Params.protected
$path = $module.Params.path
$state = $module.Params.state
$recursive = $module.Params.recursive

# setup Dynamic Params
$params = @{}
if ($module.Params.properties.count -ne 0) {
    $module.Params.properties.Keys | ForEach-Object {
        $params.Add($_, $module.Params.properties.Item($_))
    }
}

Function Get-SimulatedOu {
    Param($Object)
    $ou = @{
        Name = $Object.name
        DistinguishedName = "OU=$($Object.name),$($Object.path)"
        ProtectedFromAccidentalDeletion = $Object.protected
        Properties = New-Object Collections.Generic.List[string]
    }
    $ou.Properties.Add("Name")
    $ou.Properties.Add("DistinguishedName")
    $ou.Properties.Add("ProtectedFromAccidentalDeletion")
    if ($Object.Params.properties.Count -ne 0) {
        $Object.Params.properties.Keys | ForEach-Object {
            $property = $_
            $module.Result.simulate_property = $property
            $ou.Add($property, $Object.Params.properties.Item($property))
            $ou.Properties.Add($property)
        }
    }
    # convert to psobject & return
    [PSCustomObject]$ou
}

Function Get-OuObject {
    Param([PSObject]$Object)
    $obj = $Object | Select-Object -Property * -ExcludeProperty nTSecurityDescriptor | ConvertTo-Json -Depth 1 | ConvertFrom-Json
    return $obj
}

# attempt import of module
Try { Import-Module ActiveDirectory }
Catch { $module.FailJson("The ActiveDirectory module failed to load properly: $($_.Exception.Message)", $_) }
Try {
    $all_ous = Get-ADOrganizationalUnit @extra_args
}
Catch { $module.FailJson("Get-ADOrganizationalUnit failed: $($_.Exception.Message)", $_) }

# set path if not defined to base domain
if ($null -eq $path) {
    if ($($all_ous | Measure-Object | Select-Object -ExpandProperty Count) -eq 1) {
        $matched = $all_ous.DistinguishedName -match "DC=.+"
    }
    elseif ($($all_ous | Measure-Object | Select-Object -ExpandProperty Count) -gt 1) {
        $matched = $all_ous[0].DistinguishedName -match "DC=.+"
    }
    else {
        $module.FailJson("Path was null and unable to determine default domain $($_.Exception.Message)")
    }
    if ($matched) {
        $path = $matches.Values[0]
    }
    else {
        $module.FailJson("Unable to find default domain $($_.Exception.Message)")
    }
}
$module.Result.path = $path

# determine if requested OU exist
$current_ou = $false
Try {
    $current_ou = $all_ous | Where-Object {
        $_.DistinguishedName -eq "OU=$name,$path" }
    $module.Diff.before = Get-OuObject -Object $current_ou
    $module.Result.ou = Get-OuObject $module.Diff.before
}
Catch {
    $module.Diff.before = ""
    $current_ou = $false
}

# determine if ou needs created
if (($state -eq "present") -and (-not $current_ou)) {
    $create_ou = $true
}
else {
    $create_ou = $false
}

# determine if ou needs change
$update_ou = $false
if (($state -eq "present") -and ($create_ou -eq $false)) {
    if ($module.Params.properties.Count -ne 0) {
        $changed_properties = New-Object Collections.Generic.List[hashtable]
        $module.Params.properties.Keys | ForEach-Object {
            $property = $_
            $current_value = $current_ou.Item($property)
            $requested_value = $module.Params.properties.Item($property)
            if (-not ($current_value -eq $requested_value) ) {
                $changed_properties.Add(
                    @{
                        "Actual_$property" = $current_value
                        "Requested_$property" = $requested_value
                    }
                )
            }
        }
        if ($changed_properties.Count -ge 1) {
            $update_ou = $true
        }
    }
}

if ($state -eq "present") {
    # ou does not exist, create object
    if ($create_ou) {
        $params.Name = $name
        $params.Path = $path
        Try {
            New-ADOrganizationalUnit @params @onboard_extra_args -ProtectedFromAccidentalDeletion $protected -WhatIf:$check_mode
        }
        Catch {
            $module.FailJson("Failed to create organizational unit: $($_.Exception.Message)", $_)
        }
        $module.Result.changed = $true
        if ($check_mode) {
            $module.Diff.after = Get-SimulatedOu -Object $module
        }
        else {
            $new_ou = Get-ADOrganizationalUnit @extra_args | Where-Object {
                $_.DistinguishedName -eq "OU=$name,$path"
            }
            $module.Diff.after = Get-OuObject -Object $new_ou
        }
    }
    # ou exists, update object if needed
    if ($update_ou) {
        Try {
            Set-ADOrganizationalUnit -Identity "OU=$name,$path" @params @onboard_extra_args -WhatIf:$check_mode
            $module.Result.changed = $true
        }
        Catch {
            $module.FailJson("Failed to update organizational unit: $($_.Exception.Message)", $_)
        }
        if ($check_mode) {
            $module.Diff.after = Get-SimulatedOu -Object $module
        }
        else {
            $new_ou = Get-ADOrganizationalUnit @extra_args | Where-Object {
                $_.DistinguishedName -eq "OU=$name,$path"
            }
            $module.Diff.after = Get-OuObject -Object $new_ou
        }
    }
}

if ($state -eq "absent") {
    # ou exists, delete object
    if ($current_ou) {
        Try {
            # override protected from accidental deletion
            Set-ADOrganizationalUnit -Identity "OU=$name,$path" -ProtectedFromAccidentalDeletion $false @onboard_extra_args -Confirm:$False -WhatIf:$check_mode
            $module.Result.changed = $true
        }
        Catch {
            $module.FailJson("Failed to remove ProtectedFromAccidentalDeletion Lock: $($_.Exception.Message)", $_)
        }
        # check recursive deletion
        if ($recursive) {
            try {
                Remove-ADOrganizationalUnit -Identity "OU=$name,$path" -Confirm:$False -WhatIf:$check_mode -Recursive @onboard_extra_args
                $module.Result.changed = $true
                $module.Diff.after = ""
                $module.Result.ou = ""
            }
            catch {
                $module.FailJson("Failed to recursively Remove-ADOrganizationalUnit $($_.Exception.Message)", $_)
            }
        }
        else {
            try {
                Remove-ADOrganizationalUnit -Identity "OU=$name,$path" -Confirm:$False -WhatIf:$check_mode @onboard_extra_args
                $module.Result.changed = $true
                $module.Diff.after = ""
                $module.Result.ou = ""
            }
            Catch {
                $module.FailJson("Failed to Remove-ADOrganizationalUnit: $($_.Exception.Message)", $_)
            }
        }
    }
}

$module.ExitJson()
