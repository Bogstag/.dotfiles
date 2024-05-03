
class GenericState {
    [string] $SystemStateJsonFile = "$($Env:dotfiles)\MySystemState-$($Env:COMPUTERNAME).json"
    [string] $AppStateJsonFile = "$($Env:dotfiles)\AppState-$($Env:COMPUTERNAME).json"
    [Hashtable] $AppData = @{}
    [Hashtable] $SystemData = @{}


    GenericState() {
        $this.SystemData["LastProfileRunDate"] = [datetime] (Get-Date -Date "1900-01-01").ToShortDateString()
        $this.SystemData["SystemStateJsonFile"] = $this.SystemStateJsonFile
        $this.LoadSystemState()
        $this.LoadAppState()
    }

    [void] LoadSystemState() {
        $JsonFile = [IO.FileInfo]::new("$($this.SystemStateJsonFile)")
        if ($JsonFile.Exists) {
            try {
                $this.SystemData = $this.LoadJsonFile($JsonFile)
            } catch {
                Write-Error "Failed to parse the system state JSON file. ($($JsonFile))"
                Write-Error "$_"
            }
        } else {
            Write-Warning "System state JSON file does not exist. Creating file and initializing with default values."
            $JsonFile.Create()
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
            }
        } else {
            Write-Warning "App state JSON file does not exist. Creating file and initializing with default values."
            $JsonFile.Create()
        }
    }

    [Hashtable] LoadJsonFile([IO.FileInfo] $JsonFile) {
        $Hashtable = (Get-Content -Raw $JsonFile) | ConvertFrom-Json -AsHashtable -DateKind Local

        return $Hashtable
    }

    [void] SaveAllState() {
        $this.SaveState('System')
        $this.SaveState('App')
    }

    [void] SaveState([string] $State) {
        if ('System' -eq $State) {
            $data = $this.SystemData
            $file = $this.SystemStateJsonFile
        } elseif ('App' -eq $State) {
            $data = $this.AppData
            $file = $this.AppStateJsonFile
        } else {
            Write-Error -Message "State must be App or System"
            break
        }

        $json = $data | ConvertTo-Json -Depth 20
        Set-Content -Path $file -Value $json
    }

    [void] UpdateAppData([string] $appType, [object] $appInstance) {
        if ($appInstance) {
            if ($appType) { $appType = $appInstance.GetType() }
            $data = @{}
            $appInstance.GetType().GetProperties() | ForEach-Object {
                # Check if the property name is 'Logo', skip it if true
                if ($_.Name -ne 'Logo') {
                    $data[$_.Name] = $_.GetValue($appInstance)
                }
            }

            $this.AppData[$appType] = $data
        }
    }

    [bool] HasRunToday() {
        if (($this.SystemData["LastProfileRunDate"]) -eq ([DateTime]::Now.Date.ToShortDateString())) {
            return $true
        } else {
            return $false
        }
    }

    [void] UpdateLastRunDate() {
        $this.SystemData["LastProfileRunDate"] = [DateTime]::Now.Date.ToShortDateString()
    }
    [void] UpdateLastRunDate([datetime]$datetime) {
        $this.SystemData["LastProfileRunDate"] = [DateTime]::Parse($datetime).Date.ToShortDateString()
    }
}
