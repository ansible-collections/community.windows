#!powershell
#
# (c) 2020, ライトウェルの人 <@jirolin>
#
# This file is part of Ansible
#
# Ansible is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ansible is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ansible. If not, see <http://www.gnu.org/licenses/>.
#
# WANT_JSON
# POWERSHELL_COMMON
# temporarily disable strictmode, for this module only
#Requires -Module Ansible.ModuleUtils.Legacy

$ErrorActionPreference = "Stop"

$Interface_name = [string[]]
$componentID_name = [string[]]
$params = Parse-Args $args -supports_check_mode $true
#$Interface_name = Get-AnsibleParam -obj $params -name "Interface" -type "str"
$Interface_name = Get-AnsibleParam -obj $params -name "Interface"
$state = Get-AnsibleParam -obj $params -name state -type "str"
#$componentID_name = Get-AnsibleParam -obj $params -name "componentID" -type "str"
$componentID_name = Get-AnsibleParam -obj $params -name "componentID"
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false

$result = @{
    changed = $false
}

If(!$Interface_name) { Fail-Json -message "Absolute Interface is not specified for Interface" }
If(!$state) { Fail-Json -message "Absolute state is not specified for state" }
If(!$componentID_name) { Fail-Json -message "Absolute componentID is not specified for componentID" }

If ($state -eq 'enable'){
    $state = $true
}ElseIf ($state -eq 'disable') {
    $state = $false
}Else {
    Fail-Json -message "Specify the state as 'enable' or 'disable'"
}

If($Interface_name -is [string]) {
    If($Interface_name.Length -gt 0) {
        $Interfaces = @($Interface_name)
    }
    Else {
        $Interfaces = @()
    }
}
Else {
        $Interfaces = $Interface_name
}

If($componentID_name -is [string]) {
    If($componentID_name.Length -gt 0) {
        $componentIDs = @($componentID_name)
    }
    Else {
        $componentIDs = @()
    }
}
Else {
    $componentIDs = $componentID_name
}

Try {
    If($Interface_name -eq "*") {
        $Interfaces = Get-NetAdapter | Select-Object -ExpandProperty Name
    }
    else {
        ForEach($Interface_name in $Interfaces) {
        	If(@(Get-NetAdapter | Where-Object Name -eq $Interface_name).Count -eq 0){
                Fail-Json -message "Invalid network adapter name: $Interface_name"
            }
        }
    }

    ForEach($componentID_name in $componentIDs) {
	    If(@(Get-NetAdapterBinding | Where-Object ComponentID -eq $componentID_name).Count -eq 0) {
	        Fail-Json -message "Invalid componentID: $componentID_name"
        }
    }

    ForEach($componentID_name in $componentIDs) {
        ForEach($Interface_name in $Interfaces) {
            $current_state = (Get-NetAdapterBinding | where-object {$_.Name -match $Interface_name} | where-object {$_.ComponentID -match $componentID_name}).Enabled
            $check_Idempotency = $true
            If ($current_state -eq ""){
                If ($current_state -eq $state){
                    $check_Idempotency = $false
                }
            } ElseIf ($current_state -eq $state){
                $check_Idempotency = $false
            }

            $result.changed = $result.changed -or $check_Idempotency

            If($result.changed) {
                If ($state -eq $true){
                    Enable-NetAdapterBinding -Name $Interface_name -ComponentID $componentID_name -WhatIf:$check_mode
                }Else {
                    Disable-NetAdapterBinding -Name $Interface_name -ComponentID $componentID_name -WhatIf:$check_mode
                }
            }
        }
    }
    Exit-Json $result
}
Catch {
    $excep = $_

    Fail-Json -message "Exception: $($excep | out-string)"

    Throw
}

