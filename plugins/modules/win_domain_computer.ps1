#!powershell

# Copyright: (c) 2020, Brian Scholer (@briantist)
# Copyright: (c) 2017, AMTEGA - Xunta de Galicia
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#Requires -Module Ansible.ModuleUtils.Legacy
#Requires -Module Ansible.ModuleUtils.ArgvParser
#Requires -Module Ansible.ModuleUtils.CommandUtil
#Requires -Module ActiveDirectory

# ------------------------------------------------------------------------------
$ErrorActionPreference = "Stop"

# Preparing result
$result = @{}
$result.changed = $false

# Parameter ingestion
$params = Parse-Args $args -supports_check_mode $true

$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool"  -default $false
$diff_support = Get-AnsibleParam -obj $params -name "_ansible_diff" -type "bool" -default $false
$temp = Get-AnsibleParam -obj $params -name '_ansible_remote_tmp' -type 'path' -default $env:TEMP

$name = Get-AnsibleParam -obj $params -name "name" -failifempty $true -resultobj $result
$sam_account_name = Get-AnsibleParam -obj $params -name "sam_account_name" -default "${name}$"
If (-not $sam_account_name.EndsWith("$")) {
    $sam_account_name = "${sam_account_name}$"
}
$enabled = Get-AnsibleParam -obj $params -name "enabled" -type "bool" -default $true
$description = Get-AnsibleParam -obj $params -name "description" -default $null
$domain_username = Get-AnsibleParam -obj $params -name "domain_username" -type "str"
$domain_password = Get-AnsibleParam -obj $params -name "domain_password" -type "str" -failifempty ($null -ne $domain_username)
$domain_server = Get-AnsibleParam -obj $params -name "domain_server" -type "str"
$state = Get-AnsibleParam -obj $params -name "state" -ValidateSet "present", "absent" -default "present"
$managed_by = Get-AnsibleParam -obj $params -name "managed_by" -type "str"

$odj_action = Get-AnsibleParam -obj $params -name "offline_domain_join" -type "str" -ValidateSet "none", "output", "path" -default "none"
$_default_blob_path = Join-Path -Path $temp -ChildPath ([System.IO.Path]::GetRandomFileName())
$odj_blob_path = Get-AnsibleParam -obj $params -name "odj_blob_path" -type "str" -default $_default_blob_path

$extra_args = @{}
if ($null -ne $domain_username) {
    $domain_password = ConvertTo-SecureString $domain_password -AsPlainText -Force
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $domain_username, $domain_password
    $extra_args.Credential = $credential
}
if ($null -ne $domain_server) {
    $extra_args.Server = $domain_server
}

# attempt import of module
try {
    Import-Module ActiveDirectory
}
catch {
    Fail-Json -obj $result -message "The ActiveDirectory module failed to load properly: $($_.Exception.Message)"
}

If ($state -eq "present") {
    $dns_hostname = Get-AnsibleParam -obj $params -name "dns_hostname" -failifempty $true -resultobj $result
    $ou = Get-AnsibleParam -obj $params -name "ou" -failifempty $true -resultobj $result
    $distinguished_name = "CN=$name,$ou"

    $desired_state = [ordered]@{
        name = $name
        sam_account_name = $sam_account_name
        dns_hostname = $dns_hostname
        ou = $ou
        distinguished_name = $distinguished_name
        description = $description
        enabled = $enabled
        state = $state
        managed_by = $managed_by
    }
}
Else {
    $desired_state = [ordered]@{
        name = $name
        sam_account_name = $sam_account_name
        state = $state
    }
}

# ------------------------------------------------------------------------------
Function Get-InitialState($desired_state) {
    # Test computer exists
    $computer = Try {
        Get-ADComputer `
            -Identity $desired_state.sam_account_name `
            -Properties DistinguishedName, DNSHostName, Enabled, Name, SamAccountName, Description, ObjectClass, ManagedBy `
            @extra_args
    }
    Catch { $null }
    If ($computer) {
        $null, $current_ou = $computer.DistinguishedName -split '(?<=[^\\](?:\\\\)*),'
        $current_ou = $current_ou -join ','

        $initial_state = [ordered]@{
            name = $computer.Name
            sam_account_name = $computer.SamAccountName
            dns_hostname = $computer.DNSHostName
            ou = $current_ou
            distinguished_name = $computer.DistinguishedName
            description = $computer.Description
            enabled = $computer.Enabled
            state = "present"
            managed_by = $computer.ManagedBy
        }
    }
    Else {
        $initial_state = [ordered]@{
            name = $desired_state.name
            sam_account_name = $desired_state.sam_account_name
            state = "absent"
        }
    }

    return $initial_state
}

# ------------------------------------------------------------------------------
Function Set-ConstructedState($initial_state, $desired_state) {
    Try {
        Set-ADComputer `
            -Identity $desired_state.name `
            -SamAccountName $desired_state.name `
            -DNSHostName $desired_state.dns_hostname `
            -Enabled $desired_state.enabled `
            -Description $desired_state.description `
            -ManagedBy $desired_state.managed_by `
            -WhatIf:$check_mode `
            @extra_args
    }
    Catch {
        Fail-Json -obj $result -message "Failed to set the AD object $($desired_state.name): $($_.Exception.Message)"
    }

    If ($initial_state.distinguished_name -cne $desired_state.distinguished_name) {
        # Move computer to OU
        Try {
            Get-ADComputer -Identity $desired_state.sam_account_name @extra_args |
                Move-ADObject `
                    -TargetPath $desired_state.ou `
                    -Confirm:$False `
                    -WhatIf:$check_mode `
                    @extra_args
        }
        Catch {
            $msg = "Failed to move the AD object $($initial_state.distinguished_name) to $($desired_state.distinguished_name): $($_.Exception.Message)"
            Fail-Json -obj $result -message $msg
        }
    }
    $result.changed = $true
}

# ------------------------------------------------------------------------------
Function Add-ConstructedState($desired_state) {
    Try {
        New-ADComputer `
            -Name $desired_state.name `
            -SamAccountName $desired_state.sam_account_name `
            -DNSHostName $desired_state.dns_hostname `
            -Path $desired_state.ou `
            -Enabled $desired_state.enabled `
            -Description $desired_state.description `
            -ManagedBy $desired_state.managed_by `
            -WhatIf:$check_mode `
            @extra_args
    }
    Catch {
        Fail-Json -obj $result -message "Failed to create the AD object $($desired_state.name): $($_.Exception.Message)"
    }

    $result.changed = $true
}

Function Invoke-OfflineDomainJoin {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true)]
        [System.Collections.IDictionary]
        $desired_state ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('none', 'output', 'path')]
        [String]
        $Action ,

        [Parameter()]
        [System.IO.FileInfo]
        $BlobPath
    )

    End {
        if ($Action -eq 'none') {
            return
        }

        $dns_domain = $desired_state.dns_hostname -replace '^[^.]+\.'

        $output = $Action -eq 'output'

        $arguments = @(
            'djoin.exe'
            '/PROVISION'
            '/REUSE'  # we're pre-creating the machine normally to set other fields, then overwriting it with this
            '/DOMAIN'
            $dns_domain
            '/MACHINE'
            $desired_state.sam_account_name.TrimEnd('$')  # this machine name is the short name
            '/MACHINEOU'
            $desired_state.ou
            '/SAVEFILE'
            $BlobPath.FullName
        )

        $invocation = Argv-ToString -arguments $arguments
        $result.djoin = @{
            invocation = $invocation
        }
        $result.odj_blob = ''

        if ($Action -eq 'path') {
            $result.odj_blob_path = $BlobPath.FullName
        }

        if (-not $BlobPath.Directory.Exists) {
            Fail-Json -obj $result -message "BLOB path directory '$($BlobPath.Directory.FullName)' doesn't exist."
        }

        if ($PSCmdlet.ShouldProcess($argstring)) {
            try {
                $djoin_result = Run-Command -command $invocation
                $result.djoin.rc = $djoin_result.rc
                $result.djoin.stdout = $djoin_result.stdout
                $result.djoin.stderr = $djoin_result.stderr

                if ($djoin_result.rc) {
                    Fail-Json -obj $result -message "Problem running djoin.exe. See returned values."
                }

                if ($output) {
                    $bytes = [System.IO.File]::ReadAllBytes($BlobPath.FullName)
                    $data = [Convert]::ToBase64String($bytes)
                    $result.odj_blob = $data
                }
            }
            finally {
                if ($output -and $BlobPath.Exists) {
                    $BlobPath.Delete()
                }
            }
        }
    }
}

# ------------------------------------------------------------------------------
Function Remove-ConstructedState($initial_state) {
    Try {
        Get-ADComputer -Identity $initial_state.sam_account_name @extra_args |
            Remove-ADObject `
                -Recursive `
                -Confirm:$False `
                -WhatIf:$check_mode `
                @extra_args
    }
    Catch {
        Fail-Json -obj $result -message "Failed to remove the AD object $($desired_state.name): $($_.Exception.Message)"
    }

    $result.changed = $true
}

# ------------------------------------------------------------------------------
Function Test-HashtableEquality($x, $y) {
    # Compare not nested HashTables
    Foreach ($key in $x.Keys) {
        If (($y.Keys -notcontains $key) -or ($x[$key] -cne $y[$key])) {
            Return $false
        }
    }
    foreach ($key in $y.Keys) {
        if (($x.Keys -notcontains $key) -or ($x[$key] -cne $y[$key])) {
            Return $false
        }
    }
    Return $true
}

# ------------------------------------------------------------------------------
$initial_state = Get-InitialState($desired_state)

If ($desired_state.state -eq "present") {
    If ($initial_state.state -eq "present") {
        $in_desired_state = Test-HashtableEquality -X $initial_state -Y $desired_state

        If (-not $in_desired_state) {
            Set-ConstructedState -initial_state $initial_state -desired_state $desired_state
        }
    }
    Else {
        # $desired_state.state = "Present" & $initial_state.state = "Absent"
        Add-ConstructedState -desired_state $desired_state
        Invoke-OfflineDomainJoin -desired_state $desired_state -Action $odj_action -BlobPath $odj_blob_path -WhatIf:$check_mode
    }
}
Else {
    # $desired_state.state = "Absent"
    If ($initial_state.state -eq "present") {
        Remove-ConstructedState -initial_state $initial_state
    }
}

If ($diff_support) {
    $diff = @{
        before = $initial_state
        after = $desired_state
    }
    $result.diff = $diff
}

Exit-Json -obj $result
