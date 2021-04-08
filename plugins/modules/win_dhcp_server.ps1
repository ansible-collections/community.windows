#!powershell
# Copyright: (c) 2021 Sebastian Gruber (@sgruber94) ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
#AnsibleRequires -CSharpUtil Ansible.Basic
$spec = @{
    options             = @{
        type               = @{ type = "str"; choices = "scope", "exclusion"; required = $true }
        version            = @{ type = "str"; choices = "IPv4", "IPv6"; default = "IPv4" }
        scope              = @{ type = "str"; aliases = "prefix" }
        name               = @{ type = "str"; required = $true }
        valid_lifetime     = @{ type = "str" ; default = "0.04:00:00" }
        preferred_lifetime = @{ type = "str" ; default = "0.02:00:00" }
        start_range        = @{ type = "str" }
        end_range          = @{ type = "str" }
        subnet_mask        = @{ type = "str" }
        state              = @{ type = "str"; choices = "absent", "present"; default = "present" }
        dhcp_server        = @{ type = "str" }
        force              = @{ type = "bool"; default = $false }
        scope_state        = @{ type = "str"; choices = "Active", "InActive"; default = "Active" }
    }
    supports_check_mode = $true
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$check_mode = $module.CheckMode
$type = $module.Params.type
$version = $module.Params.version
$scope_id = $module.Params.scope
$startrange = $module.Params.startrange
$endrange = $module.Params.endrange
$name = $module.Params.name
$scopestate = $module.Params.scopestate # defines if the scope is activated or inactive
#extraparam
$state = $module.Params.state
$computername = $module.Params.computername #optional to specifiy another computer
$force = $module.Params.force #optional for forcing Parameter
#Scope
[System.TimeSpan]$validlifetime = $module.Params.validlifetime   #needed for IPv6 Scope
[System.TimeSpan]$preferredlifetime = $module.Params.preferredlifetime #needed for IPv6 Scope
$subnetmask = $module.Params.subnetmask #needed for IPv4 Scope
$extra_param = @{}
if ($computername) { $extra_param.ComputerName = $computername }

#ToDo: Need to validate each Param for types
$varsnotcorrect = $true
if ($type -eq "scope" -and $version -eq "IPv6" -and $null -ne $scope_id -and $null -ne $preferredlifetime -and $null -ne $validlifetime) {
    #type scope and IPV6
    $varsnotcorrect = $false
    if ($preferredlifetime -gt $validlifetime) {
        $varsnotcorrect = $true
        $msg = "The Preferred LifeTime needs to be less or equal ValidLifetime"
    }
}
if ($type -eq "scope" -and $version -eq "IPv4" -and $null -ne $scope_id -and $null -ne $subnetmask -and $null -ne $startrange) {
    #type scope and IPV6
    #nothing to do here
    $varsnotcorrect = $false
}
if ($varsnotcorrect) {
    #Exit Module when Vars not correctly specified
    $module.FailJson("Please check your Variables. $msg")
}

# Import DHCP Server PS Module
Import-Module DhcpServer
# State: Absent
if ($state -eq "absent") {
    #Remove scope
    if ($type -eq "scope") {
        $current_scope_exists = $false
        if ($version -eq "IPv4") {
            $dhcpscopes = Get-DhcpServerv4Scope @extra_param
            $current_scope = $dhcpscopes | Where-Object { $_.ScopeId -eq $scope_id } | Select-Object *
            if ($current_scope) { $current_scope_exists = $true }
        } else {
            #IPv6
            $current_scope = Get-DhcpServerv6Scope -Prefix $scope_id @extra_param
            if ($current_scope.Prefix -contains $scope_id) { $current_scope_exists = $true }
        }
        if ($check_mode) { $extra_param.WhatIf = $check_mode }
        if ($force) { $extra_param.Force = $force }
        if ($current_scope_exists -eq $false) {
            $module.Result.msg = "The scope doesn't exist."
        } else {
            # If the scope exists, we need to destroy it
            if ($version -eq "IPv4") {
                Remove-DhcpServerv4Scope -ScopeId $scope_id @extra_param
                $module.Result.changed = $true
            } else {
                #IPv6
                Remove-DhcpServerv6Scope -Prefix $scope_id @extra_param
                $module.Result.changed = $true
            }
        }
    } elseif ($type -eq "exclusion") {
        $current_exclusion_exists = $false
        if ($version -eq "IPv4") {
            $current_exclusion = Get-DhcpServerv4ExclusionRange -ScopeId $scope_id
            if (($current_exclusion.ScopeId -contains $scope_id) -and ($current_scope.StartRange -contains $startrange) -and ($current_scope.EndRange -contains $endrange)) {
                $current_exclusion_exists = $true
            }
        } else {
            #IPv6
            $current_exclusion = Get-DhcpServerv6ExclusionRange -Prefix $scope_id
            if (($current_exclusion.Prefix -contains $scope_id) -and ($current_scope.StartRange -contains $startrange) -and ($current_scope.EndRange -contains $endrange)) {
                $current_exclusion_exists = $true
            }
        }
        if ($check_mode) { $extra_param.WhatIf = $check_mode }
        if ($force) { $extra_param.Force = $force }
        #Destroy all the exclusions
        if ($current_exclusion_exists -eq $false) {
            $module.Result.msg = "The exclusion doesn't exist."
        } else {
            # If the exclusion exists, we need to destroy it
            $exclusion_param = @{
                StartRange = $startrange
                EndRange   = $endrange
            }
            if ($check_mode) { $extra_param.WhatIf = $check_mode }
            if ($version -eq "IPv4") {
                try {
                    Remove-DhcpServerv4ExclusionRange -ScopeId $scope_id @exclusion_param @extra_param
                    $module.Result.changed = $true
                } catch {
                    $module.Result.changed = $false
                    $module.FailJson("Unable to remove exclusion : $($_.Exception.Message)")
                }
            } else {
                #IPv6
                try {
                    Remove-DhcpServerv6ExclusionRange -Prefix $scope_id @exclusion_param @extra_param
                    $module.Result.changed = $true
                } catch {
                    $module.Result.changed = $false
                    $module.FailJson("Unable to remove exclusion : $($_.Exception.Message)")
                }
            }
        }
    } else {
        #no type found
        $module.FailJson("Unable to determinate type")
    }
}
# State: Present
if ($state -eq "present") {
    #creating /edit scope
    if ($type -eq "scope") {
        if ($version -eq "IPv4") {
            $dhcpscopes = Get-DhcpServerv4Scope @extra_param
            $current_scope = $dhcpscopes | Where-Object { $_.ScopeId -eq $scope_id } | Select-Object *
        } else {
            #IPv6
            $dhcpscopes = Get-DhcpServerv6Scope @extra_param
            $current_scope = $dhcpscopes | Where-Object { $_.Prefix -eq $scope_id } | Select-Object *
        }
        if ($current_scope) {
            $current_scope_exists = $true
        } else {
            $current_scope_exists = $false
        }
        if ($current_scope_exists -eq $false) {

            $extra_param.state = $scopestate
            if ($name) { $extra_param.name = $name }
            if ($version -eq "IPv4") {
                #Scope does not exist we need to create it
                $extra_param.StartRange = $startrange
                $extra_param.EndRange = $endrange
                $extra_param.SubnetMask = $subnetmask
                Add-DhcpServerv4Scope @extra_param
                $module.Result.changed = $true
            } else {
                #IPv6
                if ($validlifetime) { $extra_param.validlifetime = $validlifetime }
                if ($preferredlifetime) { $extra_param.preferredlifetime = $preferredlifetime }
                Add-DhcpServerv6Scope -Prefix $scope_id @extra_param
                $module.Result.changed = $true
            }
        } else {
            # If the scope exist, we need to compare it
            if ($version -eq "IPv4") {
                #ToDo: Add Check
            } else {
                #IPv6
            }
        }
    } elseif ($type -eq "exclusion") {
        $current_exclusion_exists = $false
        if ($version -eq "IPv4") {
            $current_exclusion = Get-DhcpServerv4ExclusionRange -ScopeId $scope_id
            if (($current_exclusion.ScopeId -contains $scope_id) -and ($current_scope.StartRange -contains $startrange) -and ($current_scope.EndRange -contains $endrange)) {
                $current_exclusion_exists = $true
            }
        } else {
            #IPv6
            $current_exclusion = Get-DhcpServerv6ExclusionRange -Prefix $scope_id
            if (($current_exclusion.Prefix -contains $scope_id) -and ($current_scope.StartRange -contains $startrange) -and ($current_scope.EndRange -contains $endrange)) {
                $current_exclusion_exists = $true
            }
        }
        #Create/edit all the exclusions
        if ($current_exclusion_exists -eq $false) {
            $exclusion_param = @{
                StartRange = $startrange
                EndRange   = $endrange
            }
            if ($version -eq "IPv4") {
                Add-DhcpServerv4ExclusionRange -ScopeId $scope_id @exclusion_param
                $module.Result.changed = $true
            } else {
                #IPv6

                Add-DhcpServerv6ExclusionRange -Prefix $scope_id @exclusion_param
                $module.Result.changed = $true
            }
        } else {
            # If the exclusion exists, we need to compare it
        }
    } else {
        #no type found
        $module.FailJson("Unable to determinate type")
    }
}
$module.ExitJson()