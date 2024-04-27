function Exit-IfAlreadyRunToday {
    if ($systemState.HasRunToday()) {
        # Exit if the last profile run date is today
        exit
    } else {
        # Update the JSON file with today's date if not exiting
        $systemState.UpdateLastRunDate()
    }
}
Exit-IfAlreadyRunToday

$fileName = Split-Path -Leaf $PSCommandPath
Write-Host "Running $fileName"

$AppCentralScript = "$Env:dotfiles\Apps\AppCentral.ps1"
if (Test-Path $AppCentralScript) {
    . $AppCentralScript -Command "set-apps-environmentvariables"
} else {
    Write-Error "Unable to find AppCentralScript script at $AppCentralScript"
}

# Host specific setup
if (Test-Path $Env:dotfiles\Host\$Env:COMPUTERNAME.ps1 -PathType Leaf) {
    Write-Host " ⏱️ $Env:COMPUTERNAME => " -NoNewline -ForegroundColor Green
    $t = Measure-Command {

        . "$Env:dotfiles\Host\$Env:COMPUTERNAME.ps1"

    }
    $ProfileLoadTime.Milliseconds += $t.Milliseconds
    $ProfileLoadTime.Measurements += 1
    Write-Host $t.Milliseconds"ms" -ForegroundColor Green
} else {
    Write-Host "💻 Missing $Env:dotfiles\Host\$Env:COMPUTERNAME.ps1" -ForegroundColor Red
    New-Item -Path "$Env:dotfiles\Host\" -Name "$Env:COMPUTERNAME.ps1" -ItemType "file" -Value 'Write-Host "💻 Empty $Env:dotfiles\Host\$Env:COMPUTERNAME.ps1" -ForegroundColor Red'
}

# App specific setup
# if ($true -eq $Env:InstallAppsOnHost) {
#     $MyApps = Get-ChildItem -Path "$Env:dotfiles/Apps/*" -Include *.ps1 -Recurse

#     foreach ($MyApp in $MyApps) {
#         $BaseName = $MyApp.BaseName
#         Write-Host " ⏱️ $BaseName => " -NoNewline -ForegroundColor Green

#         $t = Measure-Command {
#             . $MyApp
#         }

#         $ProfileLoadTime.Milliseconds += $t.Milliseconds
#         $ProfileLoadTime.Measurements += 1
#         Write-Host $t.Milliseconds"ms" -ForegroundColor Green
#     }

# }
