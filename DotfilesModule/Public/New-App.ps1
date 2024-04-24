<#
.SYNOPSIS
Creates a new application object based on specified configuration parameters.

.DESCRIPTION
The New-App function constructs a new instance of the App class by accepting configuration details such as name, store,
file verification path, repository URL, documentation URL, configuration folder, and configuration file path.
This function is used to initialize new applications with specific attributes defined at runtime.

.PARAMETER Name
The name of the application.

.PARAMETER Store
The name of the store or location where the application is available.

.PARAMETER VerifyFile
The file path used to verify the installation of the application.

.PARAMETER Repo
The URL of the application's source code repository.

.PARAMETER Docs
The URL of the application's documentation.

.PARAMETER ConfigFolder
The directory path where the application's configuration files are stored.

.PARAMETER ConfigFile
The path of the specific configuration file for the application.

.EXAMPLE
PS > $app = New-App -Name "ExampleApp" -Store "Main" -VerifyFile "C:\Apps\ExampleApp\app.exe" -Repo "https://github.com/example/app" -Docs "https://example.com/docs" -ConfigFolder "C:\Apps\ExampleApp\Config" -ConfigFile "config.json"
This example creates a new application object for 'ExampleApp' with specified paths and URLs for its configuration and documentation.

.OUTPUTS
App
Returns an object of type App.

#>
function New-App {
    [cmdletbinding()]
    [OutputType([App])]
    param(
        [Parameter(Mandatory = $true)]
        [string] $Name,

        [Parameter(Mandatory = $true)]
        [string] $Logo,

        [Parameter(Mandatory = $true)]
        [string] $Store,

        [Parameter(Mandatory = $true)]
        [string] $VerifyFile,

        [Parameter(Mandatory = $true)]
        [string] $Repo,

        [Parameter(Mandatory = $true)]
        [string] $Docs,

        [Parameter(Mandatory = $true)]
        [string] $ConfigFolder,

        [Parameter(Mandatory = $true)]
        [string] $ConfigFile
    )

    return [App]::new(
        $Name,
        $Logo,
        $Store,
        $VerifyFile,
        $Repo,
        $Docs,
        $ConfigFolder,
        $ConfigFile
    )
}

Export-ModuleMember -Function New-App
