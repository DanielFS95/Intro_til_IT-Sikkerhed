# 1. Hent Hostname
$hostname = [System.Net.Dns]::GetHostName()
Write-Host "Hostname: $hostname"

# 2. Hent IP-adresse ved at slå hostnavnet op
$hostEntry = [System.Net.Dns]::GetHostEntry($hostname)

# Vi finder den første IPv4-adresse på listen
# 'InterNetwork' er .NET-navnet for IPv4
$ipAddress = $hostEntry.AddressList | Where-Object { 
    $_.AddressFamily -eq 'InterNetwork' 
} | Select-Object -First 1

# 3. Print IP-adressen
Write-Host "IP Address: $($ipAddress.IPAddressToString)"