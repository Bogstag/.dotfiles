<#
.SYNOPSIS
Creates a new app instance from configuration.

.DESCRIPTION
This function reads an application configuration from a JSON file and uses it to create a new app instance by invoking the New-App function with parameters extracted from the configuration file.

.PARAMETER AppName
The name of the application for which to create an instance. This name must match the key in the configuration JSON file and can be piped into the function.

.PARAMETER SystemStateJsonFile
Optional. The path to the system state JSON file. If not specified, it defaults to the module scope SystemStateJsonFile.

.EXAMPLE
PS > $appInstance = New-AppFromConfig -AppName "Biome"
This command creates an instance of the "Biome" application using the configuration specified in the system state JSON file.

.EXAMPLE
PS > "Biome", "App2", "App3" | New-AppFromConfig
This example demonstrates how to pipe multiple application names to create instances for each using the same configuration file.
#>
function New-AppFromConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $AppName,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string] $SystemStateJsonFile = $Script:SystemStateJsonFile
    )

    process {
        $config = Get-AppConfig -SystemStateJsonFile $SystemStateJsonFile

        return New-App(
            $config.AppData.$AppName.Name,
            $null,
            $config.AppData.$AppName.Store,
            $config.AppData.$AppName.VerifyFile,
            $config.AppData.$AppName.Repo,
            $config.AppData.$AppName.Docs,
            $config.AppData.$AppName.ConfigFolder,
            $config.AppData.$AppName.ConfigFile
        )
    }
}

Export-ModuleMember -Function New-AppFromConfig
