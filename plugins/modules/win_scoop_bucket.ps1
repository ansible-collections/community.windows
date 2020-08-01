#!powershell

# Copyright: (c) 2020, Jamie Magee <jamie.magee@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#Requires -Module Ansible.ModuleUtils.ArgvParser
#Requires -Module Ansible.ModuleUtils.CommandUtil
#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
  options             = @{
    name  = @{ type = "str"; required = $true }
    repo  = @{ type = "str" }
    state = @{ type = "str"; default = "present"; choices = "present", "absent" }
  }
  supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$name = $module.Params.name
$repo = $module.Params.repo
$state = $module.Params.state

function Get-Scoop {
  # Scoop doesn't have refreshenv like Chocolatey
  # Let's try to update PATH first
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

  $scoop_app = Get-Command -Name scoop.ps1 -Type ExternalScript -ErrorAction SilentlyContinue

  if ($module.CheckMode -and $null -eq $scoop_app) {
    $module.Result.skipped = $true
    $module.Result.msg = "Skipped check mode run on win_scoop_bucket as scoop.ps1 cannot be found on the system"
    $module.ExitJson()
  }

  if ($null -eq $scoop_app -or -not (Test-Path -LiteralPath $scoop_app.Path)) {
    $module.FailJson("Failed to find scoop.ps1, make sure it is added to the PATH")
  }

  return $scoop_app.Path
}

function Get-ScoopBuckets {
  param(
    [Parameter(Mandatory = $true)] [string]$scoop_path
  )

  $arguments = @("powershell.exe", $scoop_path, "bucket", "list")
  $command = Argv-ToString -arguments $arguments
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
  $arguments = [System.Collections.Generic.List[String]]@("powershell.exe", $scoop_path, "bucket", "rm")
  $arguments.Add($bucket)
  if ($repo) {
    $arguments.Add($repo)
  }

  $command = Argv-ToString -arguments $arguments
  if (-not $module.CheckMode) {
    $res = Run-Command -Command $command
    $module.Result.rc = $res.rc

    if ($module.Verbosity -gt 1) {
      $module.Result.stdout = $res.stdout
    }
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
  if (-not $module.CheckMode) {
    $res = Run-Command -Command $command
    $module.Result.rc = $res.rc

    if ($module.Verbosity -gt 1) {
      $module.Result.stdout = $res.stdout
    }
  }
  $module.Result.changed = $true
}

$scoop_path = Get-Scoop

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
