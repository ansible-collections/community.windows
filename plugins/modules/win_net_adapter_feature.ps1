#!powershell

# Copyright: (c) 2020, ライトウェルの人 <jiro.higuchi@shi-g.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

$spec = @{
    options = @{
        interface = @{ type = 'list'; elements = 'str'; required = $true }
        state = @{ type = 'str'; choices = 'disabled', 'enabled'; default = 'enabled' }
        component_id = @{ type = 'list'; elements = 'str'; required = $true }
    }
    supports_check_mode = $true
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$interface = $module.Params.interface
$state = $module.Params.state
$component_id = $module.Params.component_id
$check_mode = $module.CheckMode

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
