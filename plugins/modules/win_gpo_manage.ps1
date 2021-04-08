#!powershell
# Copyright: (c) 2021 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options  = @{
        name     = @{ type = "list"; elements = "str" }
        state     = @{ type = "str"; choices = "present", "absent", "exported";required=$true }
        folder   = @{ type = "path"; default = "C:\GPO" }
        override = @{ type = "bool"; default = $false }# Skip if import gpo
    }
    required_if = @(
        @("state", "present", @("folder")),
        @("state", "exported", @("folder")),
        @("state", "absent", @("name"))
        )
    supports_check_mode = $true
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$check_mode = $module.CheckMode
$gpomode = $module.Params.state
$removedgpo = $module.Params.name
$folderpath = $module.Params.folder
try {
    Import-Module GroupPolicy
} catch {
    $module.FailJson("win_gpo_manage requires the GroupPolicy PS module to be installed", $_)
}
function Import-GPOs {
    param (
        $importfolder,
        [bool]$override
    )
    $Folder = Get-childItem -LiteralPath  $Importfolder -Directory
    $gpos = Get-GPO -All
    if($folder.count -gt 0) {
        foreach ($Entry in $Folder) {
            $override
            $Name = $Entry.Name + $postname
            if(($gpos -contains $Name) -and !($override)) {
                $module.FailJson("GroupPolicy exists already")
            } else {
                #GPO does not exist or override is §true
                $Path = $Importfolder + "\" + $entry.Name
                 (get-item -LiteralPath  $Path+'\manifest.xml').Attributes += 'Hidden' #make manifest hidden
                $ID = Get-ChildItem -LiteralPath  $Path
                if(!($gpos -contains $Name)) {
                    #if no GPO exist
                    New-GPO -Name $Name -WhatIf:$check_mode
                    $module.result.changed = $true
                }
                Import-GPO -TargetName $Name -Path $Path -BackupId $ID.Name -WhatIf:$check_mode
                $module.result.imported.Add($Name)
                $module.result.changed = $true
            }
        }
    } else {
        $module.FailJson("Folder has no Sub Folders for import ")
    }
}
function Export-GPOs {
    param (
        $ExportFolder
    )
    if((Test-Path -LiteralPath $folderpath) -and !($override)) {
        #Folder Exist and override is false
        $module.FailJson("folder $folderpath exists already")
    }
    $gpo = Get-GPO -All
    foreach ($Entry in $gpo) {
        $Path = $ExportFolder + "\" + $entry.Displayname
        if((Test-Path -LiteralPath $Path) -and !($override)) {
            $module.FailJson("Folder already exists, Override is false ")
        } else {
            if(!(Test-Path -LiteralPath $Path)) {
                #Folder doesnt exist
                New-Item -ItemType directory -Path $Path -WhatIf:$check_mode | Out-Null
            }
            if((Test-Path -LiteralPath $Path) -and ($override)) {
                Remove-Item -ItemType directory -Path $Path -WhatIf:$check_mode
                New-Item -ItemType directory -Path $Path -WhatIf:$check_mode | Out-Null
            }
            Backup-GPO -Guid $Entry.id -Path $Path -WhatIf:$check_mode
            $module.result.exported.Add($entry.Displayname)
        }
    }
}
if ($gpomode -eq "absent") {
    #Removes GPOs
    $gpo = (Get-GPO -All).Displayname
    $module.Diff.before = $gpo
    if ($removedgpo.count -gt 0) {
        foreach ($gporemove in $removedgpo) {
            if($gpos -contains $removedgpo) {
                #check if GPO exist
                try {
                    Remove-GPO -Name $gporemove -WhatIf:$check_mode
                    $module.result.removed.Add($gporemove)
                    $module.result.changed = $true
                } catch {
                    $module.FailJson("an exception occurred when deleting GPO - $($_.Exception.Message)")
                }
            } else {
                $module.result.changed = $false #GPO does not exist - Skipping that Part
            }
        }
    } else {
        $module.result.changed = $false #there are no gpos
    }
    if ($module.DiffMode -and $result.changed) {
        if (!$check_mode) {
            #only check
            $module.Diff.after = [Array]$removedgpo
        } else {
            #remove gpos
            $module.Diff.after = @((Get-Gpo -All).Displayname)`
        }
    }
}
if ($gpomode -like "present") {
    try {
        Import-GPOs -importfolder $folderpath
    } catch {
        $module.FailJson("an exception occurred when importing GPO - $($_.Exception.Message)")
    }
}
if ($gpomode -eq "exported") {
    try {
        Export-GPOs  -exportfolder $folderpath
    } catch {
        $module.FailJson("an exception occurred when exporting all GPOs - $($_.Exception.Message)")
    }
}
$module.exitJson()
