class MySystemState {
    [string] $SystemStateJsonFile = "$($Env:dotfiles)\MySystemState-$($Env:COMPUTERNAME).json"
    [string] $AppStateJsonFile = "$($Env:dotfiles)\AppState-$($Env:COMPUTERNAME).json"
    [Hashtable] $AppData = @{}
    [Hashtable] $SystemData = @{}

    MySystemState() {
        $this.LoadSystemState()
        $this.LoadAppState()
    }

    [void] LoadSystemState() {
        $JsonFile = [IO.FileInfo]::new("$($this.SystemStateJsonFile)")
        if ($JsonFile.Exists) {
            try {
                $this.SystemData = $this.LoadJsonFile($JsonFile)
                # $this.SystemData["SystemStateJsonFile"] = $this.SystemStateJsonFile
            } catch {
                Write-Error "Failed to parse the system state JSON file. ($($JsonFile))"
                Write-Error "$_"
                $this.InitializeSystemStateDefaults()
            }
        } else {
            Write-Warning "System state JSON file does not exist. Creating file and initializing with default values."
            $JsonFile.Create()
            $this.InitializeSystemStateDefaults()
        }
    }

    [void] LoadAppState() {
        $JsonFile = [IO.FileInfo]::new("$($this.AppStateJsonFile)")
        if ($JsonFile.Exists) {
            try {
                $this.AppData = $this.LoadJsonFile($JsonFile)
            } catch {
                Write-Error "Failed to parse the system state JSON file. ($($JsonFile))"
                Write-Error "$_"
                $this.InitializeAppDataDefaults()
            }
        } else {
            Write-Warning "App state JSON file does not exist. Creating file and initializing with default values."
            $JsonFile.Create()
            $this.InitializeAppDataDefaults()
        }
    }

    [Hashtable] LoadJsonFile([IO.FileInfo] $JsonFile) {
        $Hashtable = (Get-Content -Raw $JsonFile) | ConvertFrom-Json -AsHashtable -DateKind Local

        return $Hashtable
    }

    [void] InitializeSystemStateDefaults() {
        $this.SystemData["LastProfileRunDate"] = (Get-Date -Date '1900-01-01').ToShortDateString()
        $this.SystemData["SystemStateJsonFile"] = $this.SystemStateJsonFile
    }

    [void] InitializeAppDataDefaults() {
        # $this.AppData["LastProfileRunDate"] = $this.LastProfileRunDate
        # $this.AppData["AppStateJsonFile"] = $this.AppStateJsonFile
    }

    [void] SaveAllState() {
        $this.SaveState('System')
        $this.SaveState('App')
    }

    [void] SaveState([string] $State) {
        if ('System' -eq $State) {
            $json = $this.SystemData | ConvertTo-Json -Depth 10
            Set-Content -Path "$($this.SystemStateJsonFile)" -Value $json
        } elseif ('App' -eq $State) {
            $json = $this.AppData | ConvertTo-Json -Depth 10
            Set-Content -Path "$($this.AppStateJsonFile)" -Value $json
        } else {
            Write-Error -Message "State must be App or System"
        }
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

            $this.AppData[$appName] = $data
        }
    }

    [bool] HasRunToday() {
        if ($this.SystemData["LastProfileRunDate"] -and ([DateTime]::Parse($this.SystemData["LastProfileRunDate"]).Date -eq [DateTime]::Now.Date)) {
            return $true
        } else {
            return $false
        }
    }

    [void] UpdateLastRunDate() {
        $this.SystemData["LastProfileRunDate"] = (Get-Date).ToShortDateString()
    }
}
