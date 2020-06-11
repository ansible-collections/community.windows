#!powershell

# Copyright: (c) 2020, Jamie Magee <jamie.magee@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#Requires -Module Ansible.ModuleUtils.ArgvParser
#Requires -Module Ansible.ModuleUtils.CommandUtil
#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
  options             = @{
    name  = @{ type = "str"; required = $true }
    state = @{ type = "str"; default = "present"; choices = "present", "absent" }
  }
  supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$name = $module.Params.name
$state = $module.Params.state

$module.Result.rc = 0

function Install-Winget {
  $winget_app = Get-Command -Name winget -Type Application -ErrorAction SilentlyContinue
  if ($null -eq $winget_app) {
    # We need to install winget
    # Enable TLS1.2 if it's available but disabled (eg. .NET 4.5)
    $security_protocols = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::SystemDefault
    if ([Net.SecurityProtocolType].GetMember("Tls12").Count -gt 0) {
      $security_protocols = $security_protcols -bor [Net.SecurityProtocolType]::Tls12
    }
    [Net.ServicePointManager]::SecurityProtocol = $security_protocols

    $client = New-Object -TypeName System.Net.WebClient

    $installer_url = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle"

    try {
      $client.DownloadFile($installer_url, "$env:temp\winget.appx")
    }
    catch {
      $module.FailJson("Failed to download winget; $($_.Exception.Message)", $_)
    }

    if (-not $module.CheckMode) {
      try {
        Add-AppxPackage -Path $installer
        $module.Warn("winget was missing from this system, so it was installed during this task run.")
      }
      catch {
        $module.FailJson("Failed to install winget; $($_.Exception.Message)", $_)
      }
    }
    $module.Result.changed = $true

    # locate the newly installed winget
    $winget_app = Get-Command -Name winget -Type Application -ErrorAction SilentlyContinue
  }

  if ($module.CheckMode -and $null -eq $winget_app) {
    $module.Result.skipped = $true
    $module.Result.msg = "Skipped check mode run on win_winget as winget cannot be found on the system"
    $module.ExitJson()
  }

  return $winget_app.Path
}

function Get-InstallWingetPackageArguments {
  $arguments = [System.Collections.Generic.List[String]]@()

  return , $arguments
}

function Install-WingetPackage {
  param(
    [Parameter(Mandatory = $true)] [string]$winget_path,
    [Parameter(Mandatory = $true)] [String]$package
  )
  $arguments = [System.Collections.Generic.List[String]]@($winget_path, "install", "-e", "$package")

  $common_args = Get-InstallWingetPackageArguments
  $arguments.AddRange($common_args)

  $command = Argv-ToString -arguments $arguments
  $res = Run-Command -Command $command
  $module.Result.rc = $res.rc

  if ($module.Verbosity -gt 1) {
    $module.Result.stdout = $res.stdout
    $module.Result.stderr = $res.stderr
  }
  $module.Result.changed = $true
}

$winget_path = Install-Winget

if ($state -in @("present")) {
  Install-WingetPackage -winget_path $winget_path -package $name
}

$module.ExitJson()
