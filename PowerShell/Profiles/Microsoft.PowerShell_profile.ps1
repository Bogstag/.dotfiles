$fileName = Split-Path -Leaf $PSCommandPath
Write-Host "Running $fileName"

$jsonSystemState = "$env:dotfiles\SystemState.json"
# Ensure the JSON file exists
if (-Not (Test-Path $jsonSystemState)) {
    # If the file does not exist, create it with a default date of '1900-01-01' (or any past date)
    @{ LastLoginDate = '1900-01-01' } | ConvertTo-Json | Set-Content -Path $jsonSystemState
}

if ($null -eq $totalTimeMs) {
    # Init a variable that holds total execution time in ms.
    $totalTimeMs = 0
}
. $env:dotfiles\PowerShell\Set-Secrets.ps1

. $env:dotfiles\PowerShell\Extended-Profile.ps1

Write-Host "    ______________________________________        " -ForegroundColor Green
Write-Host "    Loading personal profile took $totalTimeMs ms." -ForegroundColor Green

@{ LastLoginDate = [DateTime]::Now.ToString("yyyy-MM-dd") } | ConvertTo-Json | Set-Content -Path $jsonSystemState

# $suaJob = Start-ThreadJob -ScriptBlock { Scoop Update * }
# Write-Host "sua job is running: Receive-Job -Job $suaJob"


# . $env:dotfiles\PowerShell\prompt.ps1

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
