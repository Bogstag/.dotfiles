# $State = New-Object -TypeName State
# $State = New-Object State
# $State = [State]::new()
class State {
    [string] $SystemStateJsonFile = "$($Env:dotfiles)\MySystemState-$($Env:COMPUTERNAME).json"
    [Hashtable] $SystemData = @{}
    [Hashtable] $Measurements
    [TimeSpan] $Measurement

    State() {
        $this.SystemData["LastProfileRunDate"] = [datetime] (Get-Date -Date "1900-01-01").ToShortDateString()
        $this.SystemData["SystemStateJsonFile"] = $this.SystemStateJsonFile
        $this.LoadSystemState()
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

    [Hashtable] LoadJsonFile([IO.FileInfo] $JsonFile) {
        $Hashtable = (Get-Content -Raw $JsonFile) | ConvertFrom-Json -AsHashtable -DateKind Local

        return $Hashtable
    }

    [void] SaveAllState() {
        $this.SaveSystemState()
    }

    [void] SaveSystemState() {
        $json = $this.SystemData | ConvertTo-Json -Depth 20
        Set-Content -Path $this.SystemStateJsonFile -Value $json
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

    [Diagnostics.Stopwatch] StartMeasurement([string] $MeasureThis) {
        Write-Host " ⏱️ $($MeasureThis) => " -NoNewline -ForegroundColor Green
        return [Diagnostics.Stopwatch]::StartNew()
    }

    [void] StopMeasurement([Diagnostics.Stopwatch]$stopWatch) {
        $stopWatch.Stop()
        [TimeSpan] $ts = $stopWatch.Elapsed
        $this.Measurement.Add($ts)
        Write-Host $ts.Milliseconds"ms" -ForegroundColor Green
    }
}
