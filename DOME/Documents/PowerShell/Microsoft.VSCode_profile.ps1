$fileName = Split-Path -Leaf $PSCommandPath
Write-Host ""
Write-Host " $fileName" -ForegroundColor DarkGreen

Write-Host ""
Write-Host "                   .--:." -ForegroundColor Cyan
Write-Host "                 .=+++++=-:." -ForegroundColor Cyan
Write-Host "               :=+++++++++++-" -ForegroundColor Cyan
Write-Host "  ..         :=+++++++++++++=" -ForegroundColor Cyan
Write-Host ":=++=:     :++++++++--++++++=" -ForegroundColor Cyan
Write-Host ":=+++++-.-+++++++=:  .++++++=" -ForegroundColor Cyan
Write-Host "  :=++++++++++=-.    :++++++=" -ForegroundColor Cyan
Write-Host "    -++++++++=       :++++++=" -ForegroundColor Cyan
Write-Host "  :=+++++++++++-.    :++++++=" -ForegroundColor Cyan
Write-Host ":++++++-.-+++++++=:  .++++++=" -ForegroundColor Cyan
Write-Host ".-++=:     :=+++++++--++++++=" -ForegroundColor Cyan
Write-Host "             :=+++++++++++++=" -ForegroundColor Cyan
Write-Host "               .=+++++++++++-" -ForegroundColor Cyan
Write-Host "                 .-+++++=-:." -ForegroundColor Cyan
Write-Host "                   .--:." -ForegroundColor Cyan
Write-Host ""
if ($State.CurrentMeasurementGroup -eq "Profile") {
    $State.EndCollectingMeasurements("Profile")
}
