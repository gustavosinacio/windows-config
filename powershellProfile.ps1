# Shows navigable menu of all options when hitting Tab
# Get-PSReadLineKeyHandler -> will show keys available to psreadline
# References: https://learn.microsoft.com/en-us/dotnet/api/microsoft.powershell.psconsolereadline.endofline?view=powershellsdk-1.1.0#applies-to

# ------------------------------------------------------------------------------

# Basic editing functions
# =======================

# Key              Function            Description
# ---              --------            -----------
# Enter            AcceptLine          Accept the input or move to the
#                                      next line if input is missing a
#                                      closing token.
# Shift+Enter      AddLine             Move the cursor to the next line
#                                      without attempting to execute the
#                                      input
# Backspace        BackwardDeleteChar  Delete the character before the
#                                      cursor
# Ctrl+h           BackwardDeleteChar  Delete the character before the
#                                      cursor
# Ctrl+Home        BackwardDeleteInput Delete text from the cursor to the
#                                      start of the input
# Ctrl+Backspace   BackwardKillWord    Move the text from the start of
#                                      the current or previous word to
#                                      the cursor to the kill ring
# Ctrl+w           BackwardKillWord    Move the text from the start of
#                                      the current or previous word to
#                                      the cursor to the kill ring
# Ctrl+C           Copy                Copy selected region to the system
#                                      clipboard.  If no region is
#                                      selected, copy the whole line
# Ctrl+c           CopyOrCancelLine    Either copy selected text to the
#                                      clipboard, or if no text is
#                                      selected, cancel editing the line
#                                      with CancelLine.
# Ctrl+x           Cut                 Delete selected region placing
#                                      deleted text in the system
#                                      clipboard
# Delete           DeleteChar          Delete the character under the
#                                      cursor
# Ctrl+End         ForwardDeleteInput  Delete text from the cursor to the
#                                      end of the input
# Ctrl+Enter       InsertLineAbove     Inserts a new empty line above the
#                                      current line without attempting to
#                                      execute the input
# Shift+Ctrl+Enter InsertLineBelow     Inserts a new empty line below the
#                                      current line without attempting to
#                                      execute the input
# Alt+d            KillWord            Move the text from the cursor to
#                                      the end of the current or next
#                                      word to the kill ring
# Ctrl+Delete      KillWord            Move the text from the cursor to
#                                      the end of the current or next
#                                      word to the kill ring
# Ctrl+v           Paste               Paste text from the system
#                                      clipboard
# Shift+Insert     Paste               Paste text from the system
#                                      clipboard
# Ctrl+y           Redo                Redo an undo
# Escape           RevertLine          Equivalent to undo all edits
#                                      (clears the line except lines
#                                      imported from history)
# Ctrl+z           Undo                Undo a previous edit
# Alt+.            YankLastArg         Copy the text of the last argument
#                                      to the input

# Cursor movement functions
# =========================

# Key             Function        Description
# ---             --------        -----------
# LeftArrow       BackwardChar    Move the cursor back one character
# Ctrl+LeftArrow  BackwardWord    Move the cursor to the beginning of the
#                                 current or previous word
# Home            BeginningOfLine Move the cursor to the beginning of the
#                                 line
# End             EndOfLine       Move the cursor to the end of the line
# RightArrow      ForwardChar     Move the cursor forward one character
# Ctrl+]          GotoBrace       Go to matching brace
# Ctrl+RightArrow NextWord        Move the cursor forward to the start of
#                                 the next word

# History functions
# =================

# Key       Function              Description
# ---       --------              -----------
# Alt+F7    ClearHistory          Remove all items from the command line
#                                 history (not PowerShell history)
# Ctrl+s    ForwardSearchHistory  Search history forward interactively
# UpArrow   HistorySearchBackward Search backwards through history
# F8        HistorySearchBackward Search for the previous item in the
#                                 history that starts with the current
#                                 input - like PreviousHistory if the
#                                 input is empty
# DownArrow HistorySearchForward  Search forwards through history
# Shift+F8  HistorySearchForward  Search for the next item in the history
#                                 that starts with the current input -
#                                 like NextHistory if the input is empty
# Ctrl+r    ReverseSearchHistory  Search history backwards interactively

# Completion functions
# ====================

# Key           Function            Description
# ---           --------            -----------
# Tab           MenuComplete        Complete the input if there is a
#                                   single completion, otherwise complete
#                                   the input by selecting from a menu of
#                                   possible completions.
# Ctrl+@        MenuComplete        Complete the input if there is a
#                                   single completion, otherwise complete
#                                   the input by selecting from a menu of
#                                   possible completions.
# Ctrl+Spacebar MenuComplete        Complete the input if there is a
#                                   single completion, otherwise complete
#                                   the input by selecting from a menu of
#                                   possible completions.
# Shift+Tab     TabCompletePrevious Complete the input using the previous
#                                   completion

# Prediction functions
# ====================

# Key Function             Description
# --- --------             -----------
# F2  SwitchPredictionView Switch between the inline and list prediction
#                          views.

# Miscellaneous functions
# =======================

# Key           Function              Description
# ---           --------              -----------
# Ctrl+l        ClearScreen           Clear the screen and redraw the
#                                     current line at the top of the
#                                     screen
# Alt+0         DigitArgument         Start or accumulate a numeric
#                                     argument to other functions
# Alt+1         DigitArgument         Start or accumulate a numeric
#                                     argument to other functions
# Alt+2         DigitArgument         Start or accumulate a numeric
#                                     argument to other functions
# Alt+3         DigitArgument         Start or accumulate a numeric
#                                     argument to other functions
# Alt+4         DigitArgument         Start or accumulate a numeric
#                                     argument to other functions
# Alt+5         DigitArgument         Start or accumulate a numeric
#                                     argument to other functions
# Alt+6         DigitArgument         Start or accumulate a numeric
#                                     argument to other functions
# Alt+7         DigitArgument         Start or accumulate a numeric
#                                     argument to other functions
# Alt+8         DigitArgument         Start or accumulate a numeric
#                                     argument to other functions
# Alt+9         DigitArgument         Start or accumulate a numeric
#                                     argument to other functions
# Alt+-         DigitArgument         Start or accumulate a numeric
#                                     argument to other functions
# PageDown      ScrollDisplayDown     Scroll the display down one screen
# Ctrl+PageDown ScrollDisplayDownLine Scroll the display down one line
# PageUp        ScrollDisplayUp       Scroll the display up one screen
# Ctrl+PageUp   ScrollDisplayUpLine   Scroll the display up one line
# F1            ShowCommandHelp       Shows help for the command at the
#                                     cursor in an alternate screen
#                                     buffer.
# Ctrl+Alt+?    ShowKeyBindings       Show all key bindings
# Alt+h         ShowParameterHelp     Shows help for the parameter at the
#                                     cursor.
# Alt+?         WhatIsKey             Show the key binding for the next
#                                     chord entered

# Selection functions
# ===================

# Key                   Function            Description
# ---                   --------            -----------
# Ctrl+a                SelectAll           Select the entire line. Moves
#                                           the cursor to the end of the
#                                           line
# Shift+LeftArrow       SelectBackwardChar  Adjust the current selection
#                                           to include the previous
#                                           character
# Shift+Home            SelectBackwardsLine Adjust the current selection
#                                           to include from the cursor to
#                                           the start of the line
# Shift+Ctrl+LeftArrow  SelectBackwardWord  Adjust the current selection
#                                           to include the previous word
# Shift+RightArrow      SelectForwardChar   Adjust the current selection
#                                           to include the next character
# Shift+End             SelectLine          Adjust the current selection
#                                           to include from the cursor to
#                                           the end of the line
# Shift+Ctrl+RightArrow SelectNextWord      Adjust the current selection
#                                           to include the next word

# Search functions
# ================

# Key      Function                Description
# ---      --------                -----------
# F3       CharacterSearch         Read a character and move the cursor
#                                  to the next occurence of that character
# Shift+F3 CharacterSearchBackward Read a character and move the cursor
#                                  to the previous occurence of that
#                                  character

# User defined functions
# ======================

# Key   Function               Description
# ---   --------               -----------
# F7    History                Show command history
# Alt+s SaveInHistory          Save current line in history without
#                              excecuting
# Alt+a SelectCommandArguments Set current selection to next command
#                              argument in the command line. Use of digit
#                              argument selects argument by position
# "     SmartInsertQuote       Insert paired quotes if not already on a
#                              quote
# '     SmartInsertQuote       Insert paired quotes if not already on a
#                              quote


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

  $global:PSReadLineMarks.GetEnumerator() | % {
    [PSCustomObject]@{Key = $_.Key; Dir = $_.Value } } |
  Format-Table -AutoSize | Out-Host

  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}


# Aliases ----------------------------------------------------------------------
# ------------------------------------------------------------------------------
New-Alias grep Select-String
# ------------------------------------------------------------------------------