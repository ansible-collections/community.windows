#!powershell

# Copyright: (c) 2026, Ansible Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        name = @{ type = 'str'; required = $true }
        enabled = @{ type = 'bool' }
        size = @{ type = 'int' }
        mode = @{ type = 'str'; choices = @( 'overwrite', 'archive', 'no_overwrite' ) }

    }
    required_one_of = @(
        , @('enabled', 'size', 'mode')
    )

    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$module.Result.changed = $false

$enabled = $module.Params.enabled
$size = $module.Params.size
$mode = $module.Params.mode


try {
    $log = Get-LogProperties -Name $module.Params.name
}
catch {
    $module.FailJson("Object Name does not exists", $_)
}

$module.Diff.before = @{ enabled = $log.Enabled; retention = $log.Retention; auto_backup = $log.AutoBackup; size = $log.MaxLogSize; }


if ($null -ne $enabled -and $log.Enabled -ne $enabled) {
    $log.Enabled = $enabled
    $module.Result.changed = $true
}

if ($size -and $log.MaxLogSize -ne $size) {
    if ($size -ge 1052672) {
        $log.MaxLogSize = $size
        $module.Result.changed = $true
    }
    else {
        $module.FailJson("Size must be larger than 1052672")
    }
}

if ($null -ne $mode) {
    $retention = $mode -eq 'archive' -or $mode -eq 'no_overwrite'
    $auto_backup = $mode -eq 'archive'

    if ($log.Retention -ne $retention -or $log.AutoBackup -ne $auto_backup) {
        $log.Retention = $retention
        $log.AutoBackup = $auto_backup
        $module.Result.changed = $true
    }
}

if ($module.Result.changed -and -Not($module.CheckMode)) {
    Set-LogProperties -LogDetails $log
}

$module.Diff.after = @{ enabled = $log.Enabled; retention = $log.Retention; auto_backup = $log.AutoBackup; size = $log.MaxLogSize; }

$module.ExitJson()
