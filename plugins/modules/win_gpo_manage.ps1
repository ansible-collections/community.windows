#!powershell
# Copyright: (c) 2021 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options  = @{
        name     = @{ type = "list"; elements = "str" }
        folder   = @{ type = "path"; default = "C:\GPO" }
        mode     = @{ type = "str"; choices = "import", "query", "remove", "export";required=$true }
        override = @{ type = "bool"; default = $false }# Skip if import gpo
    }
    required_if = @(
        @("mode", "import", @("folder")),
        @("mode", "export", @("folder")),
        @("mode", "remove", @("name"))
        )
    supports_check_mode = $true
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$check_mode = $module.CheckMode
$gpomode = $module.Params.mode
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
                New-Item -ItemType directory -Path $Path -WhatIf:$check_mode
            }
            if((Test-Path -LiteralPath $Path) -and ($override)) {
                Remove-Item -ItemType directory -Path $Path -WhatIf:$check_mode
                New-Item -ItemType directory -Path $Path -WhatIf:$check_mode
            }
            Backup-GPO -Guid $Entry.id -Path $Path -WhatIf:$check_mode
            $module.result.exported.Add($entry.Displayname)
        }
    }
}
if ($diff_mode) {
    $module.result.diff = @{}
}
if ($gpomode -eq "remove") {
    #Removes GPOs
    $gpo = (Get-GPO -All).Displayname
    $module.diff.before = $gpo | Out-String
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
    if ($diff_mode -and $result.changed) {
        if (!$check_mode) {
            #only check
            $module.result.diff.after = [Array]$removedgpo | Out-String
        } else {
            #remove gpos
            $module.Diff.after = @((Get-Gpo -All).Displayname)`
        }
    }
}
if ($gpomode -eq "query") {
    $queryresult = Get-GPO -All
    $module.result.query_result = $queryresult
    $module.result.changed = $false
}
if ($gpomode -like "import") {
    try {
        Import-GPOs -importfolder $folderpath
    } catch {
        $module.FailJson("an exception occurred when importing GPO - $($_.Exception.Message)")
    }
}
if ($gpomode -eq "export") {
    try {
        Export-GPOs  -exportfolder $folderpath
    } catch {
        $module.FailJson("an exception occurred when exporting all GPOs - $($_.Exception.Message)")
    }
}
$module.exitJson()
