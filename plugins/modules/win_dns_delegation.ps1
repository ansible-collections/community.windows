#!powershell
# Copyright: (c) 2021 Sebastian Gruber (@sgruber94) ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options             = @{
        name        = @{ type = "str"; required = $true }
        parent_zone        = @{ type = "str"; required = $true }
        state       = @{ type = "str"; choices = "absent", "present"; default = "present" }
        name_server = @{ type = "str" }
        ip_address  = @{ type = "list"; elements = "str" }
    }
    supports_check_mode = $true
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$check_mode = $module.CheckMode
$name = $module.Params.name
$zone = $module.Params.parent_zone
$state = $module.Params.state
$NameServer = $module.Params.name_server
$IPAddress = $module.Params.ip_address

$parms = @{
    Name          = $zone
    ChildZoneName = $name
}
if ($check_mode) { $parms.WhatIf = $check_mode }
# Import DNS Server PS Module
Import-Module DNSServer

#check if delegated zone exists
$delegationzone = Get-DnsServerZoneDelegation -Name $zone | where-Object ChildZoneName -like "$name*"

if ($state -eq "present") {
    $parms.NameServer = $NameServer
    $parms.IPAddress = $IPAddress
    #check if exist
    if ($delegationzone) {
        if ($delegationzone[0].NameServer.RecordData.NameServer.trim(".") -notmatch $nameserver) {
            Add-DnsServerZoneDelegation @parms -PassThru -Confirm:$false
            $module.Result.changed = $true
        } else {
            #entry exist need to compare
            $addressv4 = $delegationzone[0].IPAddress.RecordData.IPV4Address.IPAddressToString
            $addressv6 = $delegationzone[0].IPAddress.RecordData.IPV6Address.IPAddressToString
            if ($addressv4) {
                $diffnsipv4 = Compare-Object -ReferenceObject $addressv4 -DifferenceObject $ipaddress
            }
            if ($addressv6) {
                $diffnsipv6 = Compare-Object -ReferenceObject $addressv6 -DifferenceObject $ipaddress
            }
            if (($diffnsipv4.count -gt 0) -or ($diffnsipv6.count -gt 0 )) {
                #changing ip address
                Set-DnsServerZoneDelegation @parms -Confirm:$false
                $module.Result.changed = $true
            } else {
                $module.Result.changed = $false
            }
        }
    } else {
        #create dns delegation
        Add-DnsServerZoneDelegation @parms -PassThru -Confirm:$false
        $module.Result.changed = $true
    }
}

if ($state -eq "absent") {
    if ($delegationzone) {
        #remove dns zone delegation
        Remove-DnsServerZoneDelegation @parms -PassThru -Confirm:$false
        $module.Result.changed = $true
    } else {
        #nothing to do
        $module.Result.changed = $false
    }
}
$module.ExitJson()