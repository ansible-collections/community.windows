#!powershell
# Copyright: (c) 2021 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
# AnsibleRequires -CSharpUtil Ansible.Basic

try {
    Import-Module GroupPolicy
} catch {
    $module.FailJson("win_grouppolicy requires the GroupPolicy  PS module to be installed")
}
try {
    Import-Module activedirectory
} catch {
    $module.FailJson("win_grouppolicy requires the activedirectory  PS module to be installed")
}

function Get-Gplink {

    <#
    .SYNOPSIS
    return and decode content of gplink attribut

    .DESCRIPTION
    This function purpose is to list the gplink attribut of an OU, Site or DomainDNS.
    It will return the following information for each linked GPOs:

        - Target: DN of the targeted object
        - GPOID: GUID of the GPO
        - GPOName: Friendly Name of the GPO
        - GPODomain: Originating domain of the GPO
        - Enforced: <Yes|No>
        - Enabled:  <Yes|No>
        - Order: Link order of the GPO on the OU,Site,DomainDNS (does not report inherited order)
        #author https://gallery.technet.microsoft.com/scriptcenter/Get-GPlink-Function-V13-b31253b4

    .PARAMETER Path: Give de Distinguished Name of object you want to list the gplink


    .INPUTS
    DN of the object with GLINK attribut

    .OUTPUTS
    Target: DC=fourthcoffee,DC=com
    GPOID: 31B2F340-016D-11D2-945F-00C04FB984F9
    GPOName: Default Domain Policy
    GPODomain: fourthcoffee.com
    Enforced: <YES - NO>
    Enabled: <YES - NO>
    Order: 1

    .EXAMPLE
    get-gplink -path "dc=fourthcoffee,dc=com"

    This command will list the GPOs that are linked to the DomainDNS object "dc=fourthcoffee,dc=com"

    .EXAMPLE
    get-gplink -path "dc=child,dc=fourthcoffee,dc=com" -server childdc.child.fourthcoffee.com

    This command will list the GPOs that are linked to the DomainDNS object "dc=child,dc=fourthcoffee,dc=com". You need to specify a
    target DC of the domain child.fourthcoffee.com in order for the command to work.


    .EXAMPLE
    Get-Gplink -site "CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=fourthcoffee,DC=com"

    This command will list the GPOs that are linked to site "Default-First-Site-Name"

    .EXAMPLE
    get-gplink -path "dc=fourthcoffee,dc=com" | export-csv "gplink.csv"

    This command will list the GPOs that are linked to the DomainDNS object "dc=fourthcoffee,dc=com" and export them to a csv file.
    The csv file can be used as an input to the cmdlet new-gplink


    .EXAMPLE
    get-adobject -filter {(objectclass -eq "DomainDNS") -or (objectclass -eq "OrganizationalUnit")} | foreach {get-gplink -path $_.distinguishedname} | export-csv "gplinksall.csv"

    This command will list all objects of type "DomainDNS" and "OrganizationalUnit" that have GPOs linked and will list those GPOs, their status and link order.

    #>

    [cmdletBinding()]
    param ([string]$path, [string]$server, [string]$site)

    #Import AD and GPO modules
    Import-Module activedirectory
    Import-Module grouppolicy
    # get the DN to te configuration partition
    $configpart = (Get-ADRootDSE).configurationNamingContext

    #get content of attribut gplink on site object or OU
    if ($site) {
        $gplink = Get-ADObject -Filter { distinguishedname -eq $site } -searchbase $configpart -Properties gplink
        $target = $site
    } elseif ($path) {
        switch ($server) {
            "" { $gplink = Get-ADObject -Filter { distinguishedname -eq $path } -Properties gplink }
            default {
                $gplink = Get-ADObject -Filter { distinguishedname -eq $path } -Properties gplink -server $server
            }
        }
        $target = $path
    }
    #if DN is not valid return" Invalide DN" error
    if ($null -eq $gplink) {
        $module.FailJson("Either Invalide DN in the current domain, specify a DC of the target DN domain or no GPOlinked to this DN")
    }
    # test if glink is not null or only containes white space before continuing.
    if (!((($gplink.gplink) -like "") -or (($gplink.gplink) -like " "))) {
        #set variale $o to define link order
        $o = 0
        #we split the gplink string in order to seperate the diffent GPO linked
        $split = $gplink.gplink.split("]")
        #we need to do a reverse for to get the proper link order
        for ($s = $split.count - 1; $s -gt -1; $s--) {
            #since the last character in the gplink string is a "]" the last split is empty we need to ignore it
            if ($split[$s].length -gt 0) {
                $o++
                $order = $o
                $gpoguid = $split[$s].substring(12, 36)
                $gpodomainDN = ($split[$s].substring(72)).split(";")
                $domain = ($gpodomaindn[0].substring(3)).replace(",DC=", ".")
                $checkdc = (get-addomaincontroller -domainname $domain -discover).name
                #we test if the $gpoguid is a valid GUID in the domain if not we return a "Oprhaned GpLink or External GPO" in the $gponname
                $mygpo = get-gpo -guid $gpoguid -domain $domain -server "$($checkdc)$($domain)2> $null"
                if ($null -ne $mygpo ) {
                    $gponame = $MyGPO.displayname
                    $gpodomain = $domain
                } else {
                    $gponame = "Orphaned GPLink"
                    $gpodomain = $domain
                }
                #we test the last 2 charaters of the split do determine the status of the GPO link
                if (($split[$s].endswith(";0"))) {
                    $enforced = "No"
                    $enabled = "Yes"
                } elseif (($split[$s].endswith(";1"))) {
                    $enabled = "No"
                    $enforced = "No"
                } elseif (($split[$s].endswith(";2"))) {
                    $enabled = "Yes"
                    $enforced = "Yes"
                } elseif (($split[$s].endswith(";3"))) {
                    $enabled = "No"
                    $enforced = "Yes"
                }
                #we create an object representing each GPOs, its links status and link order
                $return = New-Object psobject
                $return | Add-Member -membertype NoteProperty -Name "Target" -Value $target
                $return | Add-Member -membertype NoteProperty -Name "GPOID" -Value $gpoguid
                $return | Add-Member -membertype NoteProperty -Name "DisplayName" -Value $gponame
                $return | Add-Member -membertype NoteProperty -Name "Domain" -Value $gpodomain
                $return | Add-Member -membertype NoteProperty -Name "Enforced" -Value $enforced
                $return | Add-Member -membertype NoteProperty -Name "Enabled" -Value $enabled
                $return | Add-Member -membertype NoteProperty -Name "Order" -Value $order
                $return
            }
        }
    }
}
$spec = @{
    options = @{
        state = @{ type = "str"; choices = "query", "present", "absent"; default = "present" }
        path = @{ type = "list"; elements = "str" }
        gponame = @{ type = "str"; required = $true }
        order = @{ type = "int" }
        domain = @{ type = "str" }
        enforced = @{ type = "bool"; default = $false }
        linkenabled = @{  type = "bool"; default = $true }
    }
    supports_check_mode = $true
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$state = $module.Params.state
$path = $module.Params.path
$gponame = $module.Params.gponame
$gpoorder = $module.Params.order
$gpodomain = $module.Params.domain
$gposerver = $module.Params.server
$enforcedbool = $module.Params.enforced
$gpolinkenabledbool = $module.Params.linkenabled
$ErrorActionPreference = 'Stop'#Error Action

#Converting Needed Variables from bool into Strings :)
#Microsoft specified that as string. Possible "No","yes","Unspecified" https://docs.microsoft.com/en-us/powershell/module/grouppolicy/set-gplink
if ($gpolinkenabledbool) {
    $gpolinkenabled = "yes"
} else {
    $gpolinkenabled = "no"
}
if ($enforcedbool) {
    $enforced = "yes"
} else {
    $enforced = "no"
}
#States
if ($state -eq "query") {
    foreach ($pa in $path) {
        [string]$path = $pa
        if ($path) {
            get-gplink -path $path
        } else {
            $module.FailJson("GPO Target Path not set. Please specify that.")
        }
    }
}
if ($state -eq "present") {
    $gpos = Get-GPO -All
    if ($gpos.Displayname -contains $gponame) {
            #handle each path
            foreach ($pa in $path) {
                [string]$path = $pa
                if ($path) {
                    #collect all Informations about GPO
                    $gpodefault = @{
                        Name = $gponame
                        Target = $path
                        Enforced = $enforced
                    }
                    #Settings for Settings like "order"
                    $gposetparam = @{
                        LinkEnabled = $gpolinkenabled
                    }
                    if ($gpoorder) { $gposetparam.order = $gpoorder }
                    if ($gpodomain) { $gposetparam.Domain = $gpodomain }
                    if ($gposerver) { $gposetparam.Server = $gposerver }
                    if ($checkmode) { $gposetparam.WhatIf = $true }
                    $gpoalllinks = get-gplink -path $path #get all links for specific path
                    $gpoonpath = $gpoalllinks | Where-Object { $_.DisplayName -match $gponame } | Select-Object * #filter information for specific
                    if ( $gpoalllinks.DisplayName -notcontains $gponame) {
                        #gpo link not exists create link
                        new-gplink -name $gponame -Target $path
                        $module.result.changed = $true
                    }
                    if (($gpoonpath.Enforced -match $gposetparam.Enforced) -and ($gpoonpath.Enabled -match $gposetparam.LinkEnabled) -and (($null -eq $gposetparam.order) -or ($gpoonpath.Order -eq $gposetparam.order))) {
                        # nogplink  update needed
                        $module.result.changed = $false
                    } else {
                        #gplink needs update
                        Set-GPLink @gpodefault @gposetparam
                        $module.result.changed = $true
                    }
                } else {
                    #Fail if Path is empty and Import doesnt recognized it
                    $module.FailJson("GPO Target Path not set. Please specify that.")
                }
            }
    } else {
        #No GPO exists in AD
        $module.FailJson("GPO not exist")
    }
}
if ($state -eq "absent") {
    foreach ($pa in $path) {
        [string]$path = $pa
        if ($path) {
            $gpos = Get-GPO -All
            if ($gpos.Displayname -contains $gponame) {
                # gpo exists in AD
                $gpoonpath = get-gplink -path $path #get all links for specific path
                if ($gpoonpath.DisplayName -contains $gponame ) {
                    Remove-gplink -Name $gponame -Target $path
                    $module.result.changed = $true
                } else {
                    #no GPO there
                    $result.changed = $false
                }
            } else {
                #No GPO exists in AD
                $module.result.changed = $false
                $module.FailJson("GPO not exist")
            }
        } else {
            #Fail if Path is empty and Import doesnt recognized it
            $module.FailJson("GPO Target Path not set. Please specify that.")
        }
    }
}
$module.ExitJson()