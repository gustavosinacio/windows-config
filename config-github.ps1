$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if (!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Output "Run this script on elevated shell"
  exit 1
}

$configFolder = "$env:USERPROFILE"
$configFile = ".gitconfig"

Remove-Item "$configFolder\$configFile"

Write-Output "Copying github file" 
.\MakeLink.ps1 "$configFolder\$configFile" "$(Get-Location)\git\.gitconfig"

