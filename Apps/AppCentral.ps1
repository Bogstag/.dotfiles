using module My
param (
    [string]$Command
)
# $DebugPreference = "Continue"
$ErrorActionPreference = "Stop"
$appsPath = "$Env:dotfiles\Apps"
$appsFolder = Get-ChildItem -Path $appsPath -Directory
$Apps = @{}
Write-Debug "appsFolder: $appsFolder"

foreach ($appFolder in $appsFolder) {
    $scriptPath = Join-Path -Path $appFolder.FullName -ChildPath "$($appFolder.Name).ps1"
    Write-Debug "scriptPath: $scriptPath"
    if (Test-Path $scriptPath) {
        . $scriptPath
        Write-Debug "appFolder.Name: $($appFolder.Name)"
        $Apps[$appFolder.Name] = New-Object -TypeName $($appFolder.Name)
        $GenericState.UpdateAppData([string] $($appFolder.Name), [object] $Apps[$appFolder.Name])
    } else {
        Write-Warning "Script file for $($appFolder.Name) not found at $scriptPath"
        continue
    }

    switch ($Command) {
        'load-all' {
            # Assuming load-all means loading all class files without executing any specific methods
        }

        'clear-apps' {
            $Apps[$appFolder.Name].Clear()
        }

        'compare-apps-dotfiles' {
            $Apps[$appFolder.Name].CompareDotfiles()
        }

        'deploy-apps-dotfiles' {
            $Apps[$appFolder.Name].DotfilesSwitch([DotfilesAction]'deploy')
        }

        'enable-apps' {
            if ($Apps[$appFolder.Name].GetType().GetMethod('Enable')) {
                Write-Host " ⏱️ Enable $($Apps[$appFolder.Name].Name) => " -NoNewline -ForegroundColor Green
                $t = Measure-Command {
                    $Apps[$appFolder.Name].Enable()
                }
                $ProfileLoadTime.Milliseconds += $t.Milliseconds
                $ProfileLoadTime.Measurements += 1
                Write-Host $t.Milliseconds"ms" -ForegroundColor Green
            }
        }

        'install-apps' {
            $Apps[$appFolder.Name].Install()
        }

        'invoke-apps' {
            $Apps[$appFolder.Name].Invoke()
        }

        'remove-apps-dotfiles' {
            Write-Warning "Not allowed" -BackgroundColor Red
            # $Apps[$appFolder.Name].DotfilesSwitch([DotfilesAction]'remove')
        }

        'reset-apps' {
            $Apps[$appFolder.Name].Reset()
        }

        'set-apps-environmentvariables' {
            if ($Apps[$appFolder.Name].GetType().GetMethod('SetEnvironmentVariables')) {
                Write-Host " ⏱️ Set Env Vars $($Apps[$appFolder.Name].Name) => " -NoNewline -ForegroundColor Green
                $t = Measure-Command {
                    $Apps[$appFolder.Name].SetEnvironmentVariables()
                }
                $ProfileLoadTime.Milliseconds += $t.Milliseconds
                $ProfileLoadTime.Measurements += 1
                Write-Host $t.Milliseconds"ms" -ForegroundColor Green
            }
        }

        'show-apps-docs' {
            Write-Warning "Not allowed" -BackgroundColor Red
            # $Apps[$appFolder.Name].ShowDocs()
        }

        'show-apps-logo' {
            $Apps[$appFolder.Name].ShowLogo()
        }

        'show-apps-releases' {
            Write-Warning "Not allowed" -BackgroundColor Red
            # $Apps[$appFolder.Name].ShowReleases()
        }

        'show-apps-repo' {
            Write-Warning "Not allowed" -BackgroundColor Red
            # $Apps[$appFolder.Name].ShowRepo()
        }


        'uninstall-apps' {
            Write-Warning "Not allowed" -BackgroundColor Red
            # $Apps[$appFolder.Name].Uninstall()
        }

        'update-apps' {
            $Apps[$appFolder.Name].Update()
        }

        default {
            Write-Error "Command `$Command` not recognized or not implemented." -BackgroundColor Red
        }
    }
}

Remove-Variable -Name appFolder
Remove-Variable -Name appsFolder
Remove-Variable -Name scriptPath
Remove-Variable -Name appsPath
