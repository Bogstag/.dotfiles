# $InformationPreference = "Continue"
# $ErrorActionPreference = "Inquire"
# $DebugPreference = 'Break'

$fileName = Split-Path -Leaf $PSCommandPath
Write-Host "Running $fileName"
Remove-Variable fileName


$State = [State]::new()
if ($null -eq $State) {
    Write-Error "Failed to initialize State from My."
}

[AppRunner]::LoadApps()
# [AppRunner]::LoadAppsPipe()

. $Env:dotfiles\PowerShell\Set-Paths.ps1
. $Env:dotfiles\PowerShell\Set-Envs.ps1
. $Env:dotfiles\PowerShell\Set-Alias.ps1
. $Env:dotfiles\PowerShell\Set-Secrets.ps1
. $Env:dotfiles\PowerShell\Request-ExtendedProfile.ps1



# Write-Host "    ______________________________________        " -ForegroundColor Green
# Write-Host "    Loading personal profile took $($ProfileLoadTime.Milliseconds) ms." -ForegroundColor Green

# # Log measurements
# $logEntry = @{
#     Timestamp    = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
#     Milliseconds = $ProfileLoadTime.Milliseconds
#     Measurements = $ProfileLoadTime.Measurements
# }
# $logFilePath = "$Env:dotfiles\ProfileLoadTime-$Env:COMPUTERNAME.csv"
# try {
#     # Check if the file exists and has content
#     if (-Not (Test-Path $logFilePath)) {
#         $logEntry | Export-Csv -Path $logFilePath -NoTypeInformation -UseQuotes AsNeeded -Encoding utf8BOM
#     } else {
#         $logEntry | Export-Csv -Path $logFilePath -Append -NoTypeInformation -UseQuotes AsNeeded -Encoding utf8BOM
#     }
# } catch {
#     Write-Error "Failed to write log entry: $_"
# }
# Remove-Variable logEntry
# Remove-Variable ProfileLoadTime
# Remove-Variable logFilePath
# $State.SaveSystemState()
# $SaveSystemStateJob = Start-ThreadJob -ScriptBlock {
#     $State = $using:State
#     $State.SaveAllState()
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
