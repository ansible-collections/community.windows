#!powershell

#Requires -Module Ansible.ModuleUtils.Legacy

$params = Parse-Args $args -supports_check_mode $true

$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false

$dest = Get-AnsibleParam -obj $params -name "dest" -type "string"
$port = Get-AnsibleParam -obj $params -name "port" -type "int"

$result = @{
    changed = $false
    state = ""
    status = ""
    info = ""
}

$socket = new-object Net.Sockets.TcpClient

try{
  # This would trigger tcp handshake
  $socket.Connect($dest, $port)
  $result.changed = $true
  $result.status = "success"
  $result.result = "connected"
}
catch [System.Management.Automation.MethodInvocationException] {
  if ("$($Error[0])" -like "*target machine actively refused it*") {
    $result.state = "fail"
    $result.status = "refused"
    $result.info = "$($Error[0])"
  }
  elseif ("$($Error[0])" -like "*A connection attempt failed because the connected party did not properly respond after a period of time*") {
    $result.status = "fail"
    $result.status = "timeout"
    $result.info = "$($Error[0])"
  }
}

Exit-Json $result