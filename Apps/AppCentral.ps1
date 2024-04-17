# Example
# .\AppCentral.ps1 -Command "install-apps"
# $env:dotfiles\Apps\AppCentral.ps1 -Command "deploy-dotfiles"
param (
    [string]$Command
)

$appsPath = "$env:dotfiles\Apps"
$apps = Get-ChildItem -Path $appsPath -Directory

foreach ($app in $apps) {
    $scriptPath = Join-Path -Path $app.FullName -ChildPath "$($app.Name).ps1"
    . $scriptPath

    switch ($Command) {
        'load-functions' {
            # Only DotSource All Functions
        }
        'install-apps' {
            Invoke-Expression "Install-$($app.Name)"
        }
        'uninstall-apps' {
            Invoke-Expression "Uninstall-$($app.Name)"
        }
        'reset--apps' {
            Invoke-Expression "Reset-$($app.Name)"
        }
        'update-apps' {
            Invoke-Expression "Update-$($app.Name)"
        }
        'set-environmentvariables' {
            Invoke-Expression "Set-$($app.Name)EnvironmentVariables"
        }
        'clear-apps' {
            Invoke-Expression "Clear-$($app.Name)"
        }
        'deploy-dotfiles' {
            Invoke-Expression "Deploy-$($app.Name)Dotfiles"
        }
        'compare-dotfiles' {
            Invoke-Expression "Compare-$($app.Name)Dotfiles"
        }
        'show-logo' {
            Invoke-Expression "Show-$($app.Name)Logo"
        }
    }
}


