using module .\DotfilesModule.MySystemState.psm1
Enum AppType {
    Scoop
}

Enum DotfilesAction {
    deploy
    remove
}

class App {
    [string] $Logo
    [string] $Name # Scoop name
    [AppType]$Type
    [string] $Store # Stores in Scoop
    [string] $VerifyFile # File that exist if installed, recommended is exe file.
    [string] $GithubOwnerRepo # Owner/Repo
    [string] $Repo # URL to Repo or null if GithubOwnerRepo is set
    [string] $Docs # URL to Docs
    [string] $DotfilesSourcePath
    [array[]] $Dotfiles
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

    [bool] DeployDotfile($DotfileString) {
        Write-Debug "DeployDotfile DotfileString: $DotfileString"
        $isDir = $false
        $isFile = $false
        $DotfileDest = $false
        $DotFileSource = $false
        $OldDotfileDest = $false
        $leaf = Split-Path -Leaf $DotfileString
        $sourceString = "$($this.DotfilesSourcePath)\$($leaf)"
        if ([System.IO.File]::Exists($sourceString)) {
            $isFile = $true
            $DotfileDest = [IO.FileInfo]::new("$DotfileString")
            $DotFileSource = [IO.FileInfo]::new("$sourceString")
            $OldDotfileDest = [IO.FileInfo]::new("($($DotfileDest.FullName)).old")
        }
        if ([System.IO.Directory]::Exists($sourceString)) {
            $isDir = $true
            $DotfileDest = [IO.DirectoryInfo]::new("$DotfileString")
            $DotFileSource = [IO.DirectoryInfo]::new("$sourceString")
            $OldDotfileDest = [IO.DirectoryInfo]::new("($($DotfileDest.FullName)).old")
        }

        if (($false -eq $isFile) -AND ($false -eq $isDir)) {
            Write-Error -Message "Missing Dotfile Source: $($sourceString)"
            return $false
        }

        if ($isFile) {
            $DotFileDestFolder = $DotfileDest.Directory
        } else {
            $DotFileDestFolder = $DotfileDest.Parent
        }
        if ($DotFileDestFolder.Exists) {
            Write-Debug "DotFileDestFolder exists: $DotFileDestFolder"
            if ($OldDotfileDest.Exists) {
                Write-Debug "OldDotfileDest exists: $OldDotfileDest"
                $OldDotfileDest.Delete()
            }
            if ($DotfileDest.Exists) {
                Write-Debug "DotfileDest exists: $DotfileDest"
                if ("SymbolicLink" -eq $DotfileDest.LinkType) {
                    $DotfileDest.Delete()
                    $DotfileDest.Refresh()
                } else {
                    Write-Debug "DotfileDest did not exists: $DotfileDest"
                    # If there are existing file there, rename it to .old as a soft backup
                    Rename-Item -Path "$($DotfileDest.FullName)" -NewName "$($DotfileDest.Name).old" -Force -ErrorAction SilentlyContinue
                }
            }
        } else {
            Write-Debug "DotFileDestFolder did not exists: $DotFileDestFolder"
            $DotFileDestFolder.Create()
        }

        $DotfileDest.CreateAsSymbolicLink("$($DotFileSource.FullName)")
        return $true

    }

    [void] DeployDotfiles() {
        Write-Host "Dont use DeployDotfiles. Use DotfilesSwitch()"
        $this.DotfilesSwitch([DotfilesAction]'deploy')
    }

    [void] DotfilesSwitch([DotfilesAction]$DotfilesAction) {
        Write-Debug "DotfilesAction: $DotfilesAction"
        $this.DotfilesSwitch($DotfilesAction, @())
    }
    [void] DotfilesSwitch([DotfilesAction]$DotfilesAction, [array]$DotArray = @()) {
        Write-Debug "DotfilesAction: $DotfilesAction, DotArray: $DotArray, DotArray.Count: $($DotArray.Count)"
        if ($DotArray.Count -eq 0) {
            $DotArray = $this.Dotfiles
        }
        Write-Debug "DotfilesAction: $DotfilesAction, DotArray: $DotArray, DotArray.Count: $($DotArray.Count)"
        switch ($DotArray) {
            { $DotfilesAction -eq [DotfilesAction]::deploy } {
                Write-Debug "deploy PSItem: $PSItem"
                $this.DeployDotfile($PSItem)
                continue
            }

            { $DotfilesAction -eq [DotfilesAction]::remove } {
                Write-Debug "remove PSItem: $PSItem"
                $this.RemoveDotfile($PSItem)
                continue
            }

            Default {
                Write-Host "Invalid dotfile action: $DotfilesAction"
            }
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
            $this.DotfilesSwitch('deploy')
            # TODO: Add env var
        }
    }

    # [void] Invoke() {
    #     # Logic to run the app.
    # }

    [bool] RemoveDotfile($Dotfile) {
        $Dotfile = [IO.FileInfo]::new("$Dotfile")
        if ($Dotfile -isnot [IO.FileInfo]) {
            Write-Error -Message "$($Dotfile.FullName) has $(($Dotfile.GetType()).Name) type"
            return $false
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
        return $true
    }

    [void] RemoveDotfiles() {
        Write-Host "Dont use RemoveDotfiles. Use DotfilesSwitch()"
        $this.DotfilesSwitch([DotfilesAction]'remove')
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
        if ("github.com" -eq $uri.Host) {
            $output = Show-Markdown -InputObject $Response.body
        } else {
            $output = $Response
        }
        return $output.subString(0, [System.Math]::Min(400, $output.Length))
    }

    [void] ShowRepo() {
        # Logic to show app repository
        $uri = $this.GetRepoUri('repo')
        Start-Process "$uri"
    }


    [void] Uninstall() {
        scoop uninstall "$($this.Store)/$($this.Name)"
        $this.DotfilesSwitch('remove')
        # TODO: Remove env var
    }


    [void] UpdateSystemState() {
        [MySystemState].UpdateAppData($this.GetType(), $this)
    }

    [void] Update([string] $Version) {
        # Logic to update app
        scoop update "$($this.Store)/$($this.Name)"
        $this.Version = [version]::Parse($Version)
        $this.AppLastUpdate = (Get-Date).ToShortDateString()
        $this.UpdateSystemState()
    }
}
