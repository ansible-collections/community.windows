#!powershell

# Copyright: (c) 2022, Raphaël POURCHASSE
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#Requires -Module Ansible.ModuleUtils.Legacy

$ErrorActionPreference = "Stop"

$params = Parse-Args -arguments $args -supports_check_mode $true
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false

$name = Get-AnsibleParam -obj $params -name "name" -type "str" -failifempty $true
$state = Get-AnsibleParam -obj $params -name "state" -type "str" -default "present" -validateset "present", "absent","update"
$description = Get-AnsibleParam -obj $params -name "description" -type "str"
$precedence = Get-AnsibleParam -obj $params -name "precedence" -type "str"
$passwordhistorycount = Get-AnsibleParam -obj $params -name "passwordhistorycount" -type "int"
$lockoutduration = Get-AnsibleParam -obj $params -name "lockoutduration" -type "TimeSpan"
$lockoutobservationwindows = Get-AnsibleParam -obj $params -name "lockoutobservationwindows" -type "TimeSpan"
$lockoutthreshold = Get-AnsibleParam -obj $params -name "lockoutthreshold" -type "TimeSpan"
$maxpasswordage = Get-AnsibleParam -obj $params -name "maxpasswordage" -type "TimeSpan"
$minpasswordage = Get-AnsibleParam -obj $params -name "minpasswordage" -type "TimeSpan"
$minpasswordlength = Get-AnsibleParam -obj $params -name "minpasswordlength" -type "int"
$reversibleencryptionenabled = Get-AnsibleParam -obj $params -name "reversibleencryption" -type "bool" -validateset "true","false"
$group = Get-AnsibleParam -obj $params -name "group" -type "str"
$complexityenabled = Get-AnsibleParam -obj $params -name "complexityenabled" -type "str"

$result = @{
    changed = $false
    created = $false
}

if (-not (Get-Module -Name ActiveDirectory -ListAvailable)) {
    Fail-Json $result "win_domain_pso requires the ActiveDirectory PS module to be installed"
}
else
{
    Import-Module ActiveDirectory
}


try {
    $pso_obj = Get-ADFineGrainedPasswordPolicy -Identity $name
    $pso_guid = $pso_obj.ObjectGUID
}
catch {
    $pso_obj = $null
    $pso_guid = $null
}
if ($state -eq "absent") {
    if ($null -ne $pso_obj) {
        try {
            $pso_obj | Remove-ADFineGrainedPasswordPolicy -Confirm:$false -WhatIf:$check_mode
            $result.changed = $true
        }
        catch {
            Fail-Json $result "failed to remove Password Settings Objects $($name)"
        }
    }
}
If ($state -eq 'present') {
    If (-not $pso_obj) {
        $create_args = @{}
        $create_args.Name = $name
        If ($null -ne $complexityenabled) {
            $create_args.complexityenabled = $complexityenabled
        }
        If ($null -ne $MaxPasswordAge) {
            $create_args.MaxPasswordAge = $MaxPasswordAge
        }
        If ($null -ne $MinPasswordAge) {
            $create_args.MinPasswordAge = $MinPasswordAge
        }
        If ($null -ne $MinPasswordLength) {
            $create_args.MinPasswordLength = $MinPasswordLength
        }
        If ($null -ne $Precedence) {
            $create_args.Precedence = $Precedence
        }
        If ($null -ne $passwordhistorycount) {
            $create_args.passwordhistorycount = $passwordhistorycount
        }
        If ($null -ne $lockoutduration) {
            $create_args.lockoutduration = $lockoutduration
        }
       If ($null -ne $lockoutobservationwindows) {
            $create_args.lockoutobservationwindows = $lockoutobservationwindows
        }
       If ($null -ne $lockoutthreshold) {
            $create_args.lockoutthreshold = $lockoutthreshold
        }
       If ($null -ne $reversibleencryptionenabled) {
            $create_args.reversibleencryptionenabled = $reversibleencryptionenabled
        }

        $pso_obj = New-ADFineGrainedPasswordPolicy @create_args -WhatIf:$check_mode
        $pso_obj_guid = $pso_obj.ObjectGUID
        $result.created = $true
        $result.changed = $true

        If ($null -ne $group) {
            $create_args.group = $group
            Add-ADFineGrainedPasswordPolicySubject -Identity $name -Subjects $group
        }
        If ($check_mode) {
            Exit-Json $result
        }
        $pso_obj = Get-ADFineGrainedPasswordPolicy -Identity $name    
    }
}

If ($state -eq 'update') {
    If (-not $pso_obj) {
        $create_args = @{}
        $create_args.Name = $name
        If ($null -ne $complexityenabled) {
            $create_args.complexityenabled = $complexityenabled
        }
        If ($null -ne $MaxPasswordAge) {
            $create_args.MaxPasswordAge = $MaxPasswordAge
        }
        If ($null -ne $MinPasswordAge) {
            $create_args.MinPasswordAge = $MinPasswordAge
        }
        If ($null -ne $MinPasswordLength) {
            $create_args.MinPasswordLength = $MinPasswordLength
        }
        If ($null -ne $Precedence) {
            $create_args.Precedence = $Precedence
        }
        If ($null -ne $passwordhistorycount) {
            $create_args.passwordhistorycount = $passwordhistorycount
        }
        If ($null -ne $lockoutduration) {
            $create_args.lockoutduration = $lockoutduration
        }
       If ($null -ne $lockoutobservationwindows) {
            $create_args.lockoutobservationwindows = $lockoutobservationwindows
        }
       If ($null -ne $lockoutthreshold) {
            $create_args.lockoutthreshold = $lockoutthreshold
        }
       If ($null -ne $reversibleencryptionenabled) {
            $create_args.reversibleencryptionenabled = $reversibleencryptionenabled
        }
        $pso_obj = Set-ADFineGrainedPasswordPolicy @create_args -WhatIf:$check_mode
        $pso_obj_guid = $pso_obj.ObjectGUID
        $result.created = $true
        $result.changed = $true

        If ($null -ne $group) {
            $create_args.group = $group
            Add-ADFineGrainedPasswordPolicySubject -Identity $name -Subjects $group
        }
        If ($check_mode) {
            Exit-Json $result
        }
        $pso_obj = Get-ADFineGrainedPasswordPolicy -Identity $name    
    }
}
Exit-Json $result
