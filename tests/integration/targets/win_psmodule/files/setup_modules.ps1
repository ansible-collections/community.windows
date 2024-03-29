$ErrorActionPreference = "Stop"

$template_path = $args[0]
$template_manifest = Join-Path -Path $template_path -ChildPath template.psd1
$template_script = Join-Path -Path $template_path -ChildPath template.psm1
$template_nuspec = Join-Path -Path $template_path -ChildPath template.nuspec
$template_license = Join-Path -Path $template_path -ChildPath license.txt
$nuget_exe = Join-Path -Path $template_path -ChildPath nuget.exe
$sign_cert = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Certificate2 -ArgumentList @(
    (Join-Path -Path $template_path -ChildPath sign.pfx),
    'password',
    # We need to use MachineKeySet so we can load the pfx without using become
    # EphemeralKeySet would be better but it is only available starting with .NET 4.7.2
    [System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::MachineKeySet
)

$packages = @(
    @{ name = "ansible-test1"; version = "1.0.0"; repo = "PSRepo 1"; function = "Get-AnsibleTest1" }
    @{ name = "ansible-test1"; version = "1.0.5"; repo = "PSRepo 1"; function = "Get-AnsibleTest1" }
    @{ name = "ansible-test1"; version = "1.1.0"; repo = "PSRepo 1"; function = "Get-AnsibleTest1" }
    @{ name = "ansible-test2"; version = "1.0.0"; repo = "PSRepo 1"; function = "Get-AnsibleTest2" }
    @{ name = "ansible-test2"; version = "1.0.0"; repo = "PSRepo 2"; function = "Get-AnsibleTest2" }
    @{ name = "ansible-test2"; version = "1.0.1"; repo = "PSRepo 1"; function = "Get-AnsibleTest2"; signed = $false }
    @{ name = "ansible-test2"; version = "1.1.0"; prerelease = "beta1"; repo = "PSRepo 1"; function = "Get-AnsibleTest2" }
    @{ name = "ansible-clobber"; version = "0.1.0"; repo = "PSRepo 1"; function = "Enable-PSTrace" }
    @{ name = "ansible-licensed" ; version = "1.1.1"; repo = "PSRepo 1" ; require_license = $true; function = "Get-AnsibleLicensed" }
)

foreach ($package in $packages) {
    $tmp_dir = Join-Path -Path $template_path -ChildPath $package.name
    if (Test-Path -LiteralPath $tmp_dir) {
        Remove-Item -LiteralPath $tmp_dir -Force -Recurse
    }
    New-Item -Path $tmp_dir -ItemType Directory > $null

    Copy-Item -LiteralPath $template_license -Destination $tmp_dir -Force

    try {
        $ps_data = @("LicenseUri = 'https://choosealicense.com/licenses/mit/'")
        $nuget_version = $package.version
        if ($package.ContainsKey("prerelease")) {
            $ps_data += "Prerelease = '$($package.prerelease)'"
            $nuget_version = "$($package.version)-$($package.prerelease)"
        }
        if ($package.ContainsKey("require_license")) {
            $ps_data += "RequireLicenseAcceptance = `$$($package.require_license)"
        }

        $manifest = [System.IO.File]::ReadAllText($template_manifest)
        $manifest = $manifest.Replace('--- NAME ---', $package.name).Replace('--- VERSION ---', $package.version)
        $manifest = $manifest.Replace('--- GUID ---', [Guid]::NewGuid()).Replace('--- FUNCTION ---', $package.function)

        $manifest = $manifest.Replace('PSData = @{}', "PSData = @{`n$($ps_data -join "`n")`n}")
        $manifest_path = Join-Path -Path $tmp_dir -ChildPath "$($package.name).psd1"
        Set-Content -LiteralPath $manifest_path -Value $manifest

        $script = [System.IO.File]::ReadAllText($template_script)
        $script = $script.Replace('--- NAME ---', $package.name).Replace('--- VERSION ---', $package.version)
        $script = $script.Replace('--- REPO ---', $package.repo).Replace('Get-Function', $package.function)
        $script_path = Join-Path -Path $tmp_dir -ChildPath "$($package.name).psm1"
        Set-Content -LiteralPath $script_path -Value $script

        $signed = if ($package.ContainsKey("signed")) { $package.signed } else { $true }
        if ($signed) {
            Set-AuthenticodeSignature -Certificate $sign_cert -LiteralPath $manifest_path > $null
            Set-AuthenticodeSignature -Certificate $sign_cert -LiteralPath $script_path > $null
        }

        # We should just be able to use Publish-Module but it fails when running over WinRM for older hosts and become
        # does not fix this. It fails to respond to nuget.exe push errors when it canno find the .nupkg file. We will
        # just manually do that ourselves. This also has the added benefit of being a lot quicker than Publish-Module
        # which seems to take forever to publish the module.
        $nuspec = [System.IO.File]::ReadAllText($template_nuspec)
        $nuspec = $nuspec.Replace('--- NAME ---', $package.name).Replace('--- VERSION ---', $nuget_version)
        $nuspec = $nuspec.Replace('--- FUNCTION ---', $package.function)
        $nuspec = $nuspec.Replace('--- LICACC ---', ($package.require_license -as [bool]).ToString().ToLower())
        Set-Content -LiteralPath (Join-Path -Path $tmp_dir -ChildPath "$($package.name).nuspec") -Value $nuspec

        &$nuget_exe pack "$tmp_dir\$($package.name).nuspec" -outputdirectory $tmp_dir

        $repo_path = Join-Path -Path $template_path -ChildPath $package.repo
        $nupkg_filename = "$($package.name).$($nuget_version).nupkg"
        Copy-Item -LiteralPath (Join-Path -Path $tmp_dir -ChildPath $nupkg_filename) `
            -Destination (Join-Path -Path $repo_path -ChildPath $nupkg_filename)
    }
    finally {
        Remove-Item -LiteralPath $tmp_dir -Force -Recurse
    }
}
