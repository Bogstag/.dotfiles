#     if ($Apps[$appFolder.Name].GetType().GetMethod('Enable')) {
#         Write-Host " ⏱️ Enable $($Apps[$appFolder.Name].Name) => " -NoNewline -ForegroundColor Green
#         $t = Measure-Command {
#             $Apps[$appFolder.Name].Enable()
#         }
#         $ProfileLoadTime.Milliseconds += $t.Milliseconds
#         $ProfileLoadTime.Measurements += 1
#         Write-Host $t.Milliseconds"ms" -ForegroundColor Green
#     }
# }
function Measure-CommandEx {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [scriptblock]$Expression,

        [Parameter(ValueFromPipeline)]
        [psobject[]]$InputObject
    )

    Begin {
        $stopWatch = New-Object -TypeName 'System.Diagnostics.Stopwatch'
        <#
            Source: https://devblogs.microsoft.com/powershell-community/measuring-script-execution-time/
            We need to define result as a list because the way objects
            are passed to the pipeline. If you pass a collection of objects,
            the pipeline sends them one by one, and the result
            is always overridden by the last item.
        #>
        [System.Collections.Generic.List[PSObject]]$result = @()
    }

    Process {
        if ($InputObject) {

            # Starting the stopwatch.
            $stopWatch.Start()

            # Creating the '$_' variable.
            $dollarUn = New-Object -TypeName PSVariable -ArgumentList @('_', $InputObject)

            <#
                Overload is:
                    InvokeWithContext(
                        Dictionary<string, scriptblock> functionsToDefine,
                        List<PSVariable> variablesToDefine,
                        object[] args
                    )
            #>
            $result.AddRange($Expression.InvokeWithContext($null, $dollarUn, $null))

            $stopWatch.Stop()
        } else {
            $stopWatch.Start()
            $result.AddRange($Expression.InvokeReturnAsIs())
            $stopWatch.Stop()
        }
    }

    End {
        return [PSCustomObject]@{
            ElapsedTimespan = $stopWatch.Elapsed
            Result          = $result
        }
    }
}

function New-Timer {
    # Source: https://github.com/PsCustomObject/PowerShell-Functions/blob/master/New-Timer.ps1
    <#
		.SYNOPSIS
			Creates a new stopwatch.

		.DESCRIPTION
			Function will create a new time, using the StopWatch class, allowing measurement of elapsed time in scripts.

		.EXAMPLE
			PS C:\> New-Timer

		.NOTES
			Function takes no parameters and will start a new StopWatch object.
	#>

    [OutputType([System.Diagnostics.Stopwatch])]
    param ()

    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

    return $stopwatch
}

function Get-TimerStatus {
    # Source: https://github.com/PsCustomObject/PowerShell-Functions/blob/master/New-Timer.ps1
    <#
		.SYNOPSIS
			Will return boolean value representing status of an existing stopwatch.

		.DESCRIPTION
			Function requires a [System.Diagnostics.Stopwatch] object as input and will return $True if stopwatch is running or $False otherwise.

		.PARAMETER Timer
			A [System.Diagnostics.Stopwatch] object representing the StopWatch to check status for.

		.EXAMPLE
			PS C:\> Get-TimerStatus -Timer $Timer

		.OUTPUTS
			System.Boolean
	#>

    [OutputType([bool])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Diagnostics.Stopwatch]
        $Timer
    )

    return $Timer.IsRunning
}

function Get-ElapsedTime {
    # Source: https://github.com/PsCustomObject/PowerShell-Functions/blob/master/New-Timer.ps1
    <#
		.SYNOPSIS
			Will return information about elapsed time for the given StopWatch.

		.DESCRIPTION
			Function requires a [System.Diagnostics.Stopwatch] object as input and will output information about elapsed time.

			By default a [TimeSpan] object is returned containing all information about elapsed time.

			If any other parameter like -Days is used function will return an Int or Double instead depending on the switch used.

		.PARAMETER ElapsedTime
			Will return a [TimeSpan] object representing the elapsed time for the given stopwatch.

		.PARAMETER Days
			Will return an [Int] object representing the number of days since the stopwatch was started.

		.PARAMETER Hours
			Will return an [Int] object representing the number of hours since the stopwatch was started.

		.PARAMETER Minutes
			Will return an [Int] object representing the number of minutes since the stopwatch was started.

		.PARAMETER Seconds
			Will return an [Int] object representing the number of seconds since the stopwatch was started.

		.PARAMETER TotalDays
			Will return a [Double] object representing the number of TotalDays since the stopwatch was started.

		.PARAMETER TotalHours
			Will return a [Double] object representing the number of TotalHours since the stopwatch was started.

		.PARAMETER TotalMinutes
			Will return a [Double] object representing the number of TotalMinutes since the stopwatch was started.

		.PARAMETER TotalSeconds
			Will return a [Double] object representing the number of TotalSeconds since the stopwatch was started.

		.PARAMETER TotalMilliseconds
			Will return a [Double] object representing the number of TotalMilliseconds since the stopwatch was started.

		.EXAMPLE
			PS C:\> Get-ElapsedTime -ElapsedTime $ElapsedTime -Days

		.OUTPUTS
			System.TimeSpan, System.Double, System.Int32
	#>

    [CmdletBinding(DefaultParameterSetName = 'FullOutput',
        ConfirmImpact = 'High',
        SupportsPaging = $false,
        SupportsShouldProcess = $false)]
    [OutputType([timespan], ParameterSetName = 'FullOutput')]
    [OutputType([int], ParameterSetName = 'Days')]
    [OutputType([int], ParameterSetName = 'Hours')]
    [OutputType([int], ParameterSetName = 'Minutes')]
    [OutputType([int], ParameterSetName = 'Seconds')]
    [OutputType([double], ParameterSetName = 'TotalDays')]
    [OutputType([double], ParameterSetName = 'TotalHours')]
    [OutputType([double], ParameterSetName = 'TotalMinutes')]
    [OutputType([double], ParameterSetName = 'TotalSeconds')]
    [OutputType([double], ParameterSetName = 'TotalMilliseconds')]
    [OutputType([timespan])]
    param
    (
        [Parameter(ParameterSetName = 'FullOutput',
            Mandatory = $true)]
        [Parameter(ParameterSetName = 'Days')]
        [Parameter(ParameterSetName = 'Hours')]
        [Parameter(ParameterSetName = 'Minutes')]
        [Parameter(ParameterSetName = 'Seconds')]
        [Parameter(ParameterSetName = 'TotalDays')]
        [Parameter(ParameterSetName = 'TotalHours')]
        [Parameter(ParameterSetName = 'TotalMilliseconds')]
        [Parameter(ParameterSetName = 'TotalMinutes')]
        [Parameter(ParameterSetName = 'TotalSeconds')]
        [System.Diagnostics.Stopwatch]
        $ElapsedTime,
        [Parameter(ParameterSetName = 'Days')]
        [switch]
        $Days,
        [Parameter(ParameterSetName = 'Hours')]
        [switch]
        $Hours,
        [Parameter(ParameterSetName = 'Minutes')]
        [switch]
        $Minutes,
        [Parameter(ParameterSetName = 'Seconds')]
        [switch]
        $Seconds,
        [Parameter(ParameterSetName = 'TotalDays')]
        [switch]
        $TotalDays,
        [Parameter(ParameterSetName = 'TotalHours')]
        [switch]
        $TotalHours,
        [Parameter(ParameterSetName = 'TotalMinutes')]
        [switch]
        $TotalMinutes,
        [Parameter(ParameterSetName = 'TotalSeconds')]
        [switch]
        $TotalSeconds,
        [Parameter(ParameterSetName = 'TotalMilliseconds')]
        [switch]
        $TotalMilliseconds
    )

    switch ($PsCmdlet.ParameterSetName) {
        'FullOutput' {
            # Return full timespan object
            return $ElapsedTime.Elapsed

            break
        }
        'Days' {
            # Return days with no decimals
            return $ElapsedTime.Elapsed.Days

            break
        }
        'Hours' {
            # Return hours with no decimals
            return $ElapsedTime.Elapsed.Hours

            break
        }
        'Minutes' {
            # Return minutes with no decimals
            return $ElapsedTime.Elapsed.Minutes

            break
        }
        'Seconds' {
            # Return seconds with no decimals
            return $ElapsedTime.Elapsed.Seconds

            break
        }
        'TotalDays' {
            # Return days with double precision
            return $ElapsedTime.Elapsed.TotalDays

            break
        }
        'TotalHours' {
            # Return hours with double precision
            return $ElapsedTime.Elapsed.TotalHours

            break
        }
        'TotalMinutes' {
            # Return minutes with double precision
            return $ElapsedTime.Elapsed.TotalMinutes

            break
        }
        'TotalSeconds' {
            # Return seconds with double precision
            return $ElapsedTime.Elapsed.TotalSeconds

            break
        }
        'TotalMilliseconds' {
            # Return milliseconds with double precision
            return $ElapsedTime.Elapsed.TotalMilliseconds

            break
        }
    }
}

function Stop-Timer {
    # Source: https://github.com/PsCustomObject/PowerShell-Functions/blob/master/New-Timer.ps1
    <#
		.SYNOPSIS
			Function will halt a stopwatch.

		.DESCRIPTION
			Function requires a [System.Diagnostics.Stopwatch] object as input and will invoke the stop() method to hold its execution.

			If no exceptions are returned function will return $True.

		.PARAMETER Timer
			A [System.Diagnostics.Stopwatch] representing the stopwatch to stop.

		.EXAMPLE
			PS C:\> Stop-Timer -Timer $Timer

		.OUTPUTS
			System.Boolean
	#>

    [OutputType([bool])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Diagnostics.Stopwatch]$Timer
    )

    Begin {
        # Save current configuration
        [string]$currentConfig = $ErrorActionPreference

        # Update configuration
        $ErrorActionPreference = 'Stop'
    }

    Process {
        try {
            # Stop timer
            $Timer.Stop()

            return $true
        } catch {
            # Save exception
            [string]$reportedException = $Error[0].Exception.Message

            Write-Warning -Message 'Exception reported while halting stopwatch - Use the -Verbose parameter for more details'

            # Check we have an exception message
            if ([string]::IsNullOrEmpty($reportedException) -eq $false) {
                Write-Verbose -Message $reportedException
            } else {
                Write-Verbose -Message 'No inner exception reported by Disconnect-AzureAD cmdlet'
            }

            return $false
        }
    }

    End {
        # Revert back configuration
        $ErrorActionPreference = $currentConfig
    }
}
Export-ModuleMember -Function @(
    Measure-CommandEx,
    New-Timer,
    Get-TimerStatus,
    Get-ElapsedTime,
    Stop-Timer
)
