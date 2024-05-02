using module .\MyApps.psm1
class MyAppRunner {

    #     # [System.IO.DirectoryInfo] $AppFolders = (Get-ChildItem -Path "$($this.AppsScriptFolder)" -Directory)
    #     # static [array] $AppFolders
    #     static [string] $Command = $null
    #     static [hashtable] $MyApps = [hashtable]::new() # $MyApps = @{}

    #     static [void] Run([string] $Command) {
    #         if ($null -ne $Command) {
    #             [AppCommander]::Command = $Command
    #             $AppsScriptFolder = [System.IO.DirectoryInfo]::new("$Env:dotfiles\Apps")
    #             # [AppCommander]::AppFolders +=

    #             foreach ($AppFolder in $AppsScriptFolder.GetDirectories()) {
    #                 [AppCommander]::LoadAppClass($AppFolder)
    #                 [AppCommander]::Execute($AppFolder, $Command)
    #             }
    #         }
    #     }

    #     static LoadAppClass($AppFolder) {
    #         [AppCommander]::AppFolders.Name
    #         $scriptPath = Join-Path -Path $AppFolder.FullName -ChildPath "$($AppFolder.Name).ps1"
    #         Write-Debug "scriptPath: $scriptPath"

    #         if (Test-Path $scriptPath) {
    #             . $scriptPath
    #             Write-Debug "appFolder.Name: $($AppFolder.Name)"
    #             [AppCommander]::MyApps[$AppFolder.Name] = New-Object -TypeName $($AppFolder.Name)
    #             $MySystemState.UpdateAppData([string] $($AppFolder.Name), [object] [AppCommander]::MyApps[$AppFolder.Name])
    #         } else {
    #             Write-Warning "Script file for $($AppFolder.Name) not found at $scriptPath"
    #             continue
    #         }
    #     }



    #     static [void] Execute($AppFolder, $Command) {
    #         switch ($Command) {
    #             'load-all' {
    #                 # Assuming load-all means loading all class files without executing any specific methods
    #             }

    #             'clear-apps' {
    #                 [AppCommander]::MyApps[$AppFolder.Name].Clear()
    #             }

    #             'compare-apps-dotfiles' {
    #                 [AppCommander]::MyApps[$AppFolder.Name].CompareDotfiles()
    #             }

    #             'enable-apps' {
    #                 if ([AppCommander]::MyApps[$AppFolder.Name].GetType().GetMethod('Enable')) {
    #                     Write-Host " ⏱️ Enable $($AppFolder.Name) => " -NoNewline -ForegroundColor Green
    #                     $t = Measure-Command {
    #                         [AppCommander]::MyApps[$AppFolder.Name].Enable()
    #                     }
    #                     $ProfileLoadTime.Milliseconds += $t.Milliseconds
    #                     $ProfileLoadTime.Measurements += 1
    #                     Write-Host $t.Milliseconds"ms" -ForegroundColor Green
    #                 }
    #             }

    #             'install-apps' {
    #                 [AppCommander]::MyApps[$AppFolder.Name].Install()
    #             }

    #             'invoke-apps' {
    #                 [AppCommander]::MyApps[$AppFolder.Name].Invoke()
    #             }

    #             'set-apps-environmentvariables' {
    #                 if ([AppCommander]::MyApps[$AppFolder.Name].GetType().GetMethod('SetEnvironmentVariables')) {
    #                     Write-Host " ⏱️ Set Env Vars $([AppCommander]::MyApps[$AppFolder.Name].Name) => " -NoNewline -ForegroundColor Green
    #                     $t = Measure-Command {
    #                         [AppCommander]::MyApps[$AppFolder.Name].SetEnvironmentVariables()
    #                     }
    #                     $ProfileLoadTime.Milliseconds += $t.Milliseconds
    #                     $ProfileLoadTime.Measurements += 1
    #                     Write-Host $t.Milliseconds"ms" -ForegroundColor Green
    #                 }
    #             }

    #             'show-apps-docs' {
    #                 Write-Warning "Really show all docs including $([AppCommander]::MyApps[$AppFolder.Name].Name)?" -BackgroundColor Red
    #                 # $MyApps[$AppFolder.Name].ShowDocs()
    #             }

    #             'show-apps-logo' {
    #                 $windowWidth = $host.ui.RawUI.WindowSize.Width
    #                 [AppCommander]::MyApps[$AppFolder.Name].ShowLogo($windowWidth)
    #             }

    #             'show-apps-releases' {
    #                 Write-Warning "Really show all releases including $([AppCommander]::MyApps[$AppFolder.Name].Name)?" -BackgroundColor Red
    #                 # $MyApps[$AppFolder.Name].ShowReleases()
    #             }

    #             'show-apps-repo' {
    #                 Write-Warning "Really show all repos including $([AppCommander]::MyApps[$AppFolder.Name].Name)?" -BackgroundColor Red
    #                 # $MyApps[$AppFolder.Name].ShowRepo()
    #             }
    #             'reset-apps' {
    #                 [AppCommander]::MyApps[$AppFolder.Name].Reset()
    #             }

    #             'uninstall-apps' {
    #                 Write-Warning "Really uninstall  all app including $([AppCommander]::MyApps[$AppFolder.Name].Name)?" -BackgroundColor Red
    #                 # To proceed, uncomment the line below
    #                 # $MyApps[$AppFolder.Name].Uninstall()
    #             }

    #             'update-apps' {
    #                 [AppCommander]::MyApps[$AppFolder.Name].Update()
    #             }

    #             default {
    #                 Write-Error "Command `$Command` not recognized or not implemented." -BackgroundColor Red
    #             }
    #         }
    #     }
    #     # # [void] Clear() {
    #     # #     # Logic to clean app's cache or other maintenance tasks.
    #     # # }

    #     # # [void] CompareDotfiles() {
    #     # #     # Logic to compare dotfiles with reference to see if something has changed.
    #     # # }

    #     #     New-Item -ItemType SymbolicLink -Path "$($this.DotfilesSourcePath)\$($this.Dotfiles)" -Target "$($AppFolder)\$($this.Dotfiles)"
    #     # }

    #     # # [void] Enable() {
    #     # #     # Logic to run in profile to import, dotsource or invoke app
    #     # # }

    #     # [void] Install() {
    #     #     # Logic to install app
    #     #     if (-Not (Test-Path "$Env:SCOOP\buckets\$($this.Store)" -PathType Container)) {
    #     #         scoop Store add -Name "$($this.Store)"
    #     #     }
    #     #     if (-Not (Test-Path $this.VerifyFile -PathType Leaf)) {
    #     #         scoop install "$($this.Store)/$($this.Name)"
    #     #     }
    #     # }

    #     # # [void] Invoke() {
    #     # #     # Logic to run the app.
    #     # # }

    #     # # [void] SetEnvironmentVariables() {
    #     # #     # Logic to set app env variables
    #     # #     $Value = ""
    #     # #     if (($null -eq $Env:app_ENV_VAR) -or ($Value -ne $Env:app_ENV_VAR)) {
    #     # #         [Environment]::SetEnvironmentVariable("app_ENV_VAR", "$Value", [EnvironmentVariableTarget]::User)
    #     # #     }
    #     # # }

    #     # [void] ShowDocs() {
    #     #     # Logic to show app documentation
    #     #     Start-Process "$($this.Docs)"
    #     # }

    #     # [void] ShowLogo() {
    #     #     # Set Logo first in file for a nice experience
    #     #     # -ForegroundColor Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White
    #     #     # -BackgroundColor Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White
    #     #     $windowWidth = $Script:windowWidth

    #     #     # Determine the maximum width of any line in the logo
    #     #     $maxWidth = ($this.Logo -split "`n" | Measure-Object -Property Length -Maximum).Maximum

    #     #     # Calculate the left padding based on the window width
    #     #     $space = " " * (($windowWidth - $maxWidth) / 2)

    #     #     # Split logo into lines and write each one with proper alignment
    #     #     $this.Logo -split "`n" | ForEach-Object {
    #     #         Write-Host $space$_ -ForegroundColor Blue
    #     #     }
    #     # }

    #     # [void] ShowReleases() {
    #     #     # Logic to show release notes or changelog
    #     #     Start-Process "$($this.Repo)/releases"
    #     # }

    #     # [void] ShowRepo() {
    #     #     # Logic to show app repository
    #     #     Start-Process "$($this.Repo)"
    #     # }

    #     # [void] Reset() {
    #     #     # Logic to reset app
    #     #     scoop reset "$($this.Store)/$($this.Name)"
    #     # }

    #     # [void] Uninstall() {
    #     #     scoop uninstall "$($this.Store)/$($this.Name)"
    #     # }

    #     # [void] Update([string] $Version) {
    #     #     # Logic to update app
    #     #     scoop update "$($this.Store)/$($this.Name)"
    #     #     $this.Version = [version]::Parse($Version)
    #     #     $this.AppLastUpdate = (Get-Date).ToShortDateString()
    #     #     $this.UpdateSystemState()
    #     # }

    #     # [void] UpdateSystemState() {
    #     #     $MySystemState.UpdateAppData($this.Name, $this)
    #     # }
}



