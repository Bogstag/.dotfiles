# using module ./My.psd1
# using module ./My.State.psm1
# $ErrorActionPreference = "Stop"
# $DebugPreference = 'Stop'

Enum MyDotfilesAction {
    deploy
    remove
}
[NoRunspaceAffinity()]
class Apps {
    [string] $Logo
    [string] $Name # Pretty Name
    [string] $AppId # Safe App Name
    [string] $AppFolder
    [string] $AppStateJson
    [string] $VerifyFile # File that exist if installed, recommended is exe file.
    [string] $GithubOwnerRepo # Owner/Repo
    [string] $RepoUrl # URL to Repo or null if GithubOwnerRepo is set
    [string] $DocsUrl # URL to Docs
    [string] $ChangeLogUrl # URL to ChangeLog, version, releases
    [array[]] $Dotfiles
    [hashtable] $EnvVars
    [string] $CacheFolder
    [version] $Version
    [datetime] $AppLastUpdate
    [bool] $IsState = $false # $false, Init, NeedUpdate, Updated

    Apps() {
        # Write-Host "Apps()"
        $type = $this.GetType()
        if ($type -eq [Apps]) {
            throw("Class $type must be inherited")
        }
        $this.IsState = "Init"
        $this.AppsExit()
    }

    Apps([hashtable]$Properties) {
        # Write-Host "Apps(hashtable]$Properties)"
        $type = $this.GetType()
        if ($type -eq [Apps]) {
            throw("Class $type must be inherited")
        }
        $this.IsState = "Init"
        $this.UpdateProperties($Properties)
    }

    # [HashTable] Splat([String[]] $Properties) {
    #     $splat = @{}
    #     foreach ($prop in $Properties) {
    #         if ($this.GetType().GetProperty($prop)) {
    #             $splat.Add($prop, $this.$prop)
    #         }
    #     }
    #     return $splat
    # }

    [void] AppsExit() {
        # Write-Host "AppsExit() with state: $($this.IsState.ToString())"
        # All exits here

        if ("NeedUpdate" -eq $this.IsState) {
            $this.SaveAppState()
        }
        $this.IsState = $false
    }

    [IO.FileInfo] GetStateFilePath() {
        $file = [IO.FileInfo]::new("$($this.AppStateJson)")
        if (-Not $file.Exists) {
            $file.Create()
            return $null
        }

        return $file.FullName
    }

    [void] SaveAppState() {
        if ($this.AppStateJson) {
            try {
                $file = [IO.FileInfo]::new("$($this.AppStateJson)")
                if (-Not $file.Exists) {
                    $file.Create()
                }
                $this | ConvertTo-Json -Depth 20 | Set-Content -Path $file.FullName
            } catch {
                Write-Error "[Error] Failed to save app state: $_"
            }
        }
    }

    [void] LoadAppState() {
        [Hashtable] $Hashtable = @{}
        try {
            $file = [IO.FileInfo]::new("$($this.AppStateJson)")
            if ($file.Exists) {
                $Hashtable = Get-Content -Raw $file.FullName | `
                        ConvertFrom-Json -AsHashtable -DateKind Local -InputObject $_
            } else {
                $file.Create()
            }
        } catch {
            Write-Error "[Error] Failed to get app state: $_"
        }
        $this.UpdateProperties([hashtable]$Hashtable)
    }

    # [void] Clear() {} # Logic to clean app's cache or other maintenance tasks

    [void] NewDotfilesSwitch([MyDotfilesAction]$DotfilesAction, [array]$DotArray = @()) {
        # TODO: Rewrite so it works with new way
        Write-Debug "DotfilesAction: $DotfilesAction, DotArray: $DotArray, DotArray.Count: $($DotArray.Count)"
        if ($DotArray.Count -eq 0) {
            $DotArray = $this.Dotfiles
        }

        Write-Debug "DotfilesAction: $DotfilesAction, DotArray: $DotArray, DotArray.Count: $($DotArray.Count)"
        switch ($DotArray) {
            { $DotfilesAction -eq [MyDotfilesAction]::deploy } {
                Write-Debug "deploy PSItem: $PSItem"
                $this.DeployDotfile($PSItem)
                continue
            }

            { $DotfilesAction -eq [MyDotfilesAction]::remove } {
                Write-Debug "remove PSItem: $PSItem"
                $this.RemoveDotfile($PSItem)
                continue
            }

            Default {
                Write-Host "Invalid dotfile action: $DotfilesAction"
            }
        }
    }

    [bool] NewDeployDotfile($DotfileString) {
        # TODO: Rewrite so it works with new way
        Write-Debug "DeployDotfile DotfileString: $DotfileString"
        $isDir = $false
        $isFile = $false
        $DotfileDest = $false
        $DotFileSource = $false
        $OldDotfileDest = $false
        # $leaf = Split-Path -Leaf $DotfileString
        # $sourceString = "$($this.DotfilesSourcePath)\$($leaf)"
        # if ([System.IO.File]::Exists($sourceString)) {
        #     $isFile = $true
        #     $DotfileDest = [IO.FileInfo]::new("$DotfileString")
        #     $DotFileSource = [IO.FileInfo]::new("$sourceString")
        #     $OldDotfileDest = [IO.FileInfo]::new("($($DotfileDest.FullName)).old")
        # }
        # if ([System.IO.Directory]::Exists($sourceString)) {
        #     $isDir = $true
        #     $DotfileDest = [IO.DirectoryInfo]::new("$DotfileString")
        #     $DotFileSource = [IO.DirectoryInfo]::new("$sourceString")
        #     $OldDotfileDest = [IO.DirectoryInfo]::new("($($DotfileDest.FullName)).old")
        # }

        if (($false -eq $isFile) -AND ($false -eq $isDir)) {
            # Write-Error -Message "Missing Dotfile Source: $($sourceString)"
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

    [bool] DeployDotfile($DotfileString) {
        # TODO: This can be remove when new Rewrite is done.
        Write-Debug "DeployDotfile DotfileString: $DotfileString"
        # $isDir = $false
        $isFile = $false
        $DotfileDest = $false
        $DotFileSource = $false
        $OldDotfileDest = $false
        # $leaf = Split-Path -Leaf $DotfileString
        # $sourceString = "$($this.DotfilesSourcePath)\$($leaf)"
        # if ([System.IO.File]::Exists($sourceString)) {
        #     $isFile = $true
        #     $DotfileDest = [IO.FileInfo]::new("$DotfileString")
        #     $DotFileSource = [IO.FileInfo]::new("$sourceString")
        #     $OldDotfileDest = [IO.FileInfo]::new("($($DotfileDest.FullName)).old")
        # }
        # if ([System.IO.Directory]::Exists($sourceString)) {
        #     $isDir = $true
        #     $DotfileDest = [IO.DirectoryInfo]::new("$DotfileString")
        #     $DotFileSource = [IO.DirectoryInfo]::new("$sourceString")
        #     $OldDotfileDest = [IO.DirectoryInfo]::new("($($DotfileDest.FullName)).old")
        # }

        # if (($false -eq $isFile) -AND ($false -eq $isDir)) {
        #     Write-Error -Message "Missing Dotfile Source: $($sourceString)"
        #     return $false
        # }

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
        # TODO: This can be remove when new Rewrite is done.
        Write-Host "Dont use DeployDotfiles. Use DotfilesSwitch()"
        $this.DotfilesSwitch([MyDotfilesAction]'deploy')
    }

    [void] DotfilesSwitch([MyDotfilesAction]$DotfilesAction) {
        Write-Debug "DotfilesAction: $DotfilesAction"
        $this.DotfilesSwitch($DotfilesAction, @())
    }

    [void] DotfilesSwitch([MyDotfilesAction]$DotfilesAction, [array]$DotArray = @()) {
        Write-Debug "DotfilesAction: $DotfilesAction, DotArray: $DotArray, DotArray.Count: $($DotArray.Count)"
        if ($DotArray.Count -eq 0) {
            $DotArray = $this.Dotfiles
        }

        switch ($DotArray) {
            { $DotfilesAction -eq [MyDotfilesAction]::deploy } {
                Write-Debug "deploy PSItem: $PSItem"
                $this.DeployDotfile($PSItem)
                continue
            }

            { $DotfilesAction -eq [MyDotfilesAction]::remove } {
                Write-Debug "remove PSItem: $PSItem"
                $this.RemoveDotfile($PSItem)
                continue
            }

            Default {
                Write-Host "Invalid dotfile action: $DotfilesAction"
            }
        }
    }

    # [void] Enable() {} # Logic to run in profile to import, dotsource or invoke app

    [void] Install() {
        if ($this.GetType() -eq [Apps]) {
            throw("Install must be inherited from package manager")
        }
    }

    # [void] Invoke() {} # Logic to run the app.

    [bool] RemoveDotfile($Dotfile) {
        # TODO: Check if this also need a rewrite to fit the new system.
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
        $this.DotfilesSwitch([MyDotfilesAction]'remove')
        $this.AppsExit()
    }

    [void] Reset() {
        if ($this.GetType() -eq [Apps]) {
            throw("Reset must be inherited from package manager")
        }
    }

    [void] SetEnvironmentVariables([hashtable] $EnvVars) {
        $EnvVars | ForEach-Object {
            $this.Name = $_.Keys
            $this.Value = $_.Values
            $this.realEnvValue = [Environment]::GetEnvironmentVariable("$($Name).ToString()")
            # Get-Variable "$($Name).ToString()" -ValueOnly

            if (($null -eq $($this.realEnvValue)) -or ($($this.Value) -ne $($this.realEnvValue))) {
                [Environment]::SetEnvironmentVariable("$($this.Name.ToString())", $($this.Value), [EnvironmentVariableTarget]::User)
            }
        }
    } # Logic to set app env variables

    [void] ShowDocs() {
        # Logic to show app documentation
        if ([uri]$this.DocsUrl) { Start-Process "$($this.Docs)" }
        $this.AppsExit()
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
        if ($this.GetType() -eq [Apps]) {
            throw("Uninstall must be inherited from package manager")
        }
    }

    [void] Update([string] $Version) {
        if ($this.GetType() -eq [Apps]) {
            throw("Update must be inherited from package manager")
        }
    }

}
