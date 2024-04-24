# Define module-wide variable
$Script:SystemStateJsonFile = "$Env:dotfiles\SystemState-$Env:COMPUTERNAME.json"
$Script:windowWidth = $host.ui.RawUI.WindowSize.Width

# . $PSScriptRoot/Classes/SystemState.ps1
class SystemState {
    [string] $SystemStateJsonFile
    [Hashtable] $AppData = @{}
    [string] $LastProfileRunDate = '1900-01-01'

    SystemState([string] $SystemStateJsonFile) {
        $this.SystemStateJsonFile = $SystemStateJsonFile

        if (Test-Path $this.SystemStateJsonFile) {
            try {
                $jsonData = Get-Content -Path $this.SystemStateJsonFile | ConvertFrom-Json
                $this.AppData = New-Object System.Collections.Hashtable
                foreach ($key in $jsonData.AppData.PSObject.Properties.Name) {
                    $this.AppData[$key] = $jsonData.AppData.$key
                }
                $this.LastProfileRunDate = $jsonData.LastProfileRunDate
            } catch {
                Write-Warning "Failed to parse the system state JSON file. ($($this.SystemStateJsonFile))"
                Write-Warning "Error: $_"
                $this.InitializeDefaults()
            }
        } else {
            Write-Warning "System state JSON file does not exist. Initializing with default values."
            $this.InitializeDefaults()
        }
    }

    [void] InitializeDefaults() {
        $this.AppData = @{}
        $this.LastProfileRunDate = '1900-01-01'
    }

    [void] SaveState() {
        $json = $this | ConvertTo-Json -Depth 5
        Set-Content -Path $this.SystemStateJsonFile -Value $json
    }

    [void] UpdateAppData([string] $appName, [object] $appInstance) {
        $data = @{}
        if ($null -eq $appInstance) {
            $this.AppData[$appName] = $data
        } else {
            # Iterate over all properties of the app instance except 'Logo'
            $appInstance.GetType().GetProperties() | ForEach-Object {
                # Check if the property name is 'Logo', skip it if true
                if ($_.Name -ne 'Logo') {
                    $data[$_.Name] = $_.GetValue($appInstance)
                }
            }

            if ($null -eq $this.AppData) {
                $this.AppData[$appName] = @{}
            }

            $this.AppData[$appName] = $data
        }
    }


    [bool] HasRunToday() {
        if ($this.LastProfileRunDate -and ([DateTime]::Parse($this.LastProfileRunDate).Date -eq [DateTime]::Now.Date)) {
            return $true
        } else {
            return $false
        }
    }

    [void] UpdateLastRunDate() {
        $this.LastProfileRunDate = [DateTime]::Now.ToString("yyyy-MM-dd")
    }
}

# . $PSScriptRoot/Classes/App.ps1
class App {
    [string] $Name
    [string] $Store
    [string] $VerifyFile
    [string] $Repo
    [string] $Docs
    [string] $ConfigFolder
    [string] $ConfigFile

    App([string] $Name,
        [string] $Store,
        [string] $VerifyFile,
        [string] $Repo,
        [string] $Docs,
        [string] $ConfigFolder,
        [string] $ConfigFile) {
        $this.Name = $Name
        $this.Store = $Store # Buckets in Scoop
        $this.VerifyFile = $VerifyFile # File that exist if installed, recommended is exe file.
        $this.Repo = $Repo # URL to Repo
        $this.Docs = $Docs # URL to Docs
        $this.ConfigFolder = $ConfigFolder
        $this.ConfigFile = $ConfigFile
    }

    # [void] Clear() {
    #     # Logic to clean app's cache or other maintenance tasks.
    # }

    # [void] CompareDotfiles() {
    #     # Logic to compare dotfiles with reference to see if something has changed.
    # }

    [void] DeployDotfiles() {
        # $HOME\.config\biome\biome.json
        if (-Not (Test-Path $($this.ConfigFolder) -PathType Container)) {
            New-Item -Path $($this.ConfigFolder) -ItemType "Directory"
        } else {
            # If there is a .old file there, remove them.
            # If there are existing file there, rename it to .old
            Remove-Item -Path "$($this.ConfigFolder)\$($this.ConfigFile).old" -Force -ErrorAction SilentlyContinue
            Rename-Item -Path "$($this.ConfigFolder)\$($this.ConfigFile)" -NewName "$($this.ConfigFile).old" -Force -ErrorAction SilentlyContinue
        }

        New-Item -ItemType SymbolicLink -Path $($this.ConfigFolder)\$($this.ConfigFile) -Target $PSScriptRoot\$($this.ConfigFile)
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
        scoop reset "$($this.Bucket)/$($this.Name)"
    }

    [void] Uninstall() {
        scoop uninstall "$($this.Bucket)/$($this.Name)"
    }

    [void] Update() {
        # Logic to update app
        scoop update "$($this.Bucket)/$($this.Name)"
    }

    [void] UpdateSystemState([SystemState] $SystemState) {
        $SystemState.UpdateAppData($this.Name, $this)
    }
}


# . $PSScriptRoot/Classes/Biome.ps1

# Get-ChildItem -Path "$PSScriptRoot/Apps/*.ps1" | ForEach-Object {
#     . $_.FullName
# }

# Get-ChildItem -Path "$PSScriptRoot/Classes/*.ps1" | ForEach-Object {
#     . $_.FullName
# }

Get-ChildItem -Path "$PSScriptRoot/Functions/*.ps1" | ForEach-Object {
    . $_.FullName
}

Get-ChildItem -Path "$PSScriptRoot/Public/*.ps1" | ForEach-Object {
    . $_.FullName
}



Export-ModuleMember -Cmdlet * -Function * -Alias * -Variable *
