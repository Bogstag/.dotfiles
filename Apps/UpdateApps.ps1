# TODO: Add Logic to run scoop status and get the result
# Example command might be: $scoopStatus = ConvertFrom-Json (scoop status --json)
# $scoopStatus = @(
#     @{Name = "Terminal-Icons"; InstalledVersion = "1.62.0"; LatestVersion = "1.64.2" }
#     # Add other apps as needed
# )

foreach ($appStatus in $scoopStatus) {
    # Check if an update is needed and perform the update
    if ($appStatus.InstalledVersion -ne $appStatus.LatestVersion) {
        try {
            $appScriptPath = "$Env:dotfiles/Apps/$($appStatus.Name)/$($appStatus.Name).ps1"

            # Ensure the script file exists before attempting to load it
            if (Test-Path $appScriptPath) {
                # Load the app class definition
                . $appScriptPath
            } else {
                Write-Warning "Script file for $($appStatus.Name) not found at $appScriptPath"
                continue
            }

            # Create an instance of the app class
            $appInstance = [App]::new()

            $appInstance.Update()
        } catch {
            Write-Error "Failed to update $($appStatus.Name) due to an error: $_"
        }
    }
}
