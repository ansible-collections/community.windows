#!powershell

# Copyright: (c) 2020, Sakar Mehra <sakarmehra100@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#Requires -Module Ansible.ModuleUtils.Legacy

$ErrorActionPreference = "Stop"

$params = Parse-Args $args -supports_check_mode $true
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false

$peerlist = Get-AnsibleParam -obj $params -name "peerlist" -type "list"
$enabled = Get-AnsibleParam -obj $params -name "enabled" -type "bool" -default $true
$time_zone = Get-AnsibleParam -obj $params -name "time_zone" -type "str" -default "UTC"
$factory_default = Get-AnsibleParam -obj $params -name "factory_default" -type "bool" -default $false
$type = Get-AnsibleParam -obj $params -name "type" -type "str" -ValidateSet 'NTP','NT5DS','NoSync','AllSync'
$cross_site_sync_flags = Get-AnsibleParam -obj $params -name "cross_site_sync_flags" -type "int" -ValidateSet 0 ,1, 2
$sync_clock = Get-AnsibleParam -obj $params -name "sync_clock" -type "bool" -default $false

$result = @{
    changed = $false
}

$outputItem = [PsCustomObject]@{
    ComputerNameFQDN = $null
    SourceName = $null
    SourceNameRaw = $null
    LastTimeSyncElapsedSeconds = $null
    LastTimeSynchronizationDateTime = $null
    StatusRequiredSourceType= $null
    StatusDateTime= $null
    StatusLastTimeSynchronization = $null
}

$current_time_zone= [System.TimeZoneInfo]::Local.Id
if ($null -ne $time_zone -and $current_time_zone -ne $time_zone) {
    try {
      & tzutil /s $time_zone
      $result.changed = $true
    }
    catch {
      Fail-Json $result "Fail to set the required time zone."
    }
}

try {
    $service = Get-Service -Name "W32Time"
    if ($service.Status -eq "Stopped") {
      Set-Service -Name "W32Time" -Status "Running" -WhatIf:$check_mode
    }
}
catch {
    Fail.Json $result "The service has not been started."
}

try {
    $w32tmOutput = & 'w32tm' '/query', '/status'
    $source_name = $w32tmOutput | Select-String -Pattern 'Source:'
    $outputItem.SourceName = ($source_name -replace 'Source:').Trim()
    $outputItem.SourceNameRaw = ($outputItem.SourceName -replace ',0x9 ').Trim()
    $ipGlobalProperties = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()
    if ($ipGlobalProperties.DomainName) {
      $outputItem.ComputerNameFQDN = '{0}.{1}' -f $ipGlobalProperties.HostName, $ipGlobalProperties.DomainName
    }
    else {
      $outputItem.ComputerNameFQDN = $null
    }
    $result.source_name = $outputItem.SourceName
}
catch {
    Fail.Json $result "Cannot fetch the current DomainName or Source."
}

$parametersRegPath = "HKLM:\System\CurrentControlSet\Services\W32Time\Parameters"
$ntpclientRegPath = "HKLM:\System\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient"

if($outputItem.SourceNameRaw  -eq 'Local CMOS Clock' -or $outputItem.SourceNameRaw  -eq 'Free-running System Clock') {
    $outputItem.StatusRequiredSourceType =$false
}
if( $outputItem.ConfiguredNTPServerName -notcontains $outputItem.SourceName ) {
    $outputItem.StatusRequiredSourceType = $false
}

try {
    $ntpServerName = Get-ItemProperty -Path $parametersRegPath -Name 'NtpServer' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty NtpServer
    if($type -ne 'NT5DS' -and $null -ne $peerlist -and $peerlist.Count -gt 0) {
      $peerlist =$peerlist | ForEach-Object{
          if ($_ -Like "*,0x9") {$_} else {"$_,0x9"}
      }
      foreach($peer in $peerlist) {
          if(-Not $ntpServerName.Contains($peer)){
            $ntpServerName+= " "+ $peer
            Set-Service -Name "W32Time" -Status "Stopped" -WhatIf:$check_mode
            Set-ItemProperty -Path $parametersRegPath -Name 'NtpServer' -Value $ntpServerName -WhatIf:$check_mode
            Set-Service -Name "W32Time" -Status "Running" -WhatIf:$check_mode
            $result.changed = $true
          }
      }
    }
}
catch {
    Fail-Json $result "Cannot update peerlist value."
}

#LastTimeSynchronizationDateTime

$LastTimeSyncDateTimeRaw = $w32tmOutput | Select-String -Pattern '^Last Successful Sync Time:'
$outputItem.StatusDateTime = $false
if($LastTimeSyncDateTimeRaw) {
    $LastTimeSyncDateTimeRaw = ($LastTimeSyncDateTimeRaw -replace 'Last Successful Sync Time:').Trim()
}
if($LastTimeSyncDateTimeRaw -eq 'unspecified') {
   $outputItem.StatusDateTime =$false
}
else {
    $outputItem.LastTimeSynchronizationDateTime =[DateTime]$LastTimeSyncDateTimeRaw
    $outputItem.LastTimeSyncElapsedSeconds = [int]((Get-Date)-$outputItem.LastTimeSynchronizationDateTime).TotalSeconds
    $outputItem.StatusDateTime =$true
}
if ($outputItem.LastTimeSyncElapsedSeconds -eq $null -or $outputItem.LastTimeSyncElapsedSeconds -lt 0 -or $outputItem.LastTimeSyncElapsedSeconds -gt 7800) {
    $outputItem.StatusLastTimeSynchronization = $false
}
else {
      $outputItem.StatusLastTimeSynchronization = $true
      $result.last_time_sync_seconds = $outputItem.LastTimeSyncElapsedSeconds
}

if ($type -eq "NT5DS" -and $null -ne $cross_site_sync_flags) {
  try {
    $current_cross_site_flag = Get-ItemProperty -Path $ntpclientRegPath -Name 'CrossSiteSyncFlags' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty CrossSiteSyncFlags
    if($current_cross_site_flag -ne $cross_site_sync_flags) {
      Set-ItemProperty -Path $ntpclientRegPath -Name "CrossSiteSyncFlags" -Value $cross_site_sync_flags -WhatIf:$check_mode
      $result.changed = $true
    }
  }
  catch {
    Fail-Json $result "Cannot update the value of cross_site_sync_flags"
  }
}
try {
    $currentNtpType = (Get-ItemProperty -Path $parametersRegPath -Name 'Type').Type
    if ($null -ne $type -and $type -ne $currentNtpType) {
      Set-ItemProperty -Path $parametersRegPath -Name 'Type' -Value $type -WhatIf:$check_mode
      $result.changed = $true
    }
}
catch {
    Fail-Json $result "Type is invalid and must be one of 'NoSync','AllSync','NTP','NT5DS'."
}

[bool]$isEnable = (Get-ItemProperty -Path $ntpclientRegPath -Name 'Enabled').Enabled
    if ($enabled -ne $isEnable) {
        Set-ItemProperty -Path $ntpclientRegPath -Name "Enabled" -Value $enabled -WhatIf:$check_mode
        $result.changed = $true
    }

try {
    $result.synced = $false
    if($sync_clock -eq $true) {
      $resync = & 'w32tm' '/resync'
      $result.synced = $true
      $result.changed = $true
    }
}
catch {
    Fail-Json -obj $result -message "The Computer did not sync because no time data was available. Msg: $($_.Exception.Message)"
}

if ($factory_default -eq "true" -and $outputItem.SourceNameRaw  -ne 'Local CMOS Clock') {
    try {
      Set-Service -Name "W32Time" -Status "Stopped" -WhatIf:$check_mode
      $w32tm_unregister = & 'w32tm' '/unregister'
      $w32tm_register = & 'w32tm' '/register'
      Set-Service -Name "W32Time" -Status "Running" -WhatIf:$check_mode
      $result.changed = $true
    }
    catch {
        Fail-Json -obj $result -message "Error while defaulting the configurations! Msg: $($_.Exception.Message)"
    }
}

Exit-Json $result
