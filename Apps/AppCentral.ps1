using module DotfilesModule
param (
    [string]$Command
)
# $DebugPreference = 'Continue'
$appsPath = "$Env:dotfiles\Apps"
$appsFolder = Get-ChildItem -Path $appsPath -Directory
$MyApps = @{}
Write-Debug "appsFolder: $appsFolder"

foreach ($appFolder in $appsFolder) {
    $scriptPath = Join-Path -Path $appFolder.FullName -ChildPath "$($appFolder.Name).ps1"
    Write-Debug "scriptPath: $scriptPath"
    if (Test-Path $scriptPath) {
        . $scriptPath
        Write-Debug "appFolder.Name: $($appFolder.Name)"
        $MyApps[$appFolder.Name] = New-Object -TypeName $($appFolder.Name)
        $MySystemState.UpdateAppData([string] $($appFolder.Name), [object] $MyApps[$appFolder.Name])
    } else {
        Write-Warning "Script file for $($appFolder.Name) not found at $scriptPath"
        continue
    }

    switch ($Command) {
        'load-all' {
            # Assuming load-all means loading all class files without executing any specific methods
        }

        'clear-apps' {
            $MyApps[$appFolder.Name].Clear()
        }

        'compare-apps-dotfiles' {
            $MyApps[$appFolder.Name].CompareDotfiles()
        }

        'deploy-apps-dotfiles' {
            $MyApps[$appFolder.Name].DotfilesSwitch([DotfilesAction]'deploy')
        }

        'enable-apps' {
            if ($MyApps[$appFolder.Name].GetType().GetMethod('Enable')) {
                Write-Host " ⏱️ Enable $($MyApps[$appFolder.Name].Name) => " -NoNewline -ForegroundColor Green
                $t = Measure-Command {
                    $MyApps[$appFolder.Name].Enable()
                }
                $ProfileLoadTime.Milliseconds += $t.Milliseconds
                $ProfileLoadTime.Measurements += 1
                Write-Host $t.Milliseconds"ms" -ForegroundColor Green
            }
        }

        'install-apps' {
            $MyApps[$appFolder.Name].Install()
        }

        'invoke-apps' {
            $MyApps[$appFolder.Name].Invoke()
        }

        'remove-apps-dotfiles' {
            Write-Warning "Not allowed" -BackgroundColor Red
            # $MyApps[$appFolder.Name].DotfilesSwitch([DotfilesAction]'remove')
        }

        'reset-apps' {
            $MyApps[$appFolder.Name].Reset()
        }

        'set-apps-environmentvariables' {
            if ($MyApps[$appFolder.Name].GetType().GetMethod('SetEnvironmentVariables')) {
                Write-Host " ⏱️ Set Env Vars $($MyApps[$appFolder.Name].Name) => " -NoNewline -ForegroundColor Green
                $t = Measure-Command {
                    $MyApps[$appFolder.Name].SetEnvironmentVariables()
                }
                $ProfileLoadTime.Milliseconds += $t.Milliseconds
                $ProfileLoadTime.Measurements += 1
                Write-Host $t.Milliseconds"ms" -ForegroundColor Green
            }
        }

        'show-apps-docs' {
            Write-Warning "Not allowed" -BackgroundColor Red
            # $MyApps[$appFolder.Name].ShowDocs()
        }

        'show-apps-logo' {
            $MyApps[$appFolder.Name].ShowLogo()
        }

        'show-apps-releases' {
            Write-Warning "Not allowed" -BackgroundColor Red
            # $MyApps[$appFolder.Name].ShowReleases()
        }

        'show-apps-repo' {
            Write-Warning "Not allowed" -BackgroundColor Red
            # $MyApps[$appFolder.Name].ShowRepo()
        }


        'uninstall-apps' {
            Write-Warning "Not allowed" -BackgroundColor Red
            # $MyApps[$appFolder.Name].Uninstall()
        }

        'update-apps' {
            $MyApps[$appFolder.Name].Update()
        }

        default {
            Write-Error "Command `$Command` not recognized or not implemented." -BackgroundColor Red
        }
    }
}
