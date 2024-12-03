#!powershell

#Requires -Module Ansible.ModuleUtils.Legacy

$params = Parse-Args $args -supports_check_mode $true

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

if (($type -ne 'tcp') -and ($type -ne 'udp')) {
    Fail-Json -obj $result -message "Socket type is neither tcp nor udp, see usage examples."
}

if (($state -ne 'absent') -and ($state -ne 'present')) {
    Fail-Json -obj $result -message "State is neither absent nor present, see usage examples."
}


if ($state -eq 'present')
{

    $script = {
        if ($type -eq 'tcp')
        {
            $Listener = [System.Net.Sockets.TcpListener]$port;
            $Listener.start()
            while ($true)
            {
                $Listener.AcceptTcpClient()
            }
        }
        
        elseif ($type -eq 'udp')
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
    }.toString()
    $script = $script.replace("`$port", $port).replace("`$type","`"$type`"")
    echo $script > 'script.ps1'
    try{
        $script_dir = (pwd).path
        # almost lost my mind trying to create completely detached process
        Invoke-WmiMethod -Path 'Win32_Process' -Name Create -ArgumentList "powershell.exe $script_dir\script.ps1"
        Start-Sleep 1
        Remove-Item -Force 'script.ps1'
        $procId = (Get-NetTCPConnection -LocalPort $port).OwningProcess
        $result.changed = $true
        $result.msg = "Running process on port $port on pid $procId"
    }
    catch {
        $result.changed = $false
        $result.msg = "Failed running the process with err msg: $_"
        Fail-Json -obj $result -message "Failed at validating the port is listening, with err msg:\n\t $_"
    }
}

elseif ($state -eq 'absent')
{
    try {
        $procId = (Get-NetTCPConnection -LocalPort $port).OwningProcess
        Stop-Process -Id $procId -Force
        $result.changed = $true
        $result.msg = "Success stopping the process with pid $procId"
    }
    catch {
        $result.changed = $false
        $result.msg = "Failed stopping the process with err msg: $_"
    }
}

Exit-Json $result