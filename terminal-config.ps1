function CheckIfIsSymlink([string]$path) {
  $file = Get-Item $path -Force -ea SilentlyContinue
  return [bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint)
}


# ------------------------------------------------------------------------------
# Checj terminal's admin priviledges -------------------------------------------
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Output "Run this script on elevated shell"
  exit 1
}

# ------------------------------------------------------------------------------
# Setup files locations --------------------------------------------------------
$terminalConfigFile = "C:\Users\gsina\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
$terminalConfigFileExits = Test-Path $terminalConfigFile  -PathType Leaf

$terminalElevatedConfigFile = "C:\Users\gsina\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\elevated-state.json"
$terminalElevatedConfigFileExits = Test-Path $terminalElevatedConfigFile  -PathType Leaf
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Create a symlink for terminal settings if one doesn't exist yet --------------
if ($terminalConfigFileExits -and !(CheckIfIsSymlink $terminalConfigFile)) {
  Remove-Item $terminalConfigFile
  .\MakeLink.ps1 $terminalConfigFile "$(Get-Location)\settings.json"
}
else {
  Write-Output "*** Symlink already exists --> $terminalConfigFile"
}
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Create a symlink for elevated terminal settings if one doesn't exist yet -----
if ($terminalElevatedConfigFileExits -and !(CheckIfIsSymlink $terminalElevatedConfigFile)) {
  Remove-Item $terminalElevatedConfigFile
  .\MakeLink.ps1 $terminalElevatedConfigFile "$(Get-Location)\elevated-state.json"
}
else {
  Write-Output "*** Symlink already exists --> $terminalElevatedConfigFile"
}
# ------------------------------------------------------------------------------
