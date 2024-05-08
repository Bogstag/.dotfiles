

class PSReadLine : ScoopApps {

    PSReadLine() {
        $this.Logo = @"
░░░█▀█░█▀▀░█▀▄░█▀▀░█▀█░█▀▄░█░░░▀█▀░█▀█░█▀▀░
░░░█▀▀░▀▀█░█▀▄░█▀▀░█▀█░█░█░█░░░░█░░█░█░█▀▀░
░░░▀░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░
A bash inspired readline implementation for PowerShell
"@
        $this.Name = "PSReadLine"
        $this.Id = "psreadline"
        $this.MyPM = "Scoop"
        $this.Store = "extras"
        $this.VerifyFile = "$Env:SCOOP\modules\PSReadLine\PSReadLine.psd1"
        $this.GithubOwnerRepo = "PowerShell/PSReadLine"
        $this.DocsUrl = "https://github.com/PowerShell/PSReadLine"
        $this.ChangeLogUrl = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        # or https://github.com/PowerShell/PSReadLine/blob/master/PSReadLine/Changes.txt
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
    }

    [void] Enable() {
        # Get-PSReadLineOption
        # Get-PSReadLineKeyHandler
        # Import-Module PSReadLine
        Set-PSReadLineOption -BellStyle "None"
        Set-PSReadLineOption -HistorySearchCursorMovesToEnd
        #Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
        #Set-PSReadLineOption -PredictionViewStyle "ListView"
        #Set-PSReadLineKeyHandler -Chord "Tab" -Function "MenuComplete"
        Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
        Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
        Set-PSReadLineKeyHandler -Key Tab -Function Complete

        Set-PSReadLineOption -Colors @{
            #  "InlinePrediction" = [ConsoleColor]::DarkGray
            "InlinePrediction" = [ConsoleColor]::Magenta
        }

        # This key handler shows the entire or filtered history using Out-GridView. The
        # typed text is used as the substring pattern for filtering. A selected command
        # is inserted to the command line without invoking. Multiple command selection
        # is supported, e.g. selected by Ctrl + Click.
        # As another example, the module "F7History" does something similar but uses the
        # console GUI instead of Out-GridView. Details about this module can be found at
        # PowerShell Gallery: https://www.powershellgallery.com/packages/F7History.
        Set-PSReadLineKeyHandler -Key F7 `
            -BriefDescription History `
            -LongDescription "Show command history" `
            -ScriptBlock {
            $pattern = $null
            [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
            if ($pattern) {
                $pattern = [regex]::Escape($pattern)
            }

            $history = [System.Collections.ArrayList]@(
                $last = ""
                $lines = ""
                foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath)) {
                    if ($line.EndsWith('`')) {
                        $line = $line.Substring(0, $line.Length - 1)
                        $lines = if ($lines) {
                            '$lines`n$line'
                        } else {
                            $line
                        }
                        continue
                    }

                    if ($lines) {
                        $line = '$lines`n$line'
                        $lines = ""
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
                [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join '`n'))
            }
        }

        # `ForwardChar` accepts the entire suggestion text when the cursor is at the end of the line.
        # This custom binding makes `RightArrow` behave similarly - accepting the next word instead of the entire suggestion text.
        Set-PSReadLineKeyHandler -Key RightArrow `
            -BriefDescription ForwardCharAndAcceptNextSuggestionWord `
            -LongDescription 'Move cursor one character to the right in the current editing line and accept the next word in suggestion when its at the end of current editing line' `
            -ScriptBlock {
            param($key, $arg)

            $line = $null
            $cursor = $null
            [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

            if ($cursor -lt $line.Length) {
                [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
            } else {
                [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
            }
        }
    }
    # [void] Invoke() {}

    # [void] SetEnvironmentVariables() {
    #     # Logic to set app env variables
    #     $Value = ""
    #     if (($null -eq $Env:app_ENV_VAR) -or ($Value -ne $Env:app_ENV_VAR)) {
    #         [Environment]::SetEnvironmentVariable("app_ENV_VAR", "$Value", [EnvironmentVariableTarget]::User)
    #     }
    # }
}
[AppRunner]::InitApp("PSReadLine")
