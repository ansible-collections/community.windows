#!powershell
# Copyright: (c) 2021 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
# AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options             = @{
        type               = @{ type = "str"; choices = "server", "scope", "reservation"; required = $true }
        version            = @{ type = "str"; choices = "IPv4", "IPv6"; default = "IPv4" }
        state              = @{ type = "str"; choices = "absent", "present"; default = "present" }
        scope              = @{ type = "str"; aliases = "prefix" }
        reserved_ip        = @{ type = "str" }
        option_id          = @{ type = "int" }
        value              = @{ type = "str" }
        vendor_class       = @{ type = "str" }
        computer_name      = @{ type = "str" }
        dns_server         = @{ type = "str" }
        dns_domain         = @{ type = "str" } #ipv4 only
        router             = @{ type = "str" } #ipv4 only
        domain_search_list = @{ type = "str" }
        force              = @{ type = "bool"; default = $false }
    }
    supports_check_mode = $true
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$check_mode = $module.CheckMode
$type = $module.Params.type
$version = $module.Params.version
$scope_id = $module.Params.scope
[System.UInt32]$optionid = $module.Params.option_id
$value = $module.Params.value
$domainsearchlist = $module.Params.domain_search_list

#extraparam
$state = $module.Params.state
$reservedip = $module.Params.reserved_ip
$computername = $module.Params.computer_name #optional to specifiy another computer
$dnsserver = $module.Params.dns_server #optional to specifiy dns server
$dnsdomain = $module.Params.dns_domain
$router = $module.Params.router
$force = $module.Params.force #optional for forcing Parameter

Import-Module DhcpServer
$extra_param = @{}
$get_param = @{}
if ($computername) { $extra_param.ComputerName = $computername }
if ($computername) { $get_param.ComputerName = $computername }
if (($type -eq "scope") -and ($version -eq "IPv4") ) {
    $extra_param.Scope = $scope_id
    $get_param.Scope = $scope_id
}
if (($type -eq "scope") -and ($version -eq "IPv6") ) {
    $extra_param.Prefix = $scope_id
    $get_param.Prefix = $scope_id
}

if ($type -eq "reservation") {
    $get_param.ReservedIP = $reservedip
    $extra_param.ReservedIP = $reservedip
}
if ($dnsserver) { $extra_param.DnsServer = $dnsserver }

if ($state -eq "present") {
    if ($version -eq "IPv4") {
        $alldhcpoptions = Get-DhcpServerv4OptionValue @get_param
    } else {
        #ipv6
        $alldhcpoptions = Get-DhcpServerv6OptionValue @get_param
    }
    $current_release = $alldhcpoptions | Where-Object { $_.OptionId -eq $optionid } | Select-Object *
    if (((($current_release.value -eq $value) -and ($current_release.OptionId -eq $optionid)) -or (($current_release.VendorClass -eq $VendorClass) -and ($null -ne $current_release.VendorClass) ))) {
        #nothing to do here
        $module.result.changed = $false
    } else {
        if ($check_mode) { $extra_param.WhatIf = $check_mode }
        if ($force) { $extra_param.Force = $force }
        if ($domainsearchlist) { $extra_param.DomainSearchList = $domainsearchlist }
        if ($optionid) { $extra_param.OptionId = $optionid }
        if ($Value) { $extra_param.Value = $Value }
        #options not set or not equal
        if ($version -eq "IPv4") {
            if ($dnsdomain) { $extra_param.dnsdomain = $dnsdomain }
            if ($router) { $extra_param.router = $router }
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
    if (((($current_release.value -eq $value) -and ($current_release.OptionId -eq $optionid)) -or (($current_release.VendorClass -eq $VendorClass) -and ($null -ne $current_release.VendorClass) ))) {
        #nothing to do here
        $changes = $false
    } else {
        $changes = $true
    }
    if ($changes) {
        if ($check_mode) { $extra_param.WhatIf = $check_mode }
        if ($force) { $extra_param.Force = $force }
        if ($domainsearchlist) { $extra_param.DomainSearchList = $domainsearchlist }
        #options not set or not equal
        if ($version -eq "IPv4") {
            if ($dnsdomain) { $extra_param.dnsdomain = $dnsdomain }
            if ($router) { $extra_param.router = $router }
            Set-DhcpServerv4OptionValue @extra_param
            $module.result.changed = $true
        } else {
            #IPv6
            Set-DhcpServerv6OptionValue @extra_param
            $module.result.changed = $true
        }
    } else {
        $module.result.changed = $false
        #noting to do here
    }
}
$module.ExitJson()