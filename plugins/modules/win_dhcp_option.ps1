#!powershell
# Copyright: (c) 2020 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
# AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options             = @{
        type             = @{ type = "str"; choices = "server", "scope", "reservation" }
        version          = @{ type = "str"; choices = "IPv4", "IPv6"; default = "IPv4" }
        state            = @{ type = "str"; choices = "absent", "present"; default = "present" }
        scope            = @{ type = "str"; aliases = "prefix" }
        reservedip       = @{ type = "str" }
        optionid         = @{ type = "int" }
        value            = @{ type = "str" }
        VendorClass      = @{ type = "str" }
        computername     = @{ type = "str" }
        dnsserver        = @{ type = "str" } 
        dnsdomain        = @{ type = "str" } #ipv4 only
        router           = @{ type = "str" } #ipv4 only
        domainsearchlist = @{ type = "str" }
        force            = @{ type = "bool"; default = $false }
    }
    supports_check_mode = $true
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$check_mode = $module.CheckMode
$type = $module.Params.type
$version = $module.Params.version
$scope_id = $module.Params.scope
[System.UInt32]$optionid = $module.Params.optionid
$value = $module.Params.value
$domainsearchlist = $module.Params.domainsearchlist

#extraparam
$state = $module.Params.state
$reservedip = $module.Params.reservedip
$computername = $module.Params.computername #optional to specifiy another computer
$dnsserver = $module.Params.dnsserver #optional to specifiy dns server
$dnsdomain = $module.Params.dnsdomain 
$router = $module.Params.router 
$force = $module.Params.force #optional for forcing Parameter
Try {
    # Import DHCP Server PS Module
    Import-Module DhcpServer
} Catch {
    # Couldn't load the DhcpServer Module
    $module.FailJson("The DhcpServer module failed to load properly: $($_.Exception.Message)", $_)
}
$extra_param = @{}
$get_param = @{}
if($computername) { $extra_param.ComputerName = $computername }
if($computername) { $get_param.ComputerName = $computername }
if(($type -eq "scope") -and ($version -eq "IPv4") ) { 
    $extra_param.Scope = $scope_id 
    $get_param.Scope = $scope_id 
}
if(($type -eq "scope") -and ($version -eq "IPv6") ) { 
    $extra_param.Prefix = $scope_id 
    $get_param.Prefix = $scope_id 
}
  
if($type -eq "reservation") {
    $get_param.ReservedIP = $reservedip
    $extra_param.ReservedIP = $reservedip
}
if($dnsserver) { $extra_param.DnsServer = $dnsserver }

if($state -eq "present") {
    if ($version -eq "IPv4") {
        $alldhcpoptions = Get-DhcpServerv4OptionValue @get_param
    } else {
        #ipv6
        $alldhcpoptions = Get-DhcpServerv6OptionValue @get_param 
    }
    $current_release = $alldhcpoptions | Where-Object { $_.OptionId -eq $optionid } | Select-Object *
    if(((($current_release.value -eq $value) -and ($current_release.OptionId -eq $optionid)) -or (($current_release.VendorClass -eq $VendorClass) -and ($null -ne $current_release.VendorClass) ))) {
        #nothing to do here
        $module.result.changed = $false
    } else {
        if($check_mode) { $extra_param.WhatIf = $check_mode }
        if($force) { $extra_param.Force = $force }
        if($domainsearchlist) { $extra_param.DomainSearchList = $domainsearchlist }
        if($optionid) { $extra_param.OptionId = $optionid }
        if($Value) { $extra_param.Value = $Value }
        #options not set or not equal
        if($version -eq "IPv4") {
            if($dnsdomain) { $extra_param.dnsdomain = $dnsdomain }
            if($router) { $extra_param.router = $router }
            try {
                Set-DhcpServerv4OptionValue @extra_param
                $module.result.changed = $true
            } catch {
                $module.FailJson("unexpected error while adding DHCP Option: $($_.Exception.Message)", $_)
            }
        } else {
            #IPv6
            try {
                Set-DhcpServerv6OptionValue @extra_param
                $module.result.changed = $true
            } catch {
                $module.FailJson("unexpected error while adding DHCP Option: $($_.Exception.Message)", $_)
            }
        }
        # no work
    }
}
if ($state -eq "absent") {
    if ($version -eq "IPv4") {
        $alldhcpoptions = Get-DhcpServerv4OptionValue @extra_param
    } else {
        #ipv6
        $alldhcpoptions = Get-DhcpServerv6OptionValue @extra_param 
    }
    $current_release = $alldhcpoptions | Where-Object { $_.OptionId -eq $optionid } | Select-Object *
    if(((($current_release.value -eq $value) -and ($current_release.OptionId -eq $optionid)) -or (($current_release.VendorClass -eq $VendorClass) -and ($null -ne $current_release.VendorClass) ))){
        #nothing to do here
        $changes = $false
    } else {
        $changes = $true
    }
    if($changes) {
        if($check_mode) { $extra_param.WhatIf = $check_mode }
        if($force) { $extra_param.Force = $force }
        if($domainsearchlist) { $extra_param.DomainSearchList = $domainsearchlist }
        #options not set or not equal
        if($version -eq "IPv4") {
            if($dnsdomain) { $extra_param.dnsdomain = $dnsdomain }
            if($router) { $extra_param.router = $router }
            try {
                Set-DhcpServerv4OptionValue @extra_param
                $module.result.changed = $true
            } catch {
                $module.FailJson("unexpected error while adding DHCP Option : $($_.Exception.Message)", $_)
            }
        } else {
            #IPv6
            try {
                Set-DhcpServerv6OptionValue @extra_param
                $module.result.changed = $true
            } catch {
                $module.FailJson("unexpected error while removing DHCP Option : $($_.Exception.Message)", $_)
            }
        }
    } else {
        $module.result.changed = $false
        #noting to do here
    }
}
#End of Script
$module.ExitJson()