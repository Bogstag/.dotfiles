# Example
# .\ScoopAppCentral.ps1 -Command "enable-apps"
# $env:dotfiles\ScoopApps\ScoopAppCentral.ps1 -Command "enable-apps"

param (
    [string]$Command
)

$appsPath = "$env:dotfiles\ScoopApps"
$apps = Get-ChildItem -Path $appsPath -Directory

foreach ($app in $apps) {
    $scriptPath = Join-Path -Path $app.FullName -ChildPath "$($app.Name).ps1"
    . $scriptPath

    switch ($Command) {
        'load-functions' {
            # Only DotSource All Functions, dont run anything.
        }

        'clear-apps' {
            Invoke-Expression "Clear-$($app.Name)"
        }

        'compare-apps-dotfiles' {
            Invoke-Expression "Compare-$($app.Name)Dotfiles"
        }

        'deploy-apps-dotfiles' {
            Invoke-Expression "Deploy-$($app.Name)Dotfiles"
        }

        'enable-apps' {
            Invoke-Expression "Enable-$($app.Name)"
        }

        'install-apps' {
            Invoke-Expression "Install-$($app.Name)"
        }

        'invoke-apps' {
            Invoke-Expression "Invoke-$($app.Name)"
        }

        'set-apps-environmentvariables' {
            Invoke-Expression "Set-$($app.Name)EnvironmentVariables"
        }

        'show-apps-docs' {
            Write-Host "Do you really want to show $($app.Name) docs"
            # Invoke-Expression "Show-$($app.Name)Docs"
        }

        'show-apps-logo' {
            Invoke-Expression "Show-$($app.Name)Logo"
        }

        'show-apps-releases' {
            Write-Host "Do you really want to show $($app.Name) releases"
            # Invoke-Expression "Show-$($app.Name)Releases"
        }

        'show-apps-repo' {
            Write-Host "Do you really want to show $($app.Name) repo"
            # Invoke-Expression "Show-$($app.Name)Repo"
        }

        'reset-apps' {
            Invoke-Expression "Reset-$($app.Name)"
        }

        'uninstall-apps' {
            Write-Host "Do you really want to uninstall $($app.Name)"
            # Invoke-Expression "Uninstall-$($app.Name)"
        }

        'update-apps' {
            Invoke-Expression "Update-$($app.Name)"
        }
    }
}


