using module ./My.GenericState.psm1

Enum PackageManager {
    Scoop
    None
}

Enum DotfilesAction {
    deploy
    remove
}

class Apps {
    [string] $Logo
    [string] $Name # Pretty Name
    [string] $Id = (Convert-ToPascalCase($this.Name)) # Package Manager Name
    [PackageManager] $PackageManager = "None"
    [string] $Store = "Unknown" # Buckets in Scoop
    [string] $VerifyFile # File that exist if installed, recommended is exe file.
    [string] $GithubOwnerRepo # Owner/Repo
    [string] $RepoUrl # URL to Repo or null if GithubOwnerRepo is set
    [string] $DocsUrl # URL to Docs
    [string] $ChangeLogUrl # URL to ChangeLog, version, releases
    [string] $DotfilesSourcePath
    [array[]] $Dotfiles
    [version] $Version
    [datetime] $AppLastUpdate
    [string] $CacheFolder
    [string] $AppFolder

    Apps() {
        Write-Debug -Message "Apps Ctor props"
        $this.Init()
    }

    Apps([hashtable]$Properties) {
        $type = $this.GetType()

        if ($type -eq [Apps]) {
            throw("Class $type must be inherited")
        }

        Write-Debug -Message "Apps Ctor props"
        $this.Init($Properties)
    }

    [void] Init() {
        $this.Init(@{})
    }

    [void] Init([hashtable]$Properties) {
        if ($null -ne $Properties) {
            foreach ($Property in $Properties.Keys) {
                $this.$Property = $Properties.$Property
            }
        }
    }

    [HashTable] Splat([String[]] $Properties) {
        $splat = @{}

        foreach ($prop in $Properties) {
            if ($this.GetType().GetProperty($prop)) {
                $splat.Add($prop, $this.$prop)
            }
        }

        return $splat
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
        if ([uri]$this.DocsUrl) { Start-Process "$($this.Docs)" }
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

    [string] ShowChangeLog ($uri = $null) {
        # Logic to show release notes or changelog
        if ($this.ChangeLogUrl) {
            $uri = [uri]$this.ChangeLogUrl
        } elseif ($this.GithubOwnerRepo) {
            $uri = [uri]"https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        }

        if ($uri) {
            $Response = Invoke-RestMethod -Uri $uri
            if ("github.com" -eq $uri.Host) {
                $output = Show-Markdown -InputObject $Response.body
            } else {
                $output = $Response
            }
            return $output.subString(0, [System.Math]::Min(400, $output.Length))
        } else {
            Write-Warning -Message "No changelog found"
            return $null
        }
    }

    [void] ShowRepo($uri = $null) {
        # Logic to show app repository
        if ($this.RepoUrl) {
            $uri = [uri]$this.RepoUrl
        } elseif ($this.GithubOwnerRepo) {
            $uri = [uri]"https://github.com/" + $this.GithubOwnerRepo
        }
        if ($uri) {
            Start-Process "$uri"
        } else {
            Write-Warning -Message "No Repo URI found"
        }
    }

    [void] Uninstall() {
        scoop uninstall "$($this.Store)/$($this.Name)"
        $this.DotfilesSwitch('remove')
        # TODO: Remove env var
    }

    [void] UpdateSystemState() {
        New-App($this.GetType(), $this)
        $global:GenericState.UpdateAppData($this.GetType(), $this) # TODO: This dont work
    }

    [void] Update([string] $Version) {
        # Logic to update app
        scoop update "$($this.Store)/$($this.Name)"
        $this.Version = [version]::Parse($Version)
        $this.AppLastUpdate = (Get-Date).ToShortDateString()
        $this.UpdateSystemState()
    }


}
