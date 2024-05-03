using module My

function AppClassFromScoopName($ScoopName) {
    $Class = $Apps.Values | Where-Object { $_.Name -eq $ScoopName }
    Write-Debug -Message "    Class: $($Class)"
    if ($Class) {
        return $Class.GetType()
    }

    return $null
    # return "ScoopUnmanaged"
}

# To use with sfsu
scoop update --quiet
$scoopStatus = scoop status --json | ConvertFrom-Json

foreach ($appStatus in $scoopStatus.packages) {
    Write-Host "Checking: $($appStatus.Name)" -NoNewline
    if (0 -ne $appStatus.missing_dependencies.Count) {
        Write-Warning -Message "$($appStatus.Name) needs to be handles manually it have dependencies."
        continue
    }

    if (0 -ne $appStatus.info.count) {
        Write-Warning -Message "$($appStatus.Name) needs you $($appStatus.info)"
        continue
    }

    # Translate Scoop name to Class
    $ClassName = AppClassFromScoopName($appStatus.Name)

    if ($null -eq $ClassName) {
        Write-Host " ❌"
        # $GenericState.AppData.ScoopUnmanaged.AppsList += $appStatus.Name
        continue
    }

    Write-Host " ✅"
    if ($Apps["$ClassName"].GetType().GetMethod('ShowLogo')) {
        $Apps["$ClassName"].ShowLogo()
    }

    if ($Apps["$ClassName"].GetType().GetMethod('ShowReleases')) {
        $Apps["$ClassName"].ShowReleases()
    }

    Write-Debug -Message "    Updating $($ClassName): $($appStatus.current) -> $($appStatus.available)"
    if ($Apps["$ClassName"].GetType().GetMethod('Update')) {
        $Apps["$ClassName"].Update($appStatus.available)
    }
}
$GenericState.SaveState('App')

# To use with Default Scoop
# $scoopStatus = scoop status --local

# foreach ($appStatus in $scoopStatus) {
#     Write-Host "Check: $($appStatus.Name)"
#     if ($appStatus."Installed Version" -ne $appStatus."Latest Version") {
#         if ($null -ne $Apps[$appStatus.Name]) {
#             $Apps["$($appStatus.Name)"].ShowLogo()
#             $Apps["$($appStatus.Name)"].ShowReleases()
#             $Apps["$($appStatus.Name)"].Update($appStatus."Latest Version")
#         }
#     }
# }
# $GenericState.SaveState()
