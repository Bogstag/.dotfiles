using module ./DotfilesModule.SystemState.psm1
class App {
    [string] $Name
    [string] $Store # Stores in Scoop
    [string] $VerifyFile # File that exist if installed, recommended is exe file.
    [string] $Repo # URL to Repo
    [string] $Docs # URL to Docs
    [string] $ConfigFolder
    [string] $ConfigFile
    [string] $Version = "0.0.0"
    [string] $AppLastUpdate = '1900-01-01'

    # App() {
    #     $this.Init(@{})
    # }

    App([hashtable]$Properties) {
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

    # [void] CompareDotfiles() {
    #     # Logic to compare dotfiles with reference to see if something has changed.
    # }

    [void] AppDeployDotfiles([string] $AppFolder) {
        # TODO: Change this to handle multiple files, see Git
        if (-Not (Test-Path $($this.ConfigFolder) -PathType Container)) {
            New-Item -Path $($this.ConfigFolder) -ItemType "Directory"
        } else {
            # If there is a .old file there, remove them.
            # If there are existing file there, rename it to .old
            Remove-Item -Path "$($this.ConfigFolder)\$($this.ConfigFile).old" -Force -ErrorAction SilentlyContinue
            Rename-Item -Path "$($this.ConfigFolder)\$($this.ConfigFile)" -NewName "$($this.ConfigFile).old" -Force -ErrorAction SilentlyContinue
        }

        New-Item -ItemType SymbolicLink -Path "$($this.ConfigFolder)\$($this.ConfigFile)" -Target "$($AppFolder)\$($this.ConfigFile)"
    }

    # [void] Enable() {
    #     # Logic to run in profile to import, dotsource or invoke app
    # }

    [void] Install() {
        # Logic to install app
        if (-Not (Test-Path "$Env:SCOOP\buckets\$($this.Store)" -PathType Container)) {
            scoop Store add -Name "$($this.Store)"
        }
        if (-Not (Test-Path $this.VerifyFile -PathType Leaf)) {
            scoop install "$($this.Store)/$($this.Name)"
        }
    }

    # [void] Invoke() {
    #     # Logic to run the app.
    # }

    [void] SetEnvironmentVariables() {
        if ($null -eq $Env:BIOME_BINARY) {
            [Environment]::SetEnvironmentVariable("BIOME_BINARY", $($this.VerifyFile), [EnvironmentVariableTarget]::User)
        }

        if ($null -eq $Env:BIOME_CONFIG_PATH) {
            [Environment]::SetEnvironmentVariable("BIOME_CONFIG_PATH", "$Env:XDG_CONFIG_HOME\biome\biome.json", [EnvironmentVariableTarget]::User)
        }
    }

    [void] ShowDocs() {
        # Logic to show app documentation
        Start-Process "$($this.Docs)"
    }

    [void] ShowLogo() {
        # Set Logo first in file for a nice experience
        # -ForegroundColor Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White
        # -BackgroundColor Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White
        $windowWidth = $Script:windowWidth

        # Determine the maximum width of any line in the logo
        $maxWidth = ($this.Logo -split "`n" | Measure-Object -Property Length -Maximum).Maximum

        # Calculate the left padding based on the window width
        $space = " " * (($windowWidth - $maxWidth) / 2)

        # Split logo into lines and write each one with proper alignment
        $this.Logo -split "`n" | ForEach-Object {
            Write-Host $space$_ -ForegroundColor Blue
        }
    }

    [void] ShowReleases() {
        # Logic to show release notes or changelog
        Start-Process "$($this.Repo)/releases"
    }

    [void] ShowRepo() {
        # Logic to show app repository
        Start-Process "$($this.Repo)"
    }

    [void] Reset() {
        # Logic to reset app
        scoop reset "$($this.Store)/$($this.Name)"
    }

    [void] Uninstall() {
        scoop uninstall "$($this.Store)/$($this.Name)"
    }

    [void] Update([string] $Version) {
        # Logic to update app
        scoop update "$($this.Store)/$($this.Name)"
        $this.Version = $Version
        $this.AppLastUpdate = [DateTime]::Now.ToString("yyyy-MM-dd")
        $this.UpdateSystemState()
    }

    [void] UpdateSystemState([SystemState] $SystemState) {
        $SystemState.UpdateAppData($this.Name, $this)
    }
}
