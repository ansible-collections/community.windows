#!powershell

# Ansible module for text replacement in Windows files
# Copyright: (c) 2025, Mish Goldenberg <golden.mihel@gmail.com>
# GNU General Public License v3.0+
# SPDX-License-Identifier: GPL-3.0-or-later

#Requires -Module Ansible.ModuleUtils.Legacy
#Requires -Module Ansible.ModuleUtils.Backup

# Parse parameters from Ansible machinery
$params = Parse-Args $args -supports_check_mode $true
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false
# $diff_support = Get-AnsibleParam -obj $params -name "_ansible_diff" -type "bool" -default $false

$path = Get-AnsibleParam -obj $params -name "path" -type "path" -failifempty $true -aliases "dest", "destfile", "name"
$regexp = Get-AnsibleParam -obj $params -name "regexp" -type "str" -failifempty $true
$replace = Get-AnsibleParam -obj $params -name "replace" -type "str" -default ""
$backup = Get-AnsibleParam -obj $params -name "backup" -type "bool" -default $false
$encoding = Get-AnsibleParam -obj $params -name "encoding" -type "str" -default "utf8"

# Normalize path
$cleanpath = $path.Replace("/", "\")

# Fail if file does not exist
if (-not (Test-Path -LiteralPath $cleanpath)) {
    Fail-Json @{} "File not found: $cleanpath"
}

# Determine encoding
$encodingobj = [System.Text.Encoding]::UTF8
if ($encoding -ne "utf8") {
    $encodingobj = [System.Text.Encoding]::GetEncoding($encoding)
}

# Read all file content
$content = [System.IO.File]::ReadAllText($cleanpath, $encodingobj)

# Convert CRLF to LF temporarily for regex
$content = $content -replace "`r`n", "`n"
$new_content = [regex]::Replace($content, $regexp, $replace, [System.Text.RegularExpressions.RegexOptions]::Multiline)
# Restore CRLF
$new_content = $new_content -replace "`n", "`r`n"

# Initialize result
$result = @{
    path = ""
    changed = $false
    backup_file = ""
    msg = ""
}

# Check if content changed
if ($new_content -ne $content) {
    $result.path = $path
    $result.changed = $true
    $result.msg = "Replaced matching content"

    # Backup if requested
    if ($backup) {
        $result.backup_file = Backup-File -path $cleanpath -WhatIf:$check_mode
    }

    # Write new content (respect check mode)
    if (-not $check_mode) {
        [System.IO.File]::WriteAllText($cleanpath, $new_content, $encodingobj)
    }
}
else {
    $result.msg = "No changes"
}

# Exit with JSON for Ansible
Exit-Json $result