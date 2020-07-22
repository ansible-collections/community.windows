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

$params = Parse-Args $args -supports_check_mode $true
$Interface_name = Get-AnsibleParam -obj $params -name "Interface" -type "str"
$status = Get-AnsibleParam -obj $params -name status -type "str"
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false

$result = @{
    changed = $false
}

If(!$Interface_name) { Fail-Json -message "Absolute Interface is not specified for Interface" }
If(!$status) { Fail-Json -message "Absolute status is not specified for status" }

If ($status -eq 'enable'){
    $status = $true
}ElseIf ($status -eq 'disable') {
    $status = $false
}Else {
    Fail-Json -message "Specify the status as 'enable' or 'disable'"
}


$Interfaces = @($Interface_name)

Try {
    If($Interface_name -eq "*") {
        $Interfaces = Get-NetAdapter | Select-Object -ExpandProperty Name
    }ElseIf(@(Get-NetAdapter | Where-Object Name -eq $Interface_name).Count -eq 0) {
        Fail-Json -message "Invalid network adapter name: $Interface_name"
    }

    ForEach($Interface_name in $Interfaces) {
        $current_status = (Get-NetAdapterBinding | where-object {$_.Name -match $Interface_name} | where-object {$_.ComponentID -match "ms_tcpip6"}).Enabled
        $check_Idempotency = $true
        If ($current_status -eq ""){
            If ($current_status -eq $status){
                $check_Idempotency = $false
            }
        } ElseIf ($current_status -eq $status){
            $check_Idempotency = $false
        }

        $result.changed = $result.changed -or $check_Idempotency

        If($result.changed) {
            If ($status -eq $true){
                Enable-NetAdapterBinding -Name $Interface_name -ComponentID ms_tcpip6 -WhatIf:$check_mode
            }Else {
                Disable-NetAdapterBinding -Name $Interface_name -ComponentID ms_tcpip6 -WhatIf:$check_mode
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

