#!powershell

# Copyright: (c) 2015, Phil Schwartz <schwartzmx@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#Requires -Module Ansible.ModuleUtils.Legacy

# TODO: This module is not idempotent (it will always unzip and report change)

$ErrorActionPreference = "Stop"

$pcx_extensions = @('.bz2', '.gz', '.msu', '.tar', '.zip')

$params = Parse-Args $args -supports_check_mode $true
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false

$src = Get-AnsibleParam -obj $params -name "src" -type "path" -failifempty $true
$dest = Get-AnsibleParam -obj $params -name "dest" -type "path" -failifempty $true
$creates = Get-AnsibleParam -obj $params -name "creates" -type "path"
$recurse = Get-AnsibleParam -obj $params -name "recurse" -type "bool" -default $false
$delete_archive = Get-AnsibleParam -obj $params -name "delete_archive" -type "bool" -default $false -aliases 'rm'
$password = Get-AnsibleParam -obj $params -name "password" -type "str"

# Fixes a fail error message (when the task actually succeeds) for a
# "Convert-ToJson: The converted JSON string is in bad format"
# This happens when JSON is parsing a string that ends with a "\",
# which is possible when specifying a directory to download to.
# This catches that possible error, before assigning the JSON $result
$result = @{
    changed = $false
    dest = $dest -replace '\$', ''
    removed = $false
    src = $src -replace '\$', ''
}

Function Expand-Zip($src, $dest) {
    $archive = [System.IO.Compression.ZipFile]::Open($src, [System.IO.Compression.ZipArchiveMode]::Read, [System.Text.Encoding]::UTF8)
    foreach ($entry in $archive.Entries) {
        $archive_name = $entry.FullName

        $entry_target_path = [System.IO.Path]::Combine($dest, $archive_name)
        $entry_dir = [System.IO.Path]::GetDirectoryName($entry_target_path)

        # Normalize paths for further evaluation
        $full_target_path = [System.IO.Path]::GetFullPath($entry_target_path)
        $full_dest_path = [System.IO.Path]::GetFullPath($dest + [System.IO.Path]::DirectorySeparatorChar)

        # Ensure file in the archive does not escape the extraction path
        if (-not $full_target_path.StartsWith($full_dest_path)) {
            $msg = "Error unzipping '$src' to '$dest'! Filename contains relative paths which would extract outside the destination: $entry_target_path"
            Fail-Json -obj $result -message $msg
        }

        if (-not (Test-Path -LiteralPath $entry_dir)) {
            New-Item -Path $entry_dir -ItemType Directory -WhatIf:$check_mode | Out-Null
            $result.changed = $true
        }

        if ((-not ($entry_target_path.EndsWith("\") -or $entry_target_path.EndsWith("/"))) -and (-not $check_mode)) {
            [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $entry_target_path, $true)
        }
        $result.changed = $true
    }
    $archive.Dispose()
}

Function Expand-ZipLegacy($src, $dest) {
    # [System.IO.Compression.ZipFile] was only added in .net 4.5, this is used
    # when .net is older than that.
    $shell = New-Object -ComObject Shell.Application
    $zip = $shell.NameSpace([IO.Path]::GetFullPath($src))
    $dest_path = $shell.NameSpace([IO.Path]::GetFullPath($dest))

    $shell = New-Object -ComObject Shell.Application

    if (-not $check_mode) {
        # https://msdn.microsoft.com/en-us/library/windows/desktop/bb787866.aspx
        # From Folder.CopyHere documentation, 1044 means:
        #  - 1024: do not display a user interface if an error occurs
        #  -   16: respond with "yes to all" for any dialog box that is displayed
        #  -    4: do not display a progress dialog box
        $dest_path.CopyHere($zip.Items(), 1044)
    }
    $result.changed = $true
}

Function Get-SystemTarExePath {
    # Only use the tar.exe that ships with Windows 10 / Server 2019+; do not
    # search PATH to avoid picking up an unknown third-party binary.
    $system_tar = [System.IO.Path]::Combine($env:SystemRoot, 'System32', 'tar.exe')
    if (Test-Path -LiteralPath $system_tar) {
        return $system_tar
    }
    return $null
}

Function Expand-WithTar($src, $dest, $tar_exe) {
    # Function-scoped: prevents stderr from tar.exe becoming a terminating
    # PowerShell error under the module-level "Stop" preference.
    $ErrorActionPreference = "Continue"
    $rc = 0
    $tar_output = $null
    try {
        $tar_output = & $tar_exe -xf $src -C $dest 2>&1
        $rc = $LASTEXITCODE
    }
    catch {
        $rc = -1
        $tar_output = $_.Exception.Message
    }
    if ($rc) {
        Fail-Json -obj $result -message "Error extracting '$src' to '$dest' using tar.exe (rc=$rc): $tar_output"
    }
    $result.changed = $true
}

If ($creates -and (Test-Path -LiteralPath $creates)) {
    $result.skipped = $true
    $result.msg = "The file or directory '$creates' already exists."
    Exit-Json -obj $result
}

If (-Not (Test-Path -LiteralPath $src)) {
    Fail-Json -obj $result -message "File '$src' does not exist."
}

$ext = [System.IO.Path]::GetExtension($src)

If (-Not (Test-Path -LiteralPath $dest -PathType Container)) {
    Try {
        New-Item -ItemType "directory" -path $dest -WhatIf:$check_mode | out-null
    }
    Catch {
        Fail-Json -obj $result -message "Error creating '$dest' directory! Msg: $($_.Exception.Message)"
    }
}

# tar.exe (ships with Windows 10 build 17063+ / Server 2019+) handles tar-based
# formats natively. It does not support passwords, recursive nested extraction,
# standalone .gz/.bz2, or .msu - those still require PSCX.
$filename_lower = [System.IO.Path]::GetFileName($src).ToLower()
$is_tar_compatible = $filename_lower -match '\.(tar|tar\.gz|tgz|tar\.bz2|tbz2|tar\.xz|txz)$'

$use_pscx = $false

If ($ext -eq ".zip" -And $recurse -eq $false -And -Not $password) {
    # TODO: PS v5 supports zip extraction, use that if available
    $use_legacy = $false
    try {
        # determines if .net 4.5 is available, if this fails we need to fall
        # back to the legacy COM Shell.Application to extract the zip
        Add-Type -AssemblyName System.IO.Compression.FileSystem | Out-Null
        Add-Type -AssemblyName System.IO.Compression | Out-Null
    }
    catch {
        $use_legacy = $true
    }

    if ($use_legacy) {
        try {
            Expand-ZipLegacy -src $src -dest $dest
        }
        catch {
            Fail-Json -obj $result -message "Error unzipping '$src' to '$dest'!. Method: COM Shell.Application, Exception: $($_.Exception.Message)"
        }
    }
    else {
        try {
            Expand-Zip -src $src -dest $dest
        }
        catch {
            Fail-Json -obj $result -message "Error unzipping '$src' to '$dest'!. Method: System.IO.Compression.ZipFile, Exception: $($_.Exception.Message)"
        }
    }
}
ElseIf ($is_tar_compatible -And -Not $password -And -Not $recurse) {
    $tar_exe = Get-SystemTarExePath
    If ($tar_exe) {
        If ($check_mode) {
            # In check mode the dest directory may not exist yet (New-Item ran with -WhatIf)
            # and there is nothing to execute anyway; just report changed.
            $result.changed = $true
        }
        Else {
            Expand-WithTar -src $src -dest $dest -tar_exe $tar_exe
        }
    }
    Else {
        # System tar.exe not available (Windows older than 10 build 17063 / Server 2019); fall back to PSCX
        $use_pscx = $true
    }
}
Else {
    $use_pscx = $true
}

If ($use_pscx) {
    # Check if PSCX is installed
    $list = Get-Module -ListAvailable

    If (-Not ($list -match "PSCX")) {
        Fail-Json -obj $result -message ("PowerShellCommunityExtensions PowerShell Module (PSCX) is required " +
            "for this archive type, recursive extraction, or password-protected archives.")
    }
    Else {
        $result.pscx_status = "present"
    }

    Try {
        Import-Module PSCX
    }
    Catch {
        Fail-Json $result "Error importing module PSCX"
    }

    $expand_params = @{
        OutputPath = $dest
        WhatIf = $check_mode
    }
    if ($null -ne $password) {
        $expand_params.Password = ConvertTo-SecureString -String $password -AsPlainText -Force
    }
    Try {
        # Use -LiteralPath to prevent PowerShell wildcard-expanding brackets and other
        # special characters that may appear in the path (e.g. [$!@^&test(;)]).
        Expand-Archive -LiteralPath $src @expand_params
    }
    Catch {
        Fail-Json -obj $result -message "Error expanding '$src' to '$dest'! Msg: $($_.Exception.Message)"
    }

    If ($recurse) {
        Get-ChildItem -LiteralPath $dest -recurse | Where-Object { $pcx_extensions -contains $_.extension } | ForEach-Object {
            Try {
                Expand-Archive -LiteralPath $_.FullName -Force @expand_params
            }
            Catch {
                Fail-Json -obj $result -message "Error recursively expanding '$src' to '$dest'! Msg: $($_.Exception.Message)"
            }
            If ($delete_archive) {
                Remove-Item -LiteralPath $_.FullName -Force -WhatIf:$check_mode
                $result.removed = $true
            }
        }
    }

    $result.changed = $true
}

If ($delete_archive) {
    try {
        Remove-Item -LiteralPath $src -Recurse -Force -WhatIf:$check_mode
    }
    catch {
        Fail-Json -obj $result -message "failed to delete archive at '$src': $($_.Exception.Message)"
    }
    $result.removed = $true
}
Exit-Json $result
