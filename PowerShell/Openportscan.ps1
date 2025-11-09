# 1. Spørg brugeren om vært og porte
$targetHost = Read-Host -Prompt "Which host do you want to scan? (IP or domain)"
$portsInput = Read-Host -Prompt "Which ports do you want to scan? (separate with commas)"

# 2. Konverter port-strengen til en liste af heltal (integers)
$portsArray = $portsInput.Split(',') | ForEach-Object {
    try {
        [int]$_
    }
    catch {
        Write-Warning "Skipping invalid port: '$_'"
    }
}

$timeout = 1000  # 1 sekund

Write-Host "" 

# 3. Loop gennem hver port
foreach ($port in $portsArray) {
    $tcpClient = New-Object System.Net.Sockets.TcpClient
    
    try {
        $connectionAttempt = $tcpClient.ConnectAsync($targetHost, $port)
        
        if ($connectionAttempt.Wait($timeout)) {
            if ($tcpClient.Connected) {
                Write-Host "Port $port on $targetHost is open." -ForegroundColor Green
            }
            else {
                Write-Host "Port $port on $targetHost is closed or unreachable." -ForegroundColor Red
            }
        }
        else {
            Write-Host "Port $port on $targetHost is closed or unreachable (Timeout)." -ForegroundColor Red
        }
    }
    catch {
        Write-Host "Port $port on $targetHost is closed or unreachable." -ForegroundColor Red
    }
    finally {
        $tcpClient.Close()
        $tcpClient.Dispose()
    }
}