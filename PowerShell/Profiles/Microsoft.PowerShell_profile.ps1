using module My
# $ErrorActionPreference = "Continue"
# $DebugPreference = 'Continue'
# $ErrorActionPreference = "Stop"
# $ErrorActionPreference = "SilentlyContinue"
# $VerbosePreference = 'SilentlyContinue'
# $DebugPreference = 'SilentlyContinue'

$fileName = Split-Path -Leaf $PSCommandPath
Write-Host "Running $fileName"

# TODO: Add to dotfiles
Import-Module C:\Users\bogge\Documents\PowerShell\Modules\PowerShellGet
Import-Module C:\Users\bogge\Documents\PowerShell\Modules\PackageManagement
Import-Module C:\Users\bogge\Documents\PowerShell\Modules\Microsoft.PowerShell.PSResourceGet
Import-Module C:\Users\bogge\Documents\PowerShell\Modules\PSScriptAnalyzer
Import-Module C:\Users\bogge\scoop\modules\scoop-completion
# Import-Module C:\Users\bogge\scoop\modules\PSFzf
Import-Module C:\Users\bogge\scoop\modules\Pester
Import-Module C:\Users\bogge\scoop\modules\Microsoft.WinGet.Client
# Import-Module C:\Users\bogge\Documents\PowerShell\Modules\PSReadLine

$SecretScript = "$Env:dotfiles\PowerShell\Set-Secrets.ps1"
if (Test-Path $SecretScript) {
    . $SecretScript
} else {
    Write-Error "Unable to find SecretScript script at $SecretScript"
}

$AppCentralScript = "$Env:dotfiles\Apps\AppCentral.ps1"
if (Test-Path $AppCentralScript) {
    . $AppCentralScript -Command "enable-apps"
} else {
    Write-Error "Unable to find AppCentralScript script at $AppCentralScript"
}

$ExtProfileScript = "$Env:dotfiles\PowerShell\Extended-Profile.ps1"
if (Test-Path $ExtProfileScript) {
    . $ExtProfileScript
} else {
    Write-Error "Unable to find ExtProfileScript script at $ExtProfileScript"
}

Write-Host "    ______________________________________        " -ForegroundColor Green
Write-Host "    Loading personal profile took $($ProfileLoadTime.Milliseconds) ms." -ForegroundColor Green

# Log measurements
$logEntry = @{
    Timestamp    = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Milliseconds = $ProfileLoadTime.Milliseconds
    Measurements = $ProfileLoadTime.Measurements
}
$logFilePath = "$Env:dotfiles\ProfileLoadTime-$Env:COMPUTERNAME.csv"
try {
    # Check if the file exists and has content
    if (-Not (Test-Path $logFilePath)) {
        $logEntry | Export-Csv -Path $logFilePath -NoTypeInformation -UseQuotes AsNeeded -Encoding utf8BOM
    } else {
        $logEntry | Export-Csv -Path $logFilePath -Append -NoTypeInformation -UseQuotes AsNeeded -Encoding utf8BOM
    }
} catch {
    Write-Error "Failed to write log entry: $_"
}

$MySystemState.SaveAllState()
# $SaveSystemStateJob = Start-ThreadJob -ScriptBlock {
#     $MySystemState = $using:MySystemState
#     $MySystemState.SaveState()
# }
# $suaJob = Start-ThreadJob -ScriptBlock { Scoop Update * }
# Write-Host "sua job is running: Receive-Job -Job $suaJob"


# . $Env:dotfiles\PowerShell\prompt.ps1

# Template for measure
# Write-Host " ⏱️ X => " -NoNewline -ForegroundColor Green
# $t = Measure-Command {
#   . $HOME\x.ps1
# }
# Write-Host $t.Milliseconds"ms" -ForegroundColor Green

# Write-Host ""
# Write-Host "                        ██████╗  ██████╗ ██╗    ██╗███████╗██████╗ ███████╗██╗  ██╗███████╗██╗     ██╗     " -ForegroundColor Blue
# Write-Host "                        ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║     " -ForegroundColor Blue
# Write-Host "                        ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝███████╗███████║█████╗  ██║     ██║     " -ForegroundColor Blue
# Write-Host "                        ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗╚════██║██╔══██║██╔══╝  ██║     ██║     " -ForegroundColor Blue
# Write-Host "                        ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║███████║██║  ██║███████╗███████╗███████╗" -ForegroundColor Blue
# Write-Host "                        ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝" -ForegroundColor Blue
# Write-Host ""
# Write-Host "                     .+=====--===------------------:+:     " -ForegroundColor Blue
# Write-Host "                     *=:::::--:..:............      =-     " -ForegroundColor Blue
# Write-Host "                    -*.::::=@@%+:.::............   .*     " -ForegroundColor Blue
# Write-Host "                    *-::::::=%@@%+:..........      ==     " -ForegroundColor Blue
# Write-Host "                   :*:::::::..=%@@%=. .....        *     " -ForegroundColor Blue
# Write-Host "                   *-::::::::...=%@@%=....        ==     " -ForegroundColor Blue
# Write-Host "                  :*.::::::..... .*@@@%.          *     " -ForegroundColor Blue
# Write-Host "                  *-.::::::....-*@@@@*-          -=     " -ForegroundColor Blue
# Write-Host "                 :*.::::....-*%@@@#=.            +     " -ForegroundColor Blue
# Write-Host "                 *-.:....-+%@@@#=.              -=     " -ForegroundColor Blue
# Write-Host "                :*.:...+%@@@#=.  +%%%%%%%%-     +.     " -ForegroundColor Blue
# Write-Host "                +-.....+%#=:     -******++:    -=     " -ForegroundColor Blue
# Write-Host "                *:::...... ....               .*.     " -ForegroundColor Blue
# Write-Host "               --------------:::::::::::::::::-.     " -ForegroundColor Blue
# Write-Host ""
