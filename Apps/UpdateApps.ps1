using module DotfilesModule

$scoopStatus = scoop status --local

foreach ($appStatus in $scoopStatus) {
    Write-Host "Check: $($appStatus.Name)"
    if ($appStatus."Installed Version" -ne $appStatus."Latest Version") {
        if ($null -ne $instances[$appStatus.Name]) {
            $instances["$($appStatus.Name)"].ShowLogo()
            $instances["$($appStatus.Name)"].ShowReleases() # TODO: Add more smartness then just loading releases
            $instances["$($appStatus.Name)"].Update($appStatus."Latest Version")
        }
    }
}
$SystemState.SaveState()
