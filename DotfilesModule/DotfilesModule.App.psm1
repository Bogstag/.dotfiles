using module .\DotfilesModule.SystemState.psm1
Enum AppType {
    Scoop
}
class App {
    [string] $Logo
    [string] $Name
    [AppType]$Type
    [string] $Store # Stores in Scoop
    [string] $VerifyFile # File that exist if installed, recommended is exe file.
    [string] $GithubOwnerRepo # Owner/Repo
    [string] $Repo # URL to Repo or null if GithubOwnerRepo is set
    [string] $Docs # URL to Docs
    [string] $DotfilesFolder
    [System.Collections.Generic.List[string]] $Dotfiles
    [version] $Version = [version]::Parse("0.0.0")
    [datetime] $AppLastUpdate
    [string] $CacheFolder
    [string] $AppFolder

    # App() {
    #     $this.Init(@{})
    # }

    App([hashtable]$Properties) {
        $this.Init($Properties)
    }

    App([hashtable]$Properties, [AppType]$Type) {
        $this.Type = $Type
        $this.Init($Properties)
    }

    App([string]$Name, [string]$Store, [string]$VerifyFile) {
        $this.Init(@{Name = $Name; Store = $Store; VerifyFile = $VerifyFile })
    }

    # Shared initializer method
    hidden Init([hashtable]$Properties) {
        foreach ($Property in $Properties.Keys) {
            $this.$Property = $Properties.$Property
        }
    }

    # [void] Clear() {
    #     # Logic to clean app's cache or other maintenance tasks.
    # }

    [void] DeployDotfiles() {
        foreach ($Dotfile In $this.Dotfiles) {
            $Dotfile = [IO.FileInfo]::new("$Dotfile")
            if ($Dotfile -isnot [IO.FileInfo]) {
                Write-Error -Message "$($Dotfile.FullName) has $(($Dotfile.GetType()).Name) type"
                continue
            }

            $DotFileFolder = $Dotfile.Directory
            $OldDotfile = [IO.FileInfo]::new("($($Dotfile.FullName)).old")
            $DotFileSource = [IO.FileInfo]::new("$($this.AppFolder)\$($Dotfile.Name)")

            # Verify sourcefile exist
            if ($false -eq $DotFileSource.Exists) {
                Write-Warning -Message "Creating missing dot file: $($DotFileSource.FullName)"
                $DotFileSource.Create()
            }

            if ($DotFileFolder.Exists) {
                if ($OldDotfile.Exists) {
                    # If there is a .old file there, delete it.
                    # If you want to remove the old files, run DeployDotfiles two times.
                    $OldDotfile.Delete()
                }
                if ($Dotfile.Exists) {
                    if ("SymbolicLink" -eq $Dotfile.LinkType) {
                        # If not "real" file, just delete it.
                        $Dotfile.Delete()
                        $Dotfile.Refresh()
                    } else {
                        # If there are existing file there, rename it to .old as a soft backup
                        Rename-Item -Path "$($Dotfile.FullName)" -NewName "$($Dotfile.Name).old" -Force -ErrorAction SilentlyContinue
                    }
                }
            } else {
                $DotFileFolder.Create()
            }

            $Dotfile.CreateAsSymbolicLink("$($DotFileSource.FullName)")
        }
    }


    # [void] Enable() {
    #     # Logic to run in profile to import, dotsource or invoke app
    # }

    [uri] GetRepoUri([string]$Switch) {
        if ([string]::IsNullOrEmpty($this.GithubOwnerRepo)) {
            return [uri]$this.Repo
        } else {
            switch ($Switch) {
                'latest-release' {
                    return [uri]"https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
                }
                'repo' {
                    return [uri]"https://github.com/" + $this.GithubOwnerRepo
                }
                default {
                    Write-Error "`$Switch` not recognized or not implemented." -BackgroundColor Red
                }
            }
            return [uri]$this.GithubOwnerRepo
        }
        return [uri]$this.Repo
    }

    [void] Install() {
        # Logic to install app
        if (-Not (Test-Path "$Env:SCOOP\buckets\$($this.Store)" -PathType Container)) {
            scoop bucket add -Name "$($this.Store)"
        }
        if (-Not (Test-Path $this.VerifyFile -PathType Leaf)) {
            scoop install "$($this.Store)/$($this.Name)"
            $this.DeployDotfiles()
            # TODO: Add env var
        }
    }

    # [void] Invoke() {
    #     # Logic to run the app.
    # }

    [void] RemoveDotfiles() {
        foreach ($Dotfile In $this.Dotfiles) {
            $Dotfile = [IO.FileInfo]::new("$Dotfile")
            if ($Dotfile -isnot [IO.FileInfo]) {
                Write-Error -Message "$($Dotfile.FullName) has $(($Dotfile.GetType()).Name) type"
                continue
            }

            $DotFileFolder = $Dotfile.Directory
            $OldDotfile = [IO.FileInfo]::new("($($Dotfile.FullName)).old")

            if ($OldDotfile.Exists) {
                $OldDotfile.Delete()
            }
            if ($Dotfile.Exists) {
                $Dotfile.Delete()
            }
            if ($DotFileFolder.Exists) {
                $DotFileFolder.Delete()
            }
        }
    }

    [void] Reset() {
        # Logic to reset app
        scoop reset "$($this.Store)/$($this.Name)"
    }

    # [void] SetEnvironmentVariables() {
    #     # Logic to set app env variables
    # }

    [void] ShowDocs() {
        # Logic to show app documentation
        Start-Process "$($this.Docs)"
    }

    [void] ShowLogo() {
        # Determine the logo maximum width
        $maxWidth = ($this.Logo -split "`n" | Measure-Object -Property Length -Maximum).Maximum
        $windowWidth = $global:host.ui.RawUI.WindowSize.Width
        # $windowWidth = $Script:windowWidth
        if ($windowWidth -lt $maxWidth) {
            $windowWidth = $maxWidth + 40
        }

        # Calculate the left padding based on the window width
        $space = " " * (($windowWidth - $maxWidth) / 2)

        # Split logo into lines and write each one with proper alignment
        $this.Logo -split "`n" | ForEach-Object {
            Write-Host $space$_ -ForegroundColor Blue
        }
    }

    [string] ShowReleases() {
        # Logic to show release notes or changelog
        $uri = $this.GetRepoUri('latest-release')
        $Response = Invoke-RestMethod -Uri $uri
        return Show-Markdown -InputObject $Response.body
    }

    [void] ShowRepo() {
        # Logic to show app repository
        $uri = $this.GetRepoUri('repo')
        Start-Process "$uri"
    }


    [void] Uninstall() {
        scoop uninstall "$($this.Store)/$($this.Name)"
        $this.RemoveDotfiles()
        # TODO: Remove env var
    }

    [void] Update([string] $Version) {
        # Logic to update app
        scoop update "$($this.Store)/$($this.Name)"
        $this.Version = [version]::Parse($Version)
        $this.AppLastUpdate = (Get-Date).ToShortDateString()
        $this.UpdateSystemState()
    }

    [void] UpdateSystemState() {
        Write-Host "Updating SystemState for $($this.Name)"
        [SystemState]::UpdateAppData($this.Name, $this)
    }
}
