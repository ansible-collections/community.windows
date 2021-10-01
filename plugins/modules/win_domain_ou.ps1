#!powershell

# Copyright: (c) 2020 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic
#Requires -Module ActiveDirectory

$spec = @{
    options = @{
        state = @{ type = "str"; choices = @("absent", "present"); default = "present" }
        name = @{ type = "str"; required = $true }
        protected = @{ type = "bool"; default = $false }
        path = @{ type = "str"; required = $false }
        filter = @{type = "str"; default = '*' }
        recursive = @{ type = "bool"; default = $false }
        domain_username = @{ type = "str"; }
        domain_password = @{ type = "str"; no_log = $true }
        domain_server = @{ type = "str" }
        properties = @{ type = "dict" }
    }
    required_together = @(
            ,@('domain_password', 'domain_username')
        )
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$extra_args = @{}
$onboard_extra_args = @{}
if ($null -ne $module.Params.domain_username) {
    $domain_password = ConvertTo-SecureString $module.Params.domain_password -AsPlainText -Force
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $module.Params.domain_username, $domain_password
    $extra_args.Credential = $credential
    $onboard_extra_args.Credential = $credential
}
if ($null -ne $module.Params.domain_server) {
    $extra_args.Server = $module.Params.domain_server
    $onboard_extra_args.Server = $module.Params.domain_server
}
if ($module.Params.properties.count -ne 0){
    $Properties = New-Object Collections.Generic.List[string]
    $module.Params.properties.Keys | Foreach-Object{
        $Properties.Add($_)
    }
    $extra_args.Properties = $Properties
}else{
    $extra_args.Properties = '*'
    $Properties = '*'
}

$extra_args.Filter = $module.Params.filter
$check_mode = $module.CheckMode
$name = $module.Params.name
$protected = $module.Params.protected
$path = $module.Params.path
$state = $module.Params.state
$recursive = $module.Params.recursive

# setup Dynamic Params
$params = @{}
if ($module.Params.properties.count -ne 0){
    $module.Params.properties.Keys | ForEach-Object{
        $params.Add($_,$module.Params.properties.Item($_))
    }
}

Function Compare-OuObject {
    Param(
        $module
    )
    # check for deleted ou
    if ($null -eq $module.diff.after -and $null -ne $module.diff.before ){
        return $true
    }
    # check for created ou
    if ($null -eq $module.diff.before -and $null -ne $module.diff.after){
        return $true
    }
    # check for changed ou
    if ($module.Params.properties.Count -ne 0){
        $Properties = New-Object Collections.Generic.List[string]
        $changed = $($module.Params.properties.Keys | ForEach-Object{
            if ($module.diff.before.Item($_) -ne $module.diff.after.item($_)){
                return $true
                break
            }
            if ($module.diff.after.Item($_) -ne $module.diff.before.item($_)){
                return $true
                break
            }
            $Properties.Add($_)
        })
        if ($changed){
            return $true
        }
        $x = Compare-Object -ReferenceObject $module.diff.before -DifferenceObject $module.diff.after -Property $Properties
        if ($x.Count -ne 0){
            return $true
        }
        # $module.FailJson("Found Properties by count greater than 0 but did not find a change count: $($module.Params.properties.Count) keys: $($module.Params.properties.keys)")
    }
    # check for difference when properties is *
    $x = Compare-Object -ReferenceObject $module.diff.before -DifferenceObject $module.diff.after
    if ($x.Count -ne 0){
      return $true
    }
    return $false
}

Function Get-SimulatedOu {
    Param($Object)
    $params = @{
        Name = $Object.name
        DistinguishedName = "OU=$($Object.name),$($Object.path)"
        ProtectedFromAccidentalDeletion = $Object.protected
    }
    if ($Object.properties) {
        if ($Object.properties.description) { $params.Description = $Object.properties.description }
        if ($Object.properties.city) { $params.City = $Object.properties.city }
        if ($Object.properties.state) { $params.State = $Object.properties.state }
        if ($Object.properties.street_address) { $params.StreetAddress = $Object.properties.street_address }
        if ($Object.properties.postal_code) { $params.PostalCode = $Object.properties.postal_code }
        if ($Object.properties.country) { $params.Country = $Object.properties.country }
        if ($Object.properties.managed_by) { $params.ManagedBy = $Object.properties.managed_by }
    }
    # convert to psobject & return
    [PSCustomObject]$params
}

Function Get-OuObject {
    Param([PSObject]$Object)
    $obj = $Object | Select-Object -Property * -ExcludeProperty nTSecurityDescriptor | ConvertTo-Json -Depth 1 | ConvertFrom-Json
    return $obj
}

# attempt import of module
Try { Import-Module ActiveDirectory }
Catch { $module.FailJson("The ActiveDirectory module failed to load properly: $($_.Exception.Message)", $_) }

Try{
    $all_ous = Get-ADOrganizationalUnit @extra_args
}Catch{$module.FailJson("Get-ADOrganizationalUnit failed: $($_.Exception.Message)", $_) }

# set path if not defined to base domain
if ($null -eq $path){
    if ($($all_ous | Measure-Object | Select-Object -ExpandProperty Count) -eq 1){
        $matched = $all_ous.DistinguishedName -match "DC=.+"
    }elseif ($($all_ous | Measure-Object | Select-Object -ExpandProperty Count) -gt 1) {
        $matched = $all_ous[0].DistinguishedName -match "DC=.+"
    }else{
        $module.FailJson("Path was null and unable to determine default domain $($_.Exception.Message)")
    }
    if ($matched){
        $path = $matches.Values[0]
    }else{
        $module.FailJson("Unable to find default domain $($_.Exception.Message)")
    }
}
$module.Result.path = $path

# determine if requested OU exist
Try {
    $current_ou = $all_ous | Where-Object {
            $_.DistinguishedName -eq "OU=$name,$path"}
    $module.Diff.before = $current_ou
    $module.Result.ou = Get-OuObject $module.Diff.before
} Catch {
    $module.Diff.before = $null
    $current_ou = $null
}
if ($state -eq "present") {
    # ou does not exist, create object
    if(-not $current_ou) {
        $params.Name = $name
        $params.Path = $path
        $module.Result.params = $params
        Try {
            New-ADOrganizationalUnit @params @onboard_extra_args -ProtectedFromAccidentalDeletion $protected -WhatIf:$check_mode
        }Catch {
            $module.FailJson("Failed to create organizational unit: $($_.Exception.Message)", $_)
        }
    }
    # ou exists, update object
    if ($current_ou) {
        Try {
            Set-ADOrganizationalUnit -Identity "OU=$name,$path" @params @onboard_extra_args -WhatIf:$check_mode
        }Catch {
            $module.FailJson("Failed to update organizational unit: $($_.Exception.Message)", $_)
        }
    }
}

if ($state -eq "absent") {
    # ou exists, delete object
    if ($current_ou -and -not $check_mode) {
        Try {
            # override protected from accidental deletion
            Set-ADOrganizationalUnit -Identity "OU=$name,$path" -ProtectedFromAccidentalDeletion $false @onboard_extra_args -Confirm:$False -WhatIf:$check_mode
        }Catch{
            $module.FailJson("Failed to remove ProtectedFromAccidentalDeletion Lock: $($_.Exception.Message)", $_)
        }
            # check recursive deletion
        if ($recursive) {
            try{
                Remove-ADOrganizationalUnit -Identity "OU=$name,$path" -Confirm:$False -WhatIf:$check_mode -Recursive @onboard_extra_args
            }catch{
                $module.FailJson("Failed to recursively Remove-ADOrganizationalUnit $($_.Exception.Message)", $_)
            }
        }else{
            try{
                Remove-ADOrganizationalUnit -Identity "OU=$name,$path" -Confirm:$False -WhatIf:$check_mode @onboard_extra_args
            }Catch{
                $module.FailJson("Failed to Remove-ADOrganizationalUnit: $($_.Exception.Message)", $_)
            }
        }
    }
}

# determine if a change was made
if (-not $check_mode) {
    try{
        $new_ou = Get-ADOrganizationalUnit @extra_args | Where-Object {
            $_.DistinguishedName -eq "OU=$name,$path"
        }
    }catch{
        if ($state -eq "absent"){
            $new_ou = $null
        }else{
            $module.FailJson("Failed to Get-ADOrganizationalUnit: $($_.Exception.Message)", $_)
        }
    }
    $module.Diff.after = $new_ou
    $module.Result.ou = Get-OuObject $module.Diff.after
    # compare old/new objects
    $module.Result.changed = Compare-OuObject -module $module
}

# simulate changes
if ($check_mode -and $current_ou) {
    $new_ou = @{}
    $current_ou.PropertyNames | ForEach-Object {
            if ($params[$_.Name]) { $new_ou[$_.Name] = $params[$_.Name] }
            else { $new_ou[$_.Name] = $_.Value }
    }
    $module.Diff.after = $new_ou
    $module.Result.ou = Get-OuObject $module.Diff.after
}
# simulate new ou created
if ($check_mode -and -not $current_ou) {
    $simulated_ou = Get-SimulatedOu -Object $params
    $module.Diff.after = Get-OuObject -Object $simulated_ou
}

$module.ExitJson()
