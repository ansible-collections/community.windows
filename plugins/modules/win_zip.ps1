#!powershell

# Copyright: (c) 2021, Kento Yagisawa <thel.vadam2485@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#Requires -Module Ansible.ModuleUtils.Legacy

$ErrorActionPreference = "Stop"

$params = Parse-Args $args -supports_check_mode $true
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false

$src = Get-AnsibleParam -obj $params -name "src" -type "path" -failifempty $true
$dest = Get-AnsibleParam -obj $params -name "dest" -type "path" -failifempty $true
$force = Get-AnsibleParam -obj $params -name "overwrite" -type "bool" -default $false

$result = @{
    changed = $false
    dest = $dest -replace '\$',''
    src = $src -replace '\$',''
}

If(-not (Test-Path -LiteralPath $src)) {
    Fail-Json -obj $result -message "The source file or directory '$src' does not exist."
}

If($dest -notlike "*.zip") {
    Fail-Json -obj $result -message "The destination zip file path '$dest' need to be zip file path."
}

If((Test-Path -LiteralPath $dest) -and ($force -eq $false)) {
    $result.skipped = $true
    $result.msg = "The destination zip file '$dest' already exists."
    Exit-Json -obj $result
}

Function Compress-Zip($src, $dest) {
    try {
        If((Test-Path -LiteralPath $dest) -and ($force -eq $true) -and (-not $check_mode)) {
            Remove-Item -LiteralPath $dest
        }
        If (-not $check_mode) {
            Compress-Archive -LiteralPath $src -DestinationPath $dest
        }
        $result.changed = $true
    } catch {
        Exit-Json -obj $result
    }
}

try {
    Compress-Zip -src $src -dest $dest
    } catch {
        Fail-Json -obj $result -message "There is an unexpected error during the zip compression process."
    }

Exit-Json $result
