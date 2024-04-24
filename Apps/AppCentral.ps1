using module DotfilesModule
param (
    [string]$Command
)

$appsPath = "$Env:dotfiles\Apps"
$appsFolder = Get-ChildItem -Path $appsPath -Directory
$instances = @{}
Write-Debug "appsFolder: $appsFolder"

foreach ($appFolder in $appsFolder) {
    $scriptPath = Join-Path -Path $appFolder.FullName -ChildPath "$($appFolder.Name).ps1"
    Write-Debug "scriptPath: $scriptPath"
    if (Test-Path $scriptPath) {
        . $scriptPath
        $instances[$appFolder.Name] = New-Object -TypeName $($appFolder.Name)
        $SystemState.UpdateAppData([string] $($appFolder.Name), [object] $instances[$appFolder.Name])
    } else {
        Write-Warning "Script file for $($appFolder.Name) not found at $scriptPath"
        continue
    }

    switch ($Command) {
        'load-all' {
            # Assuming load-all means loading all class files without executing any specific methods
        }

        'clear-apps' {
            $instances[$appFolder.Name].Clear()
        }

        'compare-apps-dotfiles' {
            $instances[$appFolder.Name].CompareDotfiles()
        }

        'deploy-apps-dotfiles' {
            $instances[$appFolder.Name].DeployDotfiles()
        }

        'enable-apps' {
            if ($instances[$appFolder.Name].GetType().GetMethod('Enable')) {
                Write-Host " ⏱️ $($instances[$appFolder.Name].Name) => " -NoNewline -ForegroundColor Green
                $t = Measure-Command {
                    $instances[$appFolder.Name].Enable()
                }
                $ProfileLoadTime.Milliseconds += $t.Milliseconds
                $ProfileLoadTime.Measurements += 1
                Write-Host $t.Milliseconds"ms" -ForegroundColor Green
            }
        }

        'install-apps' {
            $instances[$appFolder.Name].Install()
        }

        'invoke-apps' {
            $instances[$appFolder.Name].Invoke()
        }

        'set-apps-environmentvariables' {
            $instances[$appFolder.Name].SetEnvironmentVariables()
        }

        'show-apps-docs' {
            Write-Warning "Really show all docs including $($instances[$appFolder.Name].Name)?" -BackgroundColor Red
            # $instances[$appFolder.Name].ShowDocs()
        }

        'show-apps-logo' {
            $windowWidth = $host.ui.RawUI.WindowSize.Width
            $instances[$appFolder.Name].ShowLogo($windowWidth)
        }

        'show-apps-releases' {
            Write-Warning "Really show all releases including $($instances[$appFolder.Name].Name)?" -BackgroundColor Red
            # $instances[$appFolder.Name].ShowReleases()
        }

        'show-apps-repo' {
            Write-Warning "Really show all repos including $($instances[$appFolder.Name].Name)?" -BackgroundColor Red
            # $instances[$appFolder.Name].ShowRepo()
        }
        'reset-apps' {
            $instances[$appFolder.Name].Reset()
        }

        'uninstall-apps' {
            Write-Warning "Really uninstall  all app including $($instances[$appFolder.Name].Name)?" -BackgroundColor Red
            # To proceed, uncomment the line below
            # $instances[$appFolder.Name].Uninstall()
        }

        'update-apps' {
            $instances[$appFolder.Name].Update()
        }

        default {
            Write-Error "Command `$Command` not recognized or not implemented." -BackgroundColor Red
        }
    }
}
