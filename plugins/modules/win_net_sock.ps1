#!powershell

#Requires -Module Ansible.ModuleUtils.Legacy

$params = Parse-Args $args -supports_check_mode $true

$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false

$port = Get-AnsibleParam -obj $params -name "port" -type "int"
$state = Get-AnsibleParam -obj $params -name "state" -type "string"
$type = Get-AnsibleParam -obj $params -name "type" -type "string"

$result = @{
    changed = $false
    msg = ""
}

if (($port -le 0) -or ($port -gt 65535))
{
    Fail-Json -obj "Port $port, out of range. Port should be 16 bit integer."
}

if (($type -ne 'tcp') -or ($type -ne 'udp')) {
    Fail-Json -obj $result -message "Socket type is neither tcp nor udp, see usage examples."
}

if (($state -ne 'absent') -or ($state -ne 'present')) {
    Fail-Json -obj $result -message "State is neither absent nor present, see usage examples."
}


if ($state -eq 'present')
{
    try{
        Start-Process powershell -ArgumentList "-NoExit", "-Command", {
            if ($type -eq 'tcp')
            {
                $Listener = [System.Net.Sockets.TcpListener]$port;
                $Listener.start()
                while ($true)
                {
                    $Listener.AcceptTcpClient()
                }
            }
            
            else if ($type -eq 'udp')
            {
                $endpoint = New-Object System.Net.IPEndPoint ([IPAddress]::Any, $port)
                try {
                    while($true) {
                        $socket = New-Object System.Net.Sockets.UdpClient $port
                        $content = $socket.Receive([ref]$endpoint)
                        $socket.Close()
                        [Text.Encoding]::ASCII.GetString($content)
                    }
                } catch {
                    Fail-Json -obj $result -message "$($Error[0])"
                }
            }
        } -NoNewWindow
        $procId = (Get-NetTCPConnection -LocalPort $port).OwningProcess
        $result.changed = $true
        $result.msg = "Running process on port $port on pid $procId"
    }
    catch [] {
        $result.changed = $false
        $result.msg = "Failed running the process with err msg: $_"
        Fail-Json -obj $result 
    }
}

else if ($state -eq 'absent')
{
    try {
        $procId = (Get-NetTCPConnection -LocalPort 3000).OwningProcess
        Stop-Process -Id $procId -Force
        $result.changed = $true
        $result.msg = "Success stopping the process with pid $procId"
    }
    catch [] {
        $result.changed = $false
        $result.msg = "Failed stopping the process with err msg: $_"
    }
}

return $result