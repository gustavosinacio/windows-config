
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if (!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Output "Run this script on elevated shell"
  exit 1
}


$profileConfigFolder = "C:\Users\gsina\Documents\PowerShell"
$powershellConfigFile = "Microsoft.PowerShell_profile.ps1"
$vscodeConfigFile = "Microsoft.VSCode_profile.ps1"

# $powershellConfigFileExits = Test-Path "$profileConfigFolder\$powershellConfigFile"  -PathType Leaf
# $vscodeConfigFileExits = Test-Path "$profileConfigFolder\$vscodeConfigFile"  -PathType Leaf

# if ($powershellConfigFileExits) {
#   Write-Output "PowerShell config file found. Removing."
#   Remove-Item "$profileConfigFolder\$powershellConfigFile"
# }
# if ($vscodeConfigFileExits) {
#   Write-Output "VSCode PowerShell config file found. Removing."
#   Remove-Item "$profileConfigFolder\$powershellConfigFile"
# }
# 
# New-Item -ItemType SymbolicLink -Path $powershellConfigFile -Target powershellProfile.ps1

Write-Output "Copying PowerShell config" 
Copy-Item .\powershellProfile.ps1 "$profileConfigFolder\$powershellConfigFile"
.\MakeLink.ps1 "$profileConfigFolder\$powershellConfigFile"  "$(Get-Location)\powershellProfile.ps1"

Write-Output "Copying VSCode PowerShell config" 
.\MakeLink.ps1 "$profileConfigFolder\$vscodeConfigFile" "$(Get-Location)\powershellProfile.ps1"
