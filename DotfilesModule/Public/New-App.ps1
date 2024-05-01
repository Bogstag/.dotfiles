<#
.SYNOPSIS
Creates a new application object based on specified configuration parameters.

.DESCRIPTION
The New-App function constructs a new instance of the App class by accepting configuration details such as name, store,
file verification path, repository URL, documentation URL, configuration folder, and configuration file path.
This function is used to initialize new applications with specific attributes defined at runtime.

.PARAMETER Props
Hashtable with properties

.PARAMETER Type
App type


.EXAMPLE
PS > $app = New-App -Name "ExampleApp" -Store "Main" -VerifyFile "C:\Apps\ExampleApp\app.exe" -Repo "https://github.com/example/app" -Docs "https://example.com/docs" -DotfilesSourcePath "C:\Apps\ExampleApp\Config" -Dotfiles "config.json"
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
        [hashtable] $Props,

        [Parameter(Mandatory = $true)]
        [ValidateSet('Scoop')]
        [AppType] $Type
    )

    return [App]::new(
        $Props,
        $Type
    )
}

Export-ModuleMember -Function New-App
