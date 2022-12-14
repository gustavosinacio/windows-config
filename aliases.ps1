
# Aliases ----------------------------------------------------------------------
# ------------------------------------------------------------------------------
if (!((Test-Path Alias:grep) -eq "True")) {
  New-Alias grep Select-String

}

function res {
  Clear-Host; .$PROFILE;
}

function gst {
  Write-Output $line
  git status
  Write-Output $line
}

# ------------------------------------------------------------------------------
