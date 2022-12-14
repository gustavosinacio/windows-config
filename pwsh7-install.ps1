Write-Output "Updating powershell"
winget install --id=Microsoft.PowerShell -e

Write-Output "Installed Version:"
(Get-Command 'C:\Program Files\PowerShell\7\pwsh.exe').Version 
