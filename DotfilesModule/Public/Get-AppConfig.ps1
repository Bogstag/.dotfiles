<#
.SYNOPSIS
Retrieves application configuration from a specified JSON file.

.DESCRIPTION
This function reads a JSON configuration file specified by the user or uses a default path from the module scope variable.
It attempts to parse the JSON content into a PowerShell object. If the file is not found, or an error occurs during reading or parsing,
the function captures the error, notifies the user, and returns null.

.PARAMETER SystemStateJsonFile
The path to the system state JSON file. If not specified, it defaults to the module scope's SystemStateJsonFile variable, which should be set at the module level.

.EXAMPLE
PS > $appConfig = Get-AppConfig -SystemStateJsonFile "C:\Configurations\state.json"
This example retrieves the application configuration from the specified system state JSON file.

.EXAMPLE
PS > $appConfig = Get-AppConfig
This example retrieves the application configuration using the default system state JSON file path defined in the module.

.NOTES
Ensure that the SystemStateJsonFile variable in the module scope is set to a valid default path if you plan to rely on it.
Errors in file path or content format will result in null being returned, accompanied by an error message.
#>
function Get-AppConfig {
    # TODO: Rename to Get-SystemState
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string] $SystemStateJsonFile = $Script:SystemStateJsonFile
    )

    begin {
        # This block runs once at the beginning of pipeline processing.
        # Initialize any variables or states needed for processing.
    }

    process {
        # This block runs once for each item that comes through the pipeline.
        try {
            $content = Get-Content -Path $SystemStateJsonFile -Raw
            return $content | ConvertFrom-Json
        } catch {
            Write-Error "Failed to read or parse the configuration file: $_"
            return $null
        }
    }

    end {
        # This block runs once after all items in the pipeline have been processed.
        # Perform any cleanup tasks or final adjustments here.
    }
}


Export-ModuleMember -Function Get-AppConfig
