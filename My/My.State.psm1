# using namespace Microsoft.PowerShell.Commands
# $State = New-Object -TypeName State
# $State = New-Object State
# $State = [State]::new()
# TODO: Use this? https://learn.microsoft.com/en-us/dotnet/api/microsoft.powershell.commands.measureobjectcommand?view=powershellsdk-7.5.0

class State {
    [string] $SystemStateJsonFile = "$($Env:dotfiles)\MySystemState-$($Env:COMPUTERNAME).json"
    [Hashtable] $SystemData = @{}
    [psobject] $Measurements = (New-Object -TypeName PSObject)
    [psobject] $Measurement = (New-Object -TypeName PSObject)
    [string] $CurrentMeasurementGroup = ""
    [object] $LastGroupMeasurement

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

    [void] StartCollectingMeasurements([string]$GroupName) {
        $this.CurrentMeasurementGroup = $GroupName
        Add-Member -InputObject $this.Measurements -MemberType NoteProperty -Name $this.CurrentMeasurementGroup -Value @{}
    }

    [void] EndCollectingMeasurements([string]$GroupName = $this.CurrentMeasurementGroup) {
        $this.CurrentMeasurementGroup = ""
        $this.LastGroupMeasurement = $this.Measurements.$($GroupName).values | Measure-Object -Property totalmilliseconds -Maximum -Minimum -Average -Sum
    }

    [Object[]] MyStartMeasurement([string] $MeasureThis) {
        Write-Host "  ⏱️ $($MeasureThis.PadRight(20)) => " -NoNewline -ForegroundColor Green

        return @{$MeasureThis = [Diagnostics.Stopwatch]::StartNew() }
    }

    [void] MyStopMeasurement([object[]]$Stopwatch) {
        $Stopwatch.Values.Stop()
        [TimeSpan] $this.Measurement = $Stopwatch.Values.Elapsed
        if ($this.CurrentMeasurementGroup -ge 1) {
            $this.Measurements.$($this.CurrentMeasurementGroup).Add($Stopwatch.Keys, $this.Measurement)
        }
        Write-Host "$($Stopwatch.Values.Elapsed.Milliseconds.ToString().PadLeft(4))ms" -ForegroundColor Green
    }
}
