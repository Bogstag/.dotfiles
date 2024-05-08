$fileName = Split-Path -Leaf $PSCommandPath
Write-Host ""
Write-Host " $fileName" -ForegroundColor DarkGreen
Remove-Variable fileName

$timer = $State.MyStartMeasurement("AppRunner Loading")
[AppRunner]::LoadApps()
# [AppRunner]::LoadAppsPipe()
$State.MyStopMeasurement($timer)

. $Env:dotfiles\PowerShell\Set-Paths.ps1
. $Env:dotfiles\PowerShell\Set-Envs.ps1
. $Env:dotfiles\PowerShell\Set-Alias.ps1
. $Env:dotfiles\PowerShell\Set-Secrets.ps1
. $Env:dotfiles\PowerShell\Request-ExtendedProfile.ps1


# Log measurements
if ($State.CurrentMeasurementGroup -eq "Profile") {
    $State.EndCollectingMeasurements("Profile")
}
Write-Host "     __________________________________________        " -ForegroundColor Green
Write-Host "     Loading personal profile took $($State.LastGroupMeasurement.Sum) ms." -ForegroundColor Green
$logEntry = @{
    Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Count     = $State.LastGroupMeasurement.Count
    Average   = $State.LastGroupMeasurement.Average
    Sum       = $State.LastGroupMeasurement.Sum
    Maximum   = $State.LastGroupMeasurement.Maximum
    Minimum   = $State.LastGroupMeasurement.Minimum
    Unit      = $State.LastGroupMeasurement.Property
}
$logFilePath = "$Env:dotfiles\ProfileLoadTime-$Env:COMPUTERNAME.csv"
try {
    # Check if the file exists and has content
    if (-Not (Test-Path $logFilePath)) {
        $logEntry | Export-Csv -Path $logFilePath -NoTypeInformation -UseQuotes AsNeeded -Encoding utf8
    } else {
        $logEntry | Export-Csv -Path $logFilePath -Append -NoTypeInformation -UseQuotes AsNeeded -Encoding utf8
    }
} catch {
    Write-Error "Failed to write log entry: $_"
}
Remove-Variable logEntry
Remove-Variable logFilePath


# $State.SaveSystemState()
# $SaveSystemStateJob = Start-ThreadJob -ScriptBlock {
#     $State = $using:State
#     $State.SaveAllState()
# }

# Write-Host ""
# Write-Host "                        ██████╗  ██████╗ ██╗    ██╗███████╗██████╗ ███████╗██╗  ██╗███████╗██╗     ██╗     " -ForegroundColor Blue
# Write-Host "                        ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║     " -ForegroundColor Blue
# Write-Host "                        ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝███████╗███████║█████╗  ██║     ██║     " -ForegroundColor Blue
# Write-Host "                        ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗╚════██║██╔══██║██╔══╝  ██║     ██║     " -ForegroundColor Blue
# Write-Host "                        ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║███████║██║  ██║███████╗███████╗███████╗" -ForegroundColor Blue
# Write-Host "                        ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝" -ForegroundColor Blue
# Write-Host ""
