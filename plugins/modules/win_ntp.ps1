#!powershell

# Copyright: (c) 2020, Sakar Mehra <sakarmehra100@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        peerlist = @{ type = "list"; elements = "str" }
        enabled = @{ type = "bool"; default = "True" }
        time_zone = @{ type = "str"; default = "UTC" }
        factory_default = @{ type = "bool"; default = "False" }
        type = @{ type = "str"; choices = "NTP", "NT5DS", "NoSync", "AllSync"; }
        cross_site_sync_flags = @{ type = "str"; choices = "none", "pdc-only", "all" }
        sync_clock = @{ type = "bool"; default = "False" }
    }
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$peerlist = $module.Params.peerlist
$enabled = $module.Params.enabled
$time_zone = $module.Params.time_zone
$factory_default = $module.Params.factory_default
$type = $module.Params.type
$cross_site_sync_str = $module.Params.cross_site_sync_flags
$sync_clock = $module.Params.sync_clock

$cross_site_sync_flags = $null
if ($cross_site_sync_str -eq "none") {
    $cross_site_sync_flags = 0
}
elseif ($cross_site_sync_str -eq "pdc-only") {
    $cross_site_sync_flags = 1
}
elseif ($cross_site_sync_str -eq "all") {
    $cross_site_sync_flags = 2
}

$outputItem = [PsCustomObject]@{
    ComputerNameFQDN = $null
    SourceName = $null
    SourceNameRaw = $null
    LastTimeSyncElapsedSeconds = $null
    LastTimeSynchronizationDateTime = $null
    StatusRequiredSourceType = $null
    StatusDateTime = $null
    StatusLastTimeSynchronization = $null
}

$current_time_zone = [System.TimeZoneInfo]::Local.Id
if ($null -ne $time_zone -and $current_time_zone -ne $time_zone) {
    try {
        & tzutil.exe /s $time_zone
        $module.Result.changed = $true
    }
    catch {
        $module.FailJson("Fail to set the required time zone.")
    }
}

try {
    $service = Get-Service -Name "W32Time"
    if ($service.Status -eq "Stopped") {
        Set-Service -Name "W32Time" -Status "Running"
    }
}
catch {
    $module.FailJson("The service has not been started.")
}

try {
    $w32tmOutput = & 'w32tm' '/query', '/status'
    $source_name = $w32tmOutput | Select-String -Pattern 'Source:'
    $outputItem.SourceName = ($source_name -replace 'Source:').Trim()
    $outputItem.SourceNameRaw = ($outputItem.SourceName -replace ',0x09 ').Trim()
    $ipGlobalProperties = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()
    if ($ipGlobalProperties.DomainName) {
        $outputItem.ComputerNameFQDN = '{0}.{1}' -f $ipGlobalProperties.HostName, $ipGlobalProperties.DomainName
    }
    else {
        $outputItem.ComputerNameFQDN = $null
    }
    $module.Result.source_name = $outputItem.SourceName
}
catch {
    $module.FailJson("Cannot fetch the current DomainName or Source.")
}

$parametersRegPath = "HKLM:\System\CurrentControlSet\Services\W32Time\Parameters"
$ntpclientRegPath = "HKLM:\System\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient"

if ($outputItem.SourceNameRaw -eq 'Local CMOS Clock' -or $outputItem.SourceNameRaw -eq 'Free-running System Clock') {
    $outputItem.StatusRequiredSourceType = $false
}
if ($outputItem.ConfiguredNTPServerName -notcontains $outputItem.SourceName) {
    $outputItem.StatusRequiredSourceType = $false
}

try {
    $ntpServerName = Get-ItemProperty -LiteralPath $parametersRegPath -Name 'NtpServer' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty NtpServer
    if ($type -ne 'NT5DS' -and $null -ne $peerlist -and $peerlist.Count -gt 0) {
        $peerlist = $peerlist | ForEach-Object {
            if ($_ -Like "*,0x09") { $_ } else { "$_,0x09" }
        }
        foreach ($peer in $peerlist) {
            if (-Not $ntpServerName.Contains($peer)) {
                $ntpServerName += " " + $peer
                Set-Service -Name "W32Time" -Status "Stopped" -WhatIf:$module.CheckMode
                Set-ItemProperty -LiteralPath $parametersRegPath -Name 'NtpServer' -Value $ntpServerName -WhatIf:$module.CheckMode
                Set-Service -Name "W32Time" -Status "Running" -WhatIf:$module.CheckMode
                $module.Result.changed = $true
            }
        }
    }
}
catch {
    $module.FailJson("Cannot update peerlist value.Msg: $($_.Exception.Message)")
}

#LastTimeSynchronizationDateTime

$LastTimeSyncDateTimeRaw = $w32tmOutput | Select-String -Pattern '^Last Successful Sync Time:'
$outputItem.StatusDateTime = $false
if ($LastTimeSyncDateTimeRaw) {
    $LastTimeSyncDateTimeRaw = ($LastTimeSyncDateTimeRaw -replace 'Last Successful Sync Time:').Trim()
}
if ($LastTimeSyncDateTimeRaw -eq 'unspecified') {
    $outputItem.StatusDateTime = $false
}
else {
    $outputItem.LastTimeSynchronizationDateTime = [DateTime]$LastTimeSyncDateTimeRaw
    $outputItem.LastTimeSyncElapsedSeconds = [int]((Get-Date) - $outputItem.LastTimeSynchronizationDateTime).TotalSeconds
    $outputItem.StatusDateTime = $true
}
if ($null -eq $outputItem.LastTimeSyncElapsedSeconds -or $outputItem.LastTimeSyncElapsedSeconds -lt 0 -or $outputItem.LastTimeSyncElapsedSeconds -gt 7800) {
    $outputItem.StatusLastTimeSynchronization = $false
}
else {
    $outputItem.StatusLastTimeSynchronization = $true
    $module.Result.last_time_sync_seconds = $outputItem.LastTimeSyncElapsedSeconds
}

if ($type -eq "NT5DS" -and $null -ne $cross_site_sync_flags) {
    try {
        $current_cross_site_flag = Get-ItemProperty `
            -LiteralPath $ntpclientRegPath `
            -Name 'CrossSiteSyncFlags' `
            -ErrorAction SilentlyContinue | `
                Select-Object -ExpandProperty CrossSiteSyncFlags
        if ($current_cross_site_flag -ne $cross_site_sync_flags) {
            Set-ItemProperty -LiteralPath $ntpclientRegPath -Name "CrossSiteSyncFlags" -Value $cross_site_sync_flags -WhatIf:$module.CheckMode
            $module.Result.changed = $true
        }
    }
    catch {
        $module.FailJson("Cannot update the value of cross_site_sync_flags.")
    }
}
try {
    $currentNtpType = (Get-ItemProperty -LiteralPath $parametersRegPath -Name 'Type').Type
    if ($null -ne $type -and $type -ne $currentNtpType) {
        Set-ItemProperty -LiteralPath $parametersRegPath -Name 'Type' -Value $type -WhatIf:$module.CheckMode
        $module.Result.changed = $true
    }
}
catch {
    $module.FailJson("Type is invalid and must be one of 'NoSync','AllSync','NTP','NT5DS'.")
}

[bool]$isEnable = (Get-ItemProperty -LiteralPath $ntpclientRegPath -Name 'Enabled').Enabled
if ($enabled -ne $isEnable) {
    Set-ItemProperty -LiteralPath $ntpclientRegPath -Name "Enabled" -Value $enabled -WhatIf:$module.CheckMode
    $module.Result.changed = $true
}

try {
    $module.Result.synced = $false
    if ($sync_clock -eq $true) {
        & 'w32tm' '/resync'
        $module.Result.synced = $true
        $module.Result.changed = $true
    }
}
catch {
    $module.FailJson("The Computer did not sync because no time data was available. Msg: $($_.Exception.Message)")
}

if ($factory_default -eq "true" -and $outputItem.SourceNameRaw -ne 'Local CMOS Clock') {
    try {
        Set-Service -Name "W32Time" -Status "Stopped"
        & 'w32tm' '/unregister'
        & 'w32tm' '/register'
        Set-Service -Name "W32Time" -Status "Running"
        $module.Result.changed = $true
    }
    catch {
        $module.FailJson("Error while defaulting the configurations! Msg: $($_.Exception.Message)")
    }
}

$module.ExitJson()
