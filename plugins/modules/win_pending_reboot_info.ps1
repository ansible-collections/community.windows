#!powershell

# Copyright: (c) 2022, Oleg Galushko (@inorangestylee)
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic

Set-StrictMode -Version 3.0

$spec = @{
    options = @{
        skip = @{ type = 'list'; elements = 'str'; required = $false; choices = @(
                'cbs', 'ccm_client', 'computer_rename', 'dsc_lcm', 'dvd_reboot_signal', 'file_rename', 'join_domain', 'server_manager', 'windows_update'
            )
        }
    }
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$skip_list = $module.Params.skip

$module.Result.changed = $false

$checks = @('cbs', 'ccm_client', 'computer_rename', 'dsc_lcm', 'dvd_reboot_signal', 'file_rename', 'join_domain', 'server_manager', 'windows_update')

function Test-ComponentBasedServicingPR {
    [OutputType([System.Boolean])]

    $test_registry_keys = @(
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending'
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootInProgress'
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\PackagesPending'
    )

    forEach ($rk in $test_registry_keys) {
        if (Test-Path -LiteralPath $rk) {
            return $true
        }
    }

    return $false
}

function Test-DscLcmPR {
    [OutputType([System.Boolean])]

    $result = $false
    try {
        $result = (Get-DscLocalConfigurationManager).LcmState -eq 'PendingReboot'
    }
    catch [System.Management.Automation.CommandNotFoundException] {
        $module.Warn('DSC LCM is not available on this system. Check will be skipped')
    }
    catch {
        $module.Warn("Unable to query DSC LCM state: $_")
    }

    return $result
}
function Test-WindowsUpdatePR {
    [OutputType([System.Boolean])]

    $test_registry_keys = @(
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired'
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\PostRebootReporting'
    )

    forEach ($rk in $test_registry_keys) {
        $result = Test-Path -LiteralPath $rk
        if ($result) {
            return $true
        }
    }

    try {
        $pending_services = Get-ChildItem -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\Pending' -ErrorAction Stop
    }
    catch {
        $pending_services = $null
    }

    if ($null -ne $pending_services) {
        return $true
    }

    $update_exe_volatile = Get-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Updates' -Name 'UpdateExeVolatile' -ErrorAction SilentlyContinue
    if ($null -ne $update_exe_volatile -and $update_exe_volatile.UpdateExeVolatile -gt 0) {
        return $true
    }

    return $false
}

function Test-FileRenamePR {
    [OutputType([System.Boolean])]
    $properties = @('PendingFileRenameOperations', 'PendingFileRenameOperations2')

    $file_rename_operations = Get-ItemProperty `
        -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\' `
        -Name $properties `
        -ErrorAction SilentlyContinue

    forEach ($p in $properties) {
        try {
            $check = $file_rename_operations.$p
        }
        catch {
            $check = $null
        }

        if ($null -ne $check) {
            return $true
        }
    }

    return $false
}

function Test-ServerManagerPR {
    [OutputType([System.Boolean])]
    $result = Test-Path -LiteralPath 'HKLM:\SOFTWARE\Microsoft\ServerManager\CurrentRebootAttempts'

    return $result
}

function Test-DVDRebootSignal {
    [OutputType([System.Boolean])]
    $check = Get-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce' -Name 'DVDRebootSignal' -ErrorAction SilentlyContinue
    try {
        $result = $null -ne $check.DVDRebootSignal
    }
    catch {
        return $false
    }

    return $result
}

function Test-ComputerRenamePR {
    [OutputType([System.Boolean])]
    $actual_computer_name = Get-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName' -Name 'ComputerName'
    $pending_computer_name = Get-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName'-Name 'ComputerName'
    $result = $actual_computer_name.ComputerName -ne $pending_computer_name.ComputerName

    return $result
}

function Test-JoinDomainPR {
    [OutputType([System.Boolean])]
    $properties = @('JoinDomain', 'AvoidSpnSet')
    $netlogon = Get-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon' -Name $properties -ErrorAction SilentlyContinue

    forEach ($p in $properties) {
        try {
            $check = $netlogon.$p
        }
        catch {
            $check = $null
        }

        if ($null -ne $check) {
            return $true
        }
    }

    return $false
}

function Test-CcmClientPR {
    [OutputType([System.Boolean])]
    $result = $false
    try {
        $cim_result = Invoke-CimMethod -Namespace 'ROOT\ccm\ClientSDK' -ClassName 'CCM_ClientUtilities' -Name 'DetermineIfRebootPending' -ErrorAction Stop
    }
    catch {
        $module.Warn("Unable to query CIM Class CCM_ClientUtilities: $_")
        $cim_result = $null
    }

    if ($cim_result) {
        $result = ($cim_result.ReturnValue -eq 0) -and ($cim_result.IsHardRebootPending -or $cim_result.RebootPending)
    }

    return $result
}

$checks_results = [ordered]@{}
forEach ($c in $checks) {
    if ($c -in $skip_list) {
        $checks_results.Add($c, $false)
        continue
    }

    switch ($c) {
        'cbs' { $state = Test-ComponentBasedServicingPR }
        'ccm_client' { $state = Test-CcmClientPR }
        'computer_rename' { $state = Test-ComputerRenamePR }
        'dsc_lcm' { $state = Test-DscLcmPR }
        'dvd_reboot_signal' { $state = Test-DVDRebootSignal }
        'file_rename' { $state = Test-FileRenamePR }
        'join_domain' { $state = Test-JoinDomainPR }
        'server_manager' { $state = Test-ServerManagerPR }
        'windows_update' { $state = Test-WindowsUpdatePR }
    }

    $checks_results.Add($c, $state)
}

$module.Result.checks = $checks_results
$module.Result.reboot_required = $checks_results.Values -contains $true

$module.ExitJson()
