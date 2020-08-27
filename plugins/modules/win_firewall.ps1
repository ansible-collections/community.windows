#!powershell

# Copyright: (c) 2017, Michael Eaton <meaton@iforium.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#Requires -Module Ansible.ModuleUtils.Legacy

$ErrorActionPreference = "Stop"
$firewall_profiles = @('Domain', 'Private', 'Public')

$params = Parse-Args $args -supports_check_mode $true
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false

$profiles = Get-AnsibleParam -obj $params -name "profiles" -type "list" -default @("Domain", "Private", "Public")
$state = Get-AnsibleParam -obj $params -name "state" -type "str" -failifempty $true -validateset 'disabled','enabled'
$inbound = Get-AnsibleParam -obj $params -name "inbound" -type "str" -default "Block"
$outbound = Get-AnsibleParam -obj $params -name "outbound" -type "str" -default "Allow"

$result = @{
    changed = $false
    profiles = $profiles
    state = $state
    inbound = $inbound
    outbound = $outbound
}

try {
    get-command Get-NetFirewallProfile > $null
    get-command Set-NetFirewallProfile > $null
}
catch {
    Fail-Json $result "win_firewall requires Get-NetFirewallProfile and Set-NetFirewallProfile Cmdlets."
}

Try {

    ForEach ($profile in $firewall_profiles) {

        $currentstate = (Get-NetFirewallProfile -Name $profile).Enabled
        $current_inboundaction = (Get-NetFirewallProfile -Name $profile).DefaultInboundAction
        $current_outboundaction = (Get-NetFirewallProfile -Name $profile).DefaultOutboundAction
        $result.$profile = @{
            enabled = ($currentstate -eq 1)
            considered = ($profiles -contains $profile)
            currentstate = $currentstate
        }

        if ($profiles -notcontains $profile) {
            continue
        }

        if ($state -eq 'enabled') {

            if ($currentstate -eq $false) {
                Set-NetFirewallProfile -name $profile -Enabled true -WhatIf:$check_mode
                $result.changed = $true
                $result.$profile.enabled = $true
            }
            if ($inbound -ne $current_inboundaction) {
                Set-NetFirewallProfile -name $profile -DefaultInboundAction $inbound
                $result.inbound = $inbound
                $result.changed = $true
            }
            if ($outbound -ne $current_outboundaction) {
                Set-NetFirewallProfile -name $profile -DefaultOutboundAction $outbound
                $result.outbound = $outbound
                $result.changed = $true
            }

        } else {

            if ($currentstate -eq $true) {
                Set-NetFirewallProfile -name $profile -Enabled false -WhatIf:$check_mode
                $result.changed = $true
                $result.$profile.enabled = $false
            }

        }
    }
} Catch {
    Fail-Json $result "an error occurred when attempting to change firewall status for profile $profile $($_.Exception.Message)"
}

Exit-Json $result
