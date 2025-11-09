# OBS! Kræver at PowerShell kører med administratorrettigheder.


# Hent alle processer.
$processes = Get-Process -IncludeUserName

# Gå igennem hver proces i listen
foreach ($proc in $processes) {
    Write-Host "______________"
    
    # Udskriv de samme tre nøgle-værdi par
    Write-Host "pid: $($proc.Id)"
    Write-Host "name: $($proc.ProcessName)"
    Write-Host "username: $($proc.UserName)"
}