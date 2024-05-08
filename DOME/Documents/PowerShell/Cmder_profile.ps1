$fileName = Split-Path -Leaf $PSCommandPath
Write-Host ""
Write-Host " $fileName" -ForegroundColor DarkGreen
Remove-Variable fileName
if ($State.CurrentMeasurementGroup -eq "Profile") {
    $State.EndCollectingMeasurements("Profile")
}
