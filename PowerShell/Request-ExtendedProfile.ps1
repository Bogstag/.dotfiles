using module My

function Exit-IfAlreadyRunToday {
    if ($State.HasRunToday()) {
        # Exit if the last profile run date is today
        exit
    } else {
        # Update the JSON file with today's date if not exiting
        $State.UpdateLastRunDate()
    }
}
Exit-IfAlreadyRunToday

$fileName = Split-Path -Leaf $PSCommandPath
Write-Host ""
Write-Host " $fileName" -ForegroundColor DarkGreen
Remove-Variable fileName

# $AppCentralScript = "$Env:dotfiles\Apps\AppCentral.ps1"
# if (Test-Path $AppCentralScript) {
#     . $AppCentralScript -Command "set-apps-environmentvariables"
# } else {
#     Write-Error "Unable to find AppCentralScript script at $AppCentralScript"
# }

# Host specific setup
if (Test-Path $Env:dotfiles\Host\$Env:COMPUTERNAME.ps1 -PathType Leaf) {
    $timer = $State.MyStartMeasurement("$Env:COMPUTERNAME")
    . "$Env:dotfiles\Host\$Env:COMPUTERNAME.ps1"
    $State.MyStopMeasurement($timer)
} else {
    Write-Host "💻 Missing $Env:dotfiles\Host\$Env:COMPUTERNAME.ps1" -ForegroundColor Red
    New-Item -Path "$Env:dotfiles\Host\" -Name "$Env:COMPUTERNAME.ps1" -ItemType "file" -Value 'Write-Host "💻 Empty $Env:dotfiles\Host\$Env:COMPUTERNAME.ps1" -ForegroundColor Red'
}

# App specific setup
# if ($true -eq $Env:InstallAppsOnHost) {
#     $Apps = Get-ChildItem -Path "$Env:dotfiles/Apps/*" -Include *.ps1 -Recurse
#     foreach ($MyApp in $Apps) {
# $timer = $State.MyStartMeasurement("$MyApp.BaseName")
#             . $MyApp
#         $State.MyStopMeasurement($timer)
#     }
# }
