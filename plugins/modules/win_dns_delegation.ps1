#!powershell
# Copyright: (c) 2020 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
# AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options             = @{
        name       = @{ type = "str"; required = $true }
        zone       = @{ type = "str"; required = $true }
        state      = @{ type = "str"; choices = "absent", "present"; default = "present" }
        NameServer = @{ type = "str" }
        IPAddress  = @{ type = "list"; elements = "str" }
    }
    supports_check_mode = $true
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$check_mode = $module.CheckMode
$name = $module.Params.name
$zone = $module.Params.zone
$state = $module.Params.state
$NameServer = $module.Params.NameServer
$IPAddress = $module.Params.IPAddress


$parms = @{ 
    Name          = $zone
    ChildZoneName = $name
}

try {
    $delegationzone = Get-DnsServerZoneDelegation @parms 
} catch {
}


if ($state -eq "present") {
    $parms.NameServer = $NameServer
    $parms.IPAddress = $IPAddress
    if($check_mode) { $parms.WhatIf = $check_mode }
    #check if exist
    if($delegationzone) {
        if($delegationzone[0].NameServer.RecordData.NameServer.trim(".") -notmatch $nameserver) {
            try {
                Add-DnsServerZoneDelegation @parms -PassThru -Confirm:$false
                $module.Result.changed = $true
            } catch {
                $module.FailJson("Failed to add dns delegation zone $($name): $($_.Exception.Message)", $_)
            }
    
        }else {
            #entry exist need to compare
        $addressv4 = $delegationzone[0].IPAddress.RecordData.IPV4Address.IPAddressToString
        $addressv6 = $delegationzone[0].IPAddress.RecordData.IPV6Address.IPAddressToString
        if($addressv4) {  
            try {
                $diffnsipv4 = Compare-Object -ReferenceObject $addressv4 -DifferenceObject $ipaddress
            } catch {
                $module.FailJson("Failed to compare delegation NameServer zone $($name): $($_.Exception.Message)", $_)
            }  
        }
        if($addressv6) {  
            try {
                $diffnsipv6 = Compare-Object -ReferenceObject $addressv6 -DifferenceObject $ipaddress
            } catch {
                $module.FailJson("Failed to compare delegation NameServer zone $($name): $($_.Exception.Message)", $_)
            }  
        }
        if(($diffnsipv4.count -gt 0) -or ($diffnsipv6.count -gt 0 )) {
            try {
                #changing ip address
                Set-DnsServerZoneDelegation @parms -Confirm:$false
                $module.Result.changed = $true
            } catch {
                $module.FailJson("Failed to change dns Server zone $($name): $($_.Exception.Message)", $_)
            }
        } else {
            $module.Result.changed = $false
        }
        }
    } 
 else {
        #create dns delegation
        try {
            Add-DnsServerZoneDelegation @parms -PassThru -Confirm:$false
            $module.Result.changed = $true
        } catch {
            $module.FailJson("Failed to add dns delegation zone $($name): $($_.Exception.Message)", $_)
        }
    }
}

if ($state -eq "absent") {
    if($check_mode) { $parms.WhatIf = $check_mode }
    if($delegationzone) {
        #remove dns zone delegation
        try {
            Remove-DnsServerZoneDelegation @parms -PassThru -Confirm:$false
            $module.Result.changed = $true
        } catch {
            $module.FailJson("Failed to remove dns delegation zone $($name): $($_.Exception.Message)", $_)
        }
    } else {
        #nothing to do
        $module.Result.changed = $false
    }
}
$module.ExitJson()