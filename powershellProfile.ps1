# Shows navigable menu of all options when hitting Tab
# Get-PSReadLineKeyHandler -> will show keys available to psreadline
# References: https://learn.microsoft.com/en-us/dotnet/api/microsoft.powershell.psconsolereadline.endofline?view=powershellsdk-1.1.0#applies-to

Import-Module posh-git


# Important Variables ----------------------------------------------------------
$WindowsConfig = "$env:USERPROFILE\github\windows-config"

function UpdatePwsh {
  . $WindowsConfig\pwsh7-install  
}


$width = (Get-Host).UI.RawUI.MaxWindowSize.Width
$character = "-"
$line = $character * $width


Set-PSReadLineKeyHandler -Chord '"', "'" `
  -BriefDescription SmartInsertQuote `
  -LongDescription "Insert paired quotes if not already on a quote" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($line.Length -gt $cursor -and $line[$cursor] -eq $key.KeyChar) {
    # Just move the cursor
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
  }
  else {
    # Insert matching quotes, move cursor to be in between the quotes
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)" * 2)
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor - 1)
  }
}

$versionMinimum = [Version]'7.3'
if ($PSVersionTable.PSVersion -ge $versionMinimum) {
  Set-PSReadLineOption -PredictionSource HistoryAndPlugin
}
else {
  Set-PSReadLineOption -PredictionSource History
}

Set-PSReadLineOption -PredictionViewStyle ListView


# Keys -------------------------------------------------------------------------
Set-PSReadLineKeyHandler `
  -Key Alt+s `
  -BriefDescription SaveInHistory `
  -LongDescription "Save current line in history without excecuting" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
  [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
}

# ------------------------------------------------------------------------------
Set-PSReadlineKeyHandler `
  -Key Tab `
  -Function MenuComplete
  
# ------------------------------------------------------------------------------
Set-PSReadLineKeyHandler `
  -Key UpArrow `
  -BriefDescription HistorySearchBackward `
  -LongDescription "Search backwards through history" `
  -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::HistorySearchBackward()
  [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}

# ------------------------------------------------------------------------------
Set-PSReadLineKeyHandler `
  -Key DownArrow `
  -BriefDescription HistorySearchForward `
  -LongDescription "Search forwards through history" `
  -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::HistorySearchForward()
  [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}

# ------------------------------------------------------------------------------
Set-PSReadLineKeyHandler -Key F7 `
  -BriefDescription History `
  -LongDescription 'Show command history' `
  -ScriptBlock {
  $pattern = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
  if ($pattern) {
    $pattern = [regex]::Escape($pattern)
  }

  $history = [System.Collections.ArrayList]@(
    $last = ''
    $lines = ''
    foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath)) {
      if ($line.EndsWith('`')) {
        $line = $line.Substring(0, $line.Length - 1)
        $lines = if ($lines) {
          "$lines`n$line"
        }
        else {
          $line
        }
        continue
      }

      if ($lines) {
        $line = "$lines`n$line"
        $lines = ''
      }

      if (($line -cne $last) -and (!$pattern -or ($line -match $pattern))) {
        $last = $line
        $line
      }
    }
  )
  $history.Reverse()

  $command = $history | Out-GridView -Title History -PassThru
  if ($command) {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
  }
}

# ------------------------------------------------------------------------------
Set-PSReadLineKeyHandler -Key Alt+a `
  -BriefDescription SelectCommandArguments `
  -LongDescription "Set current selection to next command argument in the `
  command line. Use of digit argument selects argument by position" `
  -ScriptBlock {
  param($key, $arg)
  
  $ast = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$null, [ref]$null, [ref]$cursor)
  
  $asts = $ast.FindAll( {
      $args[0] -is [System.Management.Automation.Language.ExpressionAst] -and
      $args[0].Parent -is [System.Management.Automation.Language.CommandAst] -and
      $args[0].Extent.StartOffset -ne $args[0].Parent.Extent.StartOffset
    }, $true)
  
  if ($asts.Count -eq 0) {
    [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
    return
  }
    
  $nextAst = $null

  if ($null -ne $arg) {
    $nextAst = $asts[$arg - 1]
  }
  else {
    foreach ($ast in $asts) {
      if ($ast.Extent.StartOffset -ge $cursor) {
        $nextAst = $ast
        break
      }
    } 
        
    if ($null -eq $nextAst) {
      $nextAst = $asts[0]
    }
  }

  $startOffsetAdjustment = 0
  $endOffsetAdjustment = 0

  if ($nextAst -is [System.Management.Automation.Language.StringConstantExpressionAst] -and
    $nextAst.StringConstantType -ne [System.Management.Automation.Language.StringConstantType]::BareWord) {
    $startOffsetAdjustment = 1
    $endOffsetAdjustment = 2
  }
  
  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($nextAst.Extent.StartOffset + $startOffsetAdjustment)
  [Microsoft.PowerShell.PSConsoleReadLine]::SetMark($null, $null)
  [Microsoft.PowerShell.PSConsoleReadLine]::SelectForwardChar($null, ($nextAst.Extent.EndOffset - $nextAst.Extent.StartOffset) - $endOffsetAdjustment)
}


# ------------------------------------------------------------------------------
# Each time you press Alt+', this key handler will change the token
# under or before the cursor.  It will cycle through single quotes,
# double quotes, or no quotes each time it is invoked.
Set-PSReadLineKeyHandler -Key "Alt+'" `
  -BriefDescription ToggleQuoteArgument `
  -LongDescription "Toggle quotes on the argument under the cursor" `
  -ScriptBlock {
  param($key, $arg)

  $ast = $null
  $tokens = $null
  $errors = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

  $tokenToChange = $null
  foreach ($token in $tokens) {
    $extent = $token.Extent
    if ($extent.StartOffset -le $cursor -and $extent.EndOffset -ge $cursor) {
      $tokenToChange = $token

      # If the cursor is at the end (it's really 1 past the end) of the previous token,
      # we only want to change the previous token if there is no token under the cursor
      if ($extent.EndOffset -eq $cursor -and $foreach.MoveNext()) {
        $nextToken = $foreach.Current
        if ($nextToken.Extent.StartOffset -eq $cursor) {
          $tokenToChange = $nextToken
        }
      }
      break
    }
  }

  if ($tokenToChange -ne $null) {
    $extent = $tokenToChange.Extent
    $tokenText = $extent.Text
    if ($tokenText[0] -eq '"' -and $tokenText[-1] -eq '"') {
      # Switch to no quotes
      $replacement = $tokenText.Substring(1, $tokenText.Length - 2)
    }
    elseif ($tokenText[0] -eq "'" -and $tokenText[-1] -eq "'") {
      # Switch to double quotes
      $replacement = '"' + $tokenText.Substring(1, $tokenText.Length - 2) + '"'
    }
    else {
      # Add single quotes
      $replacement = "'" + $tokenText + "'"
    }

    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
      $extent.StartOffset,
      $tokenText.Length,
      $replacement)
  }
}

# ------------------------------------------------------------------------------
# Sometimes you want to get a property of invoke a member on what you've entered so far
# but you need parens to do that.  This binding will help by putting parens around the current selection,
# or if nothing is selected, the whole line.
Set-PSReadLineKeyHandler -Key 'Alt+(' `
  -BriefDescription ParenthesizeSelection `
  -LongDescription "Put parenthesis around the selection or entire line and move the cursor to after the closing parenthesis" `
  -ScriptBlock {
  param($key, $arg)

  $selectionStart = $null
  $selectionLength = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
  if ($selectionStart -ne -1) {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, '(' + $line.SubString($selectionStart, $selectionLength) + ')')
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
  }
  else {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, '(' + $line + ')')
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
  }
}

# ------------------------------------------------------------------------------
# Ctrl+Shift+j then type a key to mark the current directory.
# Ctrj+j then the same key will change back to that directory without
# needing to type cd and won't change the command line.
$global:PSReadLineMarks = @{}

Set-PSReadLineKeyHandler -Key Ctrl+J `
  -BriefDescription MarkDirectory `
  -LongDescription "Mark the current directory" `
  -ScriptBlock {
  param($key, $arg)

  $key = [Console]::ReadKey($true)
  $global:PSReadLineMarks[$key.KeyChar] = $pwd
}

# ------------------------------------------------------------------------------
Set-PSReadLineKeyHandler -Key Ctrl+j `
  -BriefDescription JumpDirectory `
  -LongDescription "Go to the marked directory" `
  -ScriptBlock {
  param($key, $arg)

  $key = [Console]::ReadKey()
  $dir = $global:PSReadLineMarks[$key.KeyChar]
  if ($dir) {
    Set-Location $dir
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  }
}

# ------------------------------------------------------------------------------
Set-PSReadLineKeyHandler -Key Alt+j `
  -BriefDescription ShowDirectoryMarks `
  -LongDescription "Show the currently marked directories" `
  -ScriptBlock {
  param($key, $arg)

  $global:PSReadLineMarks.GetEnumerator() | ForEach-Object {
    [PSCustomObject]@{Key = $_.Key; Dir = $_.Value } } |
  Format-Table -AutoSize | Out-Host

  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}

function Set-WindowTitle {

}

function Prompt {
  $GitPromptSettings.DefaultPromptPath.ForegroundColor = 0x80ffff
  $GitPromptSettings.DefaultPromptBeforeSuffix.Text = ''
  $GitPromptSettings.BranchColor.ForegroundColor = '0x03f060'
  $GitPromptSettings.BeforeStatus.ForegroundColor = '0xe3ff00'
  $GitPromptSettings.AfterStatus.ForegroundColor = '0xe3ff00'
  $GitPromptSettings.DelimStatus.ForegroundColor = '0xe3ff00'
  $GitPromptSettings.WorkingColor.ForegroundColor = '0xff6040'
  $GitPromptSettings.LocalWorkingStatusSymbol.ForegroundColor = '0x4070ff'

  $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = 1
  $GitPromptSettings.DefaultPromptAbbreviateGitDirectory = 0
  $GitPromptSettings.DefaultPromptWriteStatusFirst = 0
  $GitPromptSettings.DefaultPromptEnableTiming = 1
  $GitPromptSettings.DefaultPromptTimingFormat.Text = " {0}ms "

  $GitPromptSettings.WindowTitle = 
  "$(if ($IsAdmin) {'Admin: '})$(if ($GitStatus) {
    "$($GitStatus.RepoName) [$($GitStatus.Branch)]"
  } else { Get-PromptPath })
  $(if ([IntPtr]::Size -eq 4) {'32-bit '})"

  & $GitPromptScriptBlock

}

# Run other scripts ------------------------------------------------------------ 
. $WindowsConfig\aliases.ps1