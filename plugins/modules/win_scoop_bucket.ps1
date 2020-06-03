#!powershell

# Copyright: (c) 2020, Jamie Magee <jamie.magee@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#Requires -Module Ansible.ModuleUtils.ArgvParser
#Requires -Module Ansible.ModuleUtils.CommandUtil
#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
  options = @{
    name  = @{ type = "str"; required = $true }
    repo  = @{ type = "str" }
    state = @{ type = "str"; default = "present"; choices = "present", "absent" }
  }
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$name = $module.Params.name
$repo = $module.Params.repo
$state = $module.Params.state

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
    $module.Result.msg = "Skipped check mode run on win_scoop_bucket as scoop.ps1 cannot be found on the system"
    $module.ExitJson()
  }

  if ($null -eq $scoop_app -or -not (Test-Path -Path $scoop_app.Path)) {
    $module.FailJson("Failed to find scoop.ps1, make sure it is added to the PATH")
  }

  return $scoop_app.Path
}

function Get-ScoopBuckets {
  param(
    [Parameter(Mandatory = $true)] [string]$scoop_path
  )

  $command = Argv-ToString -arguments @("powershell.exe", $scoop_path, "bucket", "list")
  $res = Run-Command -Command $command
  if ($res.rc -ne 0) {
    $module.Result.command = $command
    $module.Result.rc = $res.rc
    $module.Result.stdout = $res.stdout
    $module.Result.stderr = $res.stderr
    $module.FailJson("Error checking installed buckets")
  }

  return $res.stdout -split "`r`n"
}

function Uninstall-ScoopBucket {
  param(
    [Parameter(Mandatory = $true)] [string]$scoop_path,
    [Parameter(Mandatory = $true)] [String]$bucket
  )
  $arguments = [System.Collections.ArrayList]@("powershell.exe", $scoop_path, "bucket", "rm")
  $arguments.Add($bucket)
  if ($repo) {
    $arguments.Add($repo)
  }

  $command = Argv-ToString -arguments $arguments
  $res = Run-Command -Command $command
  $module.Result.rc = $res.rc

  if ($module.Verbosity -gt 1) {
    $module.Result.stdout = $res.stdout
  }
  $module.Result.changed = $true
}

function Install-ScoopBucket {
  param(
    [Parameter(Mandatory = $true)] [string]$scoop_path,
    [Parameter(Mandatory = $true)] [String]$bucket,
    [String]$repo
  )
  $arguments = [System.Collections.ArrayList]@("powershell.exe", $scoop_path, "bucket", "add")
  $arguments.Add($bucket)
  if ($repo) {
    $arguments.Add($repo)
  }

  $command = Argv-ToString -arguments $arguments
  $res = Run-Command -Command $command
  $module.Result.rc = $res.rc

  if ($module.Verbosity -gt 1) {
    $module.Result.stdout = $res.stdout
  }
  $module.Result.changed = $true
}

$scoop_path = Install-Scoop

$installed_buckets = Get-ScoopBuckets -scoop_path $scoop_path

if ($state -in @("absent")) {
  if ($installed_buckets -contains $name) {
    Uninstall-ScoopBucket -scoop_path $scoop_path -bucket $name
  }
}

if ($state -in @("present")) {
  if ($installed_buckets -notcontains $name) {
    Install-ScoopBucket -scoop_path $scoop_path -bucket $name -repo $repo
  }
}

$module.ExitJson()
