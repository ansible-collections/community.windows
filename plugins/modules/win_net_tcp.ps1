#!powershell

#Requires -Module Ansible.ModuleUtils.Legacy

$params = Parse-Args $args -supports_check_mode $true

$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false

$dest = Get-AnsibleParam -obj $params -name "dest" -type "string"
$port = Get-AnsibleParam -obj $params -name "port" -type "int"

$result = @{
    changed = $false
    msg = ""
}

$socket = new-object Net.Sockets.TcpClient

try{
  $socket.Connect($dest, $port)
}
catch [System.Management.Automation.MethodInvocationException] {
  if ($_ -like "*target machine actively refused it*") {
    $result.msg = "The connection was actively refused!"
  }
  else if ($_ -like "*A connection attempt failed because the connected party did not properly respond after a period of time*") {
    $result.msg = "The connection timed out because the partner did not respond"
  }
  "ok"
}


