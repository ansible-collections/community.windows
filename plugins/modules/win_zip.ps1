#!powershell

# Copyright: (c) 2021, Kento Yagisawa <thel.vadam2485@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        src = @{ type = 'path'; required = $true }
        dest = @{ type = 'path'; required = $true }
    }
    supports_check_mode = $true
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$src = $module.Params.src
$dest = $module.Params.dest

$srcFile = [System.IO.Path]::GetFileName($src)
$compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal

If(-not (Test-Path -LiteralPath $src)) {
    $module.FailJson("The source file or directory '$src' does not exist.")
}

If($dest -notlike "*.zip") {
    $module.FailJson("The destination zip file path '$dest' need to be zip file path.")
}

If(Test-Path -LiteralPath $dest) {
    $module.Result.skipped = $true
    $module.Result.msg = "The destination zip file '$dest' already exists."
    $module.ExitJson()
}

# Check .NET v4.5 or later version exists or not
If(-not (Test-Path -LiteralPath 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full')) {
    $module.FailJson(".NET Framework 4.5 or later version needs to be installed.")
}

Function Compress-Zip($src, $dest) {
    If (-not $module.CheckMode) {
        Add-Type -AssemblyName System.IO.Compression.FileSystem

        If (Test-Path -LiteralPath $src -PathType Container) {
            [System.IO.Compression.ZipFile]::CreateFromDirectory($src, $dest, $compressionLevel, $true)
        } Else {
            $zip = [System.IO.Compression.ZipFile]::Open($dest, 'Update')
            [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $src, $srcFile, $compressionLevel)
            $zip.Dispose()
        }
    }
    $module.Result.changed = $true
}

Compress-Zip -src $src -dest $dest

$module.ExitJson()