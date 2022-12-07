
# Check if terminal is elevated
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if (!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Output "Run this script on elevated shell"
  exit 1
}

# Install latest powershell
.\pswh7-install.ps1

# Config pwsh terminal
.\terminal-config.ps1

# Config choco
.\choco-install.ps1