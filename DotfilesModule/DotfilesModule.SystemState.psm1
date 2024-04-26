class SystemState {
    [string] $SystemStateJsonFile
    [Hashtable] $AppData = @{}
    [string] $LastProfileRunDate = '1900-01-01'

    SystemState([string] $SystemStateJsonFile) {
        $this.SystemStateJsonFile = $SystemStateJsonFile

        if (Test-Path $this.SystemStateJsonFile) {
            try {
                $jsonData = Get-Content -Path $this.SystemStateJsonFile | ConvertFrom-Json
                $this.AppData = New-Object System.Collections.Hashtable
                foreach ($key in $jsonData.AppData.PSObject.Properties.Name) {
                    $this.AppData[$key] = $jsonData.AppData.$key
                }
                $this.LastProfileRunDate = $jsonData.LastProfileRunDate
            } catch {
                Write-Warning "Failed to parse the system state JSON file. ($($this.SystemStateJsonFile))"
                Write-Warning "Error: $_"
                $this.InitializeDefaults()
            }
        } else {
            Write-Warning "System state JSON file does not exist. Initializing with default values."
            $this.InitializeDefaults()
        }
    }

    [void] InitializeDefaults() {
        $this.AppData = @{}
        $this.LastProfileRunDate = '1900-01-01'
    }

    [void] SaveState() {
        $json = $this | ConvertTo-Json -Depth 5
        Set-Content -Path $this.SystemStateJsonFile -Value $json
    }

    [void] UpdateAppData([string] $appName, [object] $appInstance) {
        $data = @{}
        if ($null -eq $appInstance) {
            $this.AppData[$appName] = $data
        } else {
            # Iterate over all properties of the app instance except 'Logo'
            $appInstance.GetType().GetProperties() | ForEach-Object {
                # Check if the property name is 'Logo', skip it if true
                if ($_.Name -ne 'Logo') {
                    $data[$_.Name] = $_.GetValue($appInstance)
                }
            }

            if ($null -eq $this.AppData) {
                $this.AppData[$appName] = @{}
            }

            $this.AppData[$appName] = $data
        }
    }


    [bool] HasRunToday() {
        if ($this.LastProfileRunDate -and ([DateTime]::Parse($this.LastProfileRunDate).Date -eq [DateTime]::Now.Date)) {
            return $true
        } else {
            return $false
        }
    }

    [void] UpdateLastRunDate() {
        $this.LastProfileRunDate = [DateTime]::Now.ToString("yyyy-MM-dd")
    }
}
