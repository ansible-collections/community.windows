#!powershell

# Copyright: (c) 2020, ライトウェルの人 <jiro.higuchi@shi-g.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic

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
    If($interface -eq "*") {
        $interface = Get-NetAdapter | Select-Object -ExpandProperty Name
    }Else {
        ForEach($Interface_name in $interface) {
            If(@(Get-NetAdapter | Where-Object Name -eq $Interface_name).Count -eq 0){
                $module.FailJson("Invalid network adapter name: $Interface_name")
            }
        }
    }

    If($state -eq "enabled"){
        $state = "True"
    }Else {
        $state = "False"
    }

    ForEach($componentID_name in $component_id) {
	    If(@(Get-NetAdapterBinding | Where-Object ComponentID -eq $componentID_name).Count -eq 0) {
	        $module.FailJson("Invalid componentID: $componentID_name")
        }
    }

    ForEach($componentID_name in $component_id) {
        ForEach($Interface_name in $interface) {
            $current_state = (Get-NetAdapterBinding | where-object {$_.Name -eq $Interface_name} | where-object {$_.ComponentID -eq $componentID_name}).Enabled
            $check_Idempotency = $true
            If ($current_state -eq $state){
                    $check_Idempotency = $false
            }

            $module.Result.changed = $module.Result.changed -or $check_Idempotency

            If($module.Result.changed) {
                If ($state -eq "True"){
                    Enable-NetAdapterBinding -Name $Interface_name -ComponentID $componentID_name -WhatIf:$check_mode
                }Else {
                    Disable-NetAdapterBinding -Name $Interface_name -ComponentID $componentID_name -WhatIf:$check_mode
                }
            }
        }
    }
    $module.ExitJson()
}
Catch {
    $excep = $_

    $module.FailJson("Exception: $($excep | out-string)")

    Throw
}
