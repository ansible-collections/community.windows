#!powershell
# (c) 2018, Ansible by Red Hat, inc
# GNU General Public License v3.0+ (see LICENSES/GPL-3.0-or-later.txt or https://www.gnu.org/licenses/gpl-3.0.txt)
# SPDX-License-Identifier: GPL-3.0-or-later
#Requires -Module Ansible.ModuleUtils.Legacy

$params = Parse-Args $args -supports_check_mode $true

$dest = Get-AnsibleParam -obj $params -name "dest" -type "string"
$port = Get-AnsibleParam -obj $params -name "port" -type "int"

$result = @{
    changed = $false
    state = ""
    status = ""
    info = ""
}

$socket = new-object Net.Sockets.TcpClient

try {
    # This would trigger tcp handshake
    $socket.Connect($dest, $port)
    $result.changed = $true
    $result.state = "success"
    $result.status = "connected"
}
catch [System.Management.Automation.MethodInvocationException] {
    if ("$($Error[0])" -like "*target machine actively refused it*") {
        $result.state = "fail"
        $result.status = "refused"
        $result.info = "$($Error[0])"
    }
    elseif ("$($Error[0])" -like "*A connection attempt failed because the connected party did not properly respond after a period of time*") {
        $result.state = "fail"
        $result.status = "timeout"
        $result.info = "$($Error[0])"
    }
}

Exit-Json $result