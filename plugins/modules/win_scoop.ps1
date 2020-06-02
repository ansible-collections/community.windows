#!powershell

# Copyright: (c) 2020, Jamie Magee <jamie.magee@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#Requires -Module Ansible.ModuleUtils.ArgvParser
#Requires -Module Ansible.ModuleUtils.CommandUtil
#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
  options = @{
    arch        = @{ type = "str"; choices = "32bit", "64bit" }
    independent = @{type = "bool"; default = $false }
    global      = @{ type = "bool"; default = $false }
    name        = @{ type = "list"; elements = "str"; required = $true }
    no_cache    = @{type = "bool"; default = $false }
    purge       = @{type = "bool"; default = $false }
    skip        = @{type = "bool"; default = $false }
    state       = @{ type = "str"; default = "present"; choices = "present", "absent" }
  }
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$arch = $module.Params.arch
$independent = $module.Params.independent
$global = $module.Params.global
$name = $module.Params.name
$no_cache = $module.Params.no_cache
$purge = $module.Params.purge
$skip = $module.Params.skip
$state = $module.Params.state

$module.Result.rc = 0

function Install-Scoop {

  # Scoop doesn't have refreshenv like Chocolatey
  # Let's try to update PATH first
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

  $scoop_app = Get-Command -Name scoop.ps1 -Type ExternalScript -ErrorAction SilentlyContinue
  if ($null -eq $scoop_app) {
    # We need to install scoop
    # Enable TLS1.1/TLS1.2 if they're available but disabled (eg. .NET 4.5)
    $security_protocols = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::SystemDefault
    if ([Net.SecurityProtocolType].GetMember("Tls11").Count -gt 0) {
      $security_protocols = $security_protcols -bor [Net.SecurityProtocolType]::Tls11
    }
    if ([Net.SecurityProtocolType].GetMember("Tls12").Count -gt 0) {
      $security_protocols = $security_protcols -bor [Net.SecurityProtocolType]::Tls12
    }
    [Net.ServicePointManager]::SecurityProtocol = $security_protocols

    $client = New-Object -TypeName System.Net.WebClient

    $script_url = "https://get.scoop.sh"

    try {
      $install_script = $client.DownloadString($script_url)
    }
    catch {
      $module.FailJson("Failed to download Scoop script from '$script_url'; $($_.Exception.Message)", $_)
    }

    if (-not $module.CheckMode) {
      $res = Run-Command -Command "powershell.exe -" -stdin $install_script -environment $environment
      if ($res.rc -ne 0) {
        $module.Result.rc = $res.rc
        $module.Result.stdout = $res.stdout
        $module.Result.stderr = $res.stderr
        $module.FailJson("Scoop bootstrap installation failed.")
      }
      $module.Warn("Scoop was missing from this system, so it was installed during this task run.")
    }
    $module.Result.changed = $true

    # Refresh PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

    # locate the newly installed scoop.ps1
    $scoop_app = Get-Command -Name scoop.ps1 -Type ExternalScript -ErrorAction SilentlyContinue
  }

  if ($module.CheckMode -and $null -eq $scoop_app) {
    $module.Result.skipped = $true
    $module.Result.msg = "Skipped check mode run on win_scoop as scoop.ps1 cannot be found on the system"
    $module.ExitJson()
  }

  if ($null -eq $scoop_app -or -not (Test-Path -LiteralPath $scoop_app.Path)) {
    $module.FailJson("Failed to find scoop.ps1, make sure it is added to the PATH")
  }

  return $scoop_app.Path
}

function Get-ScoopPackages {
  param(
    [Parameter(Mandatory = $true)] [string]$scoop_path
  )

  $command = Argv-ToString -arguments @("powershell.exe", $scoop_path, "export")
  $res = Run-Command -Command $command
  if ($res.rc -ne 0) {
    $module.Result.command = $command
    $module.Result.rc = $res.rc
    $module.Result.stdout = $res.stdout
    $module.Result.stderr = $res.stderr
    $module.FailJson("Error checking installed packages")
  }

  $installed_packages = $res.stdout -split "`n" |
  Select-String '(.*?) \(v:(.*?)\) \[(.*?)\]' |
  ForEach-Object {
    New-Object PSObject -Property ([Ordered]@{
        "Package" = $_.Matches[0].Groups[1].Value
        "Version" = $_.Matches[0].Groups[2].Value
        "Bucket"  = $_.Matches[0].Groups[3].Value
      })
  }

  return $installed_packages
}

function Get-InstallScoopPackageArguments {
  $arguments = [System.Collections.ArrayList]@()

  if ($arch) {
    $arguments.Add("--arch") > $null
    $arguments.Add($arch) > $null
  }
  if ($global) {
    $arguments.Add("--global") > $null
  }
  if ($independent) {
    $arguments.Add("--independent") > $null
  }
  if ($no_cache) {
    $arguments.Add("--no-cache") > $null
  }
  if ($skip) {
    $arguments.Add("--skip") > $null
  }

  return , $arguments
}

function Install-ScoopPackage {
  param(
    [Parameter(Mandatory = $true)] [string]$scoop_path,
    [Parameter(Mandatory = $true)] [String[]]$packages
  )
  $arguments = [System.Collections.ArrayList]@("powershell.exe", $scoop_path, "install")
  $arguments.AddRange($packages)

  $common_args = Get-InstallScoopPackageArguments
  $arguments.AddRange($common_args)

  $command = Argv-ToString -arguments $arguments
  $res = Run-Command -Command $command
  $module.Result.rc = $res.rc

  if ($module.Verbosity -gt 1) {
    $module.Result.stdout = $res.stdout
  }
  $module.Result.changed = $true
}

function Get-UninstallScoopPackageArguments {
  $arguments = [System.Collections.ArrayList]@()

  if ($independent) {
    $arguments.Add("--global") > $null
  }
  if ($purge) {
    $arguments.Add("--purge") > $null
  }

  return , $arguments
}

function Uninstall-ScoopPackage {
  param(
    [Parameter(Mandatory = $true)] [string]$scoop_path,
    [Parameter(Mandatory = $true)] [String[]]$packages
  )

  $arguments = [System.Collections.ArrayList]@("powershell.exe", $scoop_path, "uninstall")
  $arguments.AddRange($packages)

  $common_args = Get-UninstallScoopPackageArguments
  $arguments.AddRange($common_args)

  $command = Argv-ToString -arguments $arguments
  $res = Run-Command -Command $command
  $module.Result.rc = $res.rc

  if ($module.Verbosity -gt 1) {
    $module.Result.stdout = $res.stdout
  }
  $module.Result.changed = $true
}

$scoop_path = Install-Scoop

$installed_packages = Get-ScoopPackages -scoop_path $scoop_path

if ($state -in @("absent")) {
  Uninstall-ScoopPackage -scoop_path $scoop_path -packages $name
}

if ($state -in @("present")) {
  $missing_packages = [System.Collections.ArrayList]@()
  foreach ($package in $name) {
    if ($installed_packages.Package -notcontains $package) {
      $missing_packages.Add($package)
    }
  }

  if ($missing_packages) {
    Install-ScoopPackage -scoop_path $scoop_path -packages $missing_packages
  }
}

$module.ExitJson()
