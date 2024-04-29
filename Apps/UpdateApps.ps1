using module DotfilesModule

# To use with sfsu
scoop update --quiet
$scoopStatus = (scoop status --json) | ConvertFrom-Json

foreach ($appStatus in $scoopStatus.packages) {
    Write-Host "Check: $($appStatus.Name)"

    if ($null -eq $MyApps[$appStatus.Name]) {
        continue
    }

    if (0 -ne $appStatus.missing_dependencies.Count) {
        Write-Warning -Message "$($appStatus.Name) needs to be handles manually it have dependencies."
        continue
    }

    if (0 -ne $appStatus.info.count) {
        Write-Warning -Message "$($appStatus.Name) needs you $($appStatus.info)"
        continue
    }

    if ($appStatus.current -ne $appStatus.available) {

        if ($MyApps[$appFolder.Name].GetType().GetMethod('ShowLogo')) {
            $MyApps[$appStatus.Name].ShowLogo()
        }

        if ($MyApps[$appFolder.Name].GetType().GetMethod('ShowReleases')) {
            $MyApps[$appStatus.Name].ShowReleases() # TODO: Add more smartness then just loading releases
        }

        if ($MyApps[$appFolder.Name].GetType().GetMethod('Update')) {
            $MyApps[$appStatus.Name].Update($appStatus.available)
        }

    }
}
$SystemState.SaveState('App')

# To use with Default Scoop
# $scoopStatus = scoop status --local

# foreach ($appStatus in $scoopStatus) {
#     Write-Host "Check: $($appStatus.Name)"
#     if ($appStatus."Installed Version" -ne $appStatus."Latest Version") {
#         if ($null -ne $MyApps[$appStatus.Name]) {
#             $MyApps["$($appStatus.Name)"].ShowLogo()
#             $MyApps["$($appStatus.Name)"].ShowReleases() # TODO: Add more smartness then just loading releases
#             $MyApps["$($appStatus.Name)"].Update($appStatus."Latest Version")
#         }
#     }
# }
# $SystemState.SaveState()
