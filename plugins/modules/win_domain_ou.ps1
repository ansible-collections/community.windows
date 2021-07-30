#!powershell

# Copyright: (c) 2020 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic
#Requires -Module Ansible.ModuleUtils.CamelConversion
#Requires -Module ActiveDirectory

$spec = @{
    options = @{
        state = @{ type = "str"; choices = @("absent", "present"); default = "present" }
        name = @{ type = "str"; required = $true }
        protected = @{ type = "bool"; default = $false }
        path = @{ type = "str"; required = $false }
        filter = @{type = "str"; default = '*';}
        recursive = @{ type = "bool"; default = $false }
        domain_username = @{ type = "str"; }
        domain_password = @{ type = "str";  no_log = $true }
        domain_server = @{ type = "str"; }
        properties = @{ type = "dict";}
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
    $extra_args.Properties = ""
    $module.Params.properties.Keys | Foreach-Object{
        $extra_args.Properties = New-Object Collections.Generic.List[string]
        $item = $_
        $keyName = ""
        if ($item.Contains("_")){
            $item.Split("_") | Foreach-Object{
                $keyName = $keyname + $_.substring(0,1).toupper() + $_.substring(1).tolower()
            }
        }else{
            $keyName = $item.substring(0,1).toupper() + $item.substring(1).tolower()
        }
        $extra_args.Properties.Add($keyName)
    }
}else{
    $extra_args.Properties = '*'
}

$extra_args.Filter = $module.Params.filter
$check_mode = $module.CheckMode

$name = $module.Params.name
$protected = $module.Params.protected
$path = $module.Params.path
$state = $module.Params.state
$recursive = $module.Params.recursive

# setup Dynamic Params
$parms = @{}
if ($module.Params.properties.count -ne 0){
    $module.Params.properties.Keys | ForEach-Object{
        $item = $_
        $keyName = ""
        if ($item.Contains("_")){
            $item.Split("_") | Foreach-Object{
                $keyName = $keyname + $_.substring(0,1).toupper() + $_.substring(1).tolower()
            }
        }else{
            $keyName = $item.substring(0,1).toupper() + $item.substring(1).tolower()
        }
        $parms.Add($keyName,$module.Params.properties.Item($_))
    }
}
$module.Result.params = $parms

Function Compare-OuObject {
    Param(
        [PSObject]$Original,
        [PSObject]$Updated,
        [string]$properties
    )
    if ($Original -eq $false) { return $false }
    if ($properties -ne '*'){
        $x = Compare-Object -ReferenceObject $Original -DifferenceObject $Updated -Property $properties
    }else{
        $x = Compare-Object -ReferenceObject $Original -DifferenceObject $Updated
    }
    $x.Count -eq 0
}

Function Get-SimulatedOu {
    Param($Object)

    $parms = @{
        Name = $Object.name
        DistinguishedName = "OU=$($Object.name)," + $Object.path
        ProtectedFromAccidentalDeletion = $Object.protected
    }

    if ($Object.properties) {
        if ($Object.properties.description) { $parms.Description = $Object.properties.description }
        if ($Object.properties.city) { $parms.City = $Object.properties.city }
        if ($Object.properties.state) { $parms.State = $Object.properties.state }
        if ($Object.properties.street_address) { $parms.StreetAddress = $Object.properties.street_address }
        if ($Object.properties.postal_code) { $parms.PostalCode = $Object.properties.postal_code }
        if ($Object.properties.country) { $parms.Country = $Object.properties.country }
        if ($Object.properties.managed_by) { $parms.ManagedBy = $Object.properties.managed_by }
    }

    # convert to psobject & return
    [PSCustomObject]$parms
}
function Convert-ObjectToSnakeCase {
    <#
        .SYNOPSIS
        Converts an object with CamelCase properties to a dictionary with snake_case keys.
        Works in the spirit of and depends on the existing CamelConversion module util.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [OutputType([System.Collections.Specialized.OrderedDictionary])]
        [Object]
        $InputObject ,

        [Parameter()]
        [Switch]
        $NoRecurse ,

        [Parameter()]
        [Switch]
        $OmitNull
    )

    Process {
        $result = [Ordered]@{}
        foreach ($property in $InputObject.PSObject.Properties) {
            $value = $property.Value
            if (-not $NoRecurse -and $value -is [System.Collections.IDictionary]) {
                $value = Convert-DictToSnakeCase -dict $value
            }
            elseif (-not $NoRecurse -and ($value -is [Array] -or $value -is [System.Collections.ArrayList])) {
                $value = Convert-ListToSnakeCase -list $value
            }
            elseif ($null -eq $value) {
                if ($OmitNull) {
                    continue
                }
            }
            elseif (-not $NoRecurse -and $value -isnot [System.ValueType] -and $value -isnot [string]) {
                $value = Convert-ObjectToSnakeCase -InputObject $value
            }

            $name = Convert-StringToSnakeCase -string $property.Name
            $result[$name] = $value
        }
        $result
    }
}
Function Get-OuObject {
    Param([PSObject]$Object)
    $obj = $Object | Select-Object -Property * -ExcludeProperty ObjectGUID,nTSecurityDescriptor
    $obj = Convert-ObjectToSnakeCase -InputObject $obj -NoRecurse
    try{$obj.object_guid = $Object.ObjectGUID}
    catch{$module.FailJson("Adding objectGUid $($_.Exception.Message)", $_)}
    return $obj
}

# attempt import of module
Try { Import-Module ActiveDirectory }
Catch { $module.FailJson("The ActiveDirectory module failed to load properly: $($_.Exception.Message)", $_) }

Try{
    $module.Result.extra_args = $extra_args
    $all_ous = Get-ADOrganizationalUnit @extra_args
}Catch{$module.FailJson("Line 191: Get-ADOrganizationalUnit failed: $($_.Exception.Message)", $_) }


# set path if not defined to base domain
if ($null -eq $path){
    if ($($all_ous | Measure-Object | Select-Object -ExpandProperty Count) -eq 1){
        $matched = $all_ous.DistinguishedName -match "DC=.+"

    }elseif ($($all_ous | Measure-Object | Select-Object -ExpandProperty Count) -gt 1) {
        $matched = $all_ous[0].DistinguishedName -match "DC=.+"
    }else{
        $module.FailJson("path was null and unable to determine default domain $($_.Exception.Message)", $_)
    }
    if ($matched){
        $path = $matches.Values[0]
    }else{
        $module.FailJson("Unable to find default domain $($_.Exception.Message)", $_)
    }
}
}

# determine if requested OU exist
Try {
    $current_ou = $all_ous | Where-Object {
            $_.DistinguishedName -eq "OU=$name,$path"}
    $module.Diff.before = Get-OuObject -Object $current_ou
    $module.Result.ou = $module.Diff.before
} Catch {
    #$module.FailJson("current_ou error $($_.Exception.Message)", $_)
    $module.Diff.before = ""
    $current_ou = $false
}

if ($state -eq "present") {
    # ou does not exist, create object
    if(-not $current_ou) {
        $parms.Name = $name
        $parms.Path = $path
        Try {
            $module.Result.params = $parms
            $module.Result.extra_args = $onboard_extra_args
            New-ADOrganizationalUnit @parms @onboard_extra_args -ProtectedFromAccidentalDeletion $protected -WhatIf:$check_mode
        }Catch {
            $module.FailJson("Failed to create organizational unit: $($_.Exception.Message)", $_)
        }
    }

    # ou exists, update object
    if ($current_ou) {
        Try {
            $module.Result.params = $parms
            $module.Result.extra_args = $onboard_extra_args
            Set-ADOrganizationalUnit -Identity "OU=$name,$path" @parms @onboard_extra_args -WhatIf:$check_mode
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
            $module.Result.extra_args = $onboard_extra_args
            Set-ADOrganizationalUnit -Identity "OU=$name,$path" -ProtectedFromAccidentalDeletion $false @onboard_extra_args -Confirm:$False -WhatIf:$check_mode
            # check recursive deletion
            if ($recursive) {
                Remove-ADOrganizationalUnit -Identity "OU=$name,$path" -Confirm:$False -WhatIf:$check_mode -Recursive @onboard_extra_args
            }else {
                Remove-ADOrganizationalUnit -Identity "OU=$name,$path" -Confirm:$False -WhatIf:$check_mode @onboard_extra_args
            }
            $module.Result.changed = $true
            $module.Diff.after = ""
        } Catch {
            $module.FailJson("Failed to remove OU: $($_.Exception.Message)", $_)
        }
    }
    $module.ExitJson()
}

# determine if a change was made

if (-not $check_mode) {
    try{
        $module.Result.extra_args = $extra_args
        $new_ou = Get-ADOrganizationalUnit @extra_args | Where-Object {
            $_.DistinguishedName -eq "OU=$name,$path"
        }
    }catch{
        $Module.FailJson("Failed to Get-ADOrganizationalUnit: Line 245 $($_.Exception.Message)", $_)
    }
    # compare old/new objects
    if (-not (Compare-OuObject -Original $current_ou -Updated $new_ou -properties $extra_args.Properties)) {
        $module.Result.changed = $true
        $module.Result.ou = Get-OuObject -Object $new_ou
        $module.Diff.after = Get-OuObject -Object $new_ou
    }
}

# simulate changes
if ($check_mode -and $current_ou) {
    $new_ou = @{}
    $current_ou.PropertyNames | ForEach-Object {
            if ($parms[$_.Name]) { $new_ou[$_.Name] = $parms[$_.Name] }
            else { $new_ou[$_.Name] = $_.Value }
    }
    $module.Diff.after = Get-OuObject -Object $new_ou
}
# simulate new ou created
if ($check_mode -and -not $current_ou) {
    $simulated_ou = Get-SimulatedOu -Object $parms
    $module.Diff.after = Get-OuObject -Object $simulated_ou
}

$module.ExitJson()
