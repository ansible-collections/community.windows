#!powershell
# Copyright: (c) 2021 Sebastian Gruber (@sgruber94) ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options             = @{
        mode = @{ type = "str"; choices = "sysvolonly", "forceupdate"; required =$true}
        ou   = @{ type = "str"; aliases = @("organizational_unit") }
    }
    supports_check_mode = $false
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$mode = $module.Params.mode
$ou = $module.Params.ou
try {
    Import-Module GroupPolicy
} catch {
    $module.FailJson("win_gpo_force requires the GroupPolicy PS module to be installed")
}
function Invoke-forcedgpo {
    param(
        [string]$oucomputer	# Push gpupdate after AD & SYSVOL Replication
    )
    # Check for DFSR cmd tools
    if ((Get-WindowsFeature -Name RSAT-DFS-Mgmt-Con).InstallState -ne "Installed") {
        Install-WindowsFeature -Name RSAT-DFS-Mgmt-Con
    }
    # Check powershell console for UAC
    #requires -RunAsAdministrator
    # Force Replication of all Partitions between Domain Controllers
    (Get-ADDomainController -filter *).Name | ForEach-Object { repadmin /syncall $_ (Get-ADDomain).DistinguishedName /e /A | Out-Null }
    Start-Sleep 5
    Get-ADReplicationPartnerMetadata -Target "$env:Userdnsdomain" -Scope Domain | Format-Table Server, LastreplicationSuccess -a
    # Sync Sysvol
    $localdc = $env:computername
    $remotedc = @() + ((Get-ADDomainController -filter *).Name | Where-Object { $_ -notlike $localdc })
    # Sync local
    DFSRDIAG PollAD
    Start-Sleep 5
    # Sync remote
    Foreach ($remote in $remotedc) {
        $scriptblock = $ExecutionContext.InvokeCommand.NewScriptBlock("DFSRDIAG PollAD")
        $session = New-PSSession -computername $remote
        Invoke-Command $session -ScriptBlock $scriptblock
        Remove-PSSession $session
        Start-Sleep 5
    }
    if ($OuComputer) {
        # Read all Computers of OU
        $computers = (Get-ADComputer -filter { Enabled -eq $true } -searchbase $OuComputer | Sort-Object name).Name
        ForEach ($computer in $computers) {
            Invoke-GPUpdate -Computer $computer -RandomDelayInMinutes 0 -force
        }
        $result.changed = $true
    }
}
if($mode -eq "forceupdate") {
    if ($ou) {
        try {
            Invoke-forcedgpo -OuComputer $ou
            $module.Result.changed = $true
        } catch {
            $module.FailJson("an exception occurred when updating GPO - $($_.Exception.Message)")
        }
    } else {
        $module.FailJson("OU not specified")
    }
}
if($mode -eq "sysvolonly") {
    Invoke-forcedgpo
    $module.Result.changed = $true
}
$module.ExitJson()
