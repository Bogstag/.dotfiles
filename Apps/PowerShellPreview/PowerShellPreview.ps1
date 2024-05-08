class PowerShellPreview : ScoopApps {

    PowerShellPreview() {
        $this.Logo = @"
      .+=====--===------------------:+:
      *=:::::--:..:............      =-
     -*.::::=@@%+:.::............   .*
     *-::::::=%@@%+:..........      ==
    :*:::::::..=%@@%=. .....        *
    *-::::::::...=%@@%=....        ==
   :*.::::::..... .*@@@%.          *
   *-.::::::....-*@@@@*-          -=
  :*.::::....-*%@@@#=.            +
  *-.:....-+%@@@#=.              -=
 :*.:...+%@@@#=.  +%%%%%%%%-     +.
 +-.....+%#=:     -******++:    -=
 *:::...... ....               .*.
 -------------:::::::::::::::::-.
"@
        $this.Name = "PowerShell Preview"
        $this.Id = "pwsh-beta"
        $this.MyPM = "Scoop"
        $this.Store = "versions"
        $this.VerifyFile = "$Env:SCOOP\apps\pwsh-beta\current\pwsh.exe"
        $this.GithubOwnerRepo = "PowerShell/PowerShell"
        $this.DocsUrl = "https://learn.microsoft.com/en-us/powershell/"
        $this.ChangeLogUrl = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        $this.DotfilesSourcePath = "$PSScriptRoot"
        $this.Dotfiles = @(
            "$Env:HOME\Documents\PowerShell"
        )
        # $this.AppLastUpdate = $null
        # $this.CacheFolder = "$Env:XDG_CACHE_HOME\Powershell"
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$Env:dotfiles\Apps\PowerShellPreview\PowerShellPreview.json"
        # Anything else? or notes?
    }

    # Methods below is disabled in parent.
    [void] Enable() {} # Logic to run in profile to import
    [void] Clear() {} # Logic to clean app's cache or other maintenance tasks.
    [void] Invoke() {} # Logic to run the app.
    [void] SetEnvironmentVariables() {
        # Logic to set app env variables
        $Value = "$true"
        if (($null -eq $Env:POWERSHELL_TELEMETRY_OPTOUT) -or ($Value -ne $Env:POWERSHELL_TELEMETRY_OPTOUT)) {
            [Environment]::SetEnvironmentVariable("POWERSHELL_TELEMETRY_OPTOUT", "$Value", [EnvironmentVariableTarget]::User)
        }
        $Value2 = "Off"
        if (($null -eq $Env:POWERSHELL_UPDATECHECK) -or ($Value2 -ne $Env:POWERSHELL_UPDATECHECK)) {
            [Environment]::SetEnvironmentVariable("POWERSHELL_UPDATECHECK", "$Value2", [EnvironmentVariableTarget]::User)
        }
        $Value3 = "$env:LOCALAPPDATA\Microsoft\PowerShell"
        if (($null -eq $Env:PSModuleAnalysisCachePath) -or ($Value3 -ne $Env:PSModuleAnalysisCachePath)) {
            [Environment]::SetEnvironmentVariable("PSModuleAnalysisCachePath", "$Value3", [EnvironmentVariableTarget]::User)
        }
    }

    # Enable if repos and docs are missing
    # [void] ShowDocs() {}
    # [string] ShowChangeLog ($uri = $null) {} # Logic to show release notes or changelog
    # [void] ShowRepo() {}
    # [void] GetRepoUri() {}

    # Enable this if app dont have any dotfiles or you need to override. Else disable if not needed.
    # [void] CompareDotfiles() {}
    [void] NewDeployDotfile($DotfileString) {}
    # [void] DeployDotfiles() {}
    [void] NewDotfilesSwitch($DotfilesAction) {}
    # [void] DotfilesSwitch($DotfilesAction, [array]$DotArray = @()) {}

    [void] Install() {
        $this.InstallBucket()
        $this.InstallPackage()
        $this.DotfilesSwitch('deploy')

        # TODO: Add env var
        sudo New-Item -ItemType SymbolicLink -Path 'C:\Program Files\PowerShell\7-preview' -Target $Env:SCOOP\apps\pwsh-beta\current
        New-Item -ItemType SymbolicLink -Path $Env:HOME\Documents\PowerShell -Target $Env:DOME\Documents\PowerShell
        $this.SaveAppState()
    }

    # [bool] RemoveDotfile($Dotfile) {}
    # [void] RemoveDotfiles() {}
    # [void] Reset() {} # Logic to reset app
    # [void] ShowLogo() {}
    # [void] Uninstall() {}
    # [void] Update([string] $Version) {
    #     $this.Version = $global:PSVersionTable.PSVersion
    # }
    # [void] UpdateScoopUnmanaged() {}
}
[AppRunner]::InitApp("PowerShellPreview")

# PowerShell Preview

# Install dir "$env:ProgramFiles\PowerShell\<version>"
# For preview releases, the versioned subfolder is 7-preview

# ## My paths / vars

# - `$PROFILE` is "$HOME\Documents\PowerShell"
# - `$PSHOME` is "$Env:SCOOP\apps\pwsh-beta\current" Any system-level configuration settings stored in `$PSHOME` cant be modified.
# - `$PSEdition` is "Core"
# - `$PSVersionTable.PSVersion.ToString()` is "7.5.0-preview.2"

# ## Profiles

# ```PowerShell
# $PROFILE | Select-Object *Host* | Format-List
# Output:
# AllUsersAllHosts       : "$env:ProgramFiles\PowerShell\7-preview\profile.ps1"
# AllUsersCurrentHost    : "$env:ProgramFiles\PowerShell\7-preview\Microsoft.PowerShell_profile.ps1"
# CurrentUserAllHosts    : "$HOME\Documents\PowerShell\profile.ps1"
# CurrentUserCurrentHost : "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
# ```
# ## Modules

# PowerShell modules:
# $env:ProgramFiles\PowerShell\7-preview\Modules => Scoop: $Env:SCOOP\apps\pwsh-beta\current\Modules

# Current User Modules:
# $HOME\Documents\PowerShell\Modules => Scoop: $Env:SCOOP\modules

# All Users Modules:
# $env:ProgramFiles\PowerShell\Modules

# Compability modules: %windir%\System\WindowsPowerShell\v1.0\Modules

# $Env:PSModulePath Includes all paths to Modules

# ## Config

# The powershell.config.json file contains configuration settings for PowerShell.
# More on config: [about_PowerShell_Config](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_powershell_config?view=powershell-7.5)
# powershell.config.json in $PSHOME is for AllUsers.
# powershell.config.json in $PROFILE is for that scope.

# ### Read more
# [Installing PowerShell on Windows](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.5)
# [Preference Variables](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables?view=powershell-7.5)
# [Environment variables](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7.5)
# [Powershell Config](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_powershell_config?view=powershell-7.5)
# [Logging](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_logging_windows?view=powershell-7.5)
# [Session Configurations](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_session_configurations?view=powershell-7.5)

# Most ps modules can possible be grouped into groups, scoop, PSGe, Nuget. Install, enable etc is pretty much the same.

# Install-Module -Name PowerShellGet -Force
# https://github.com/PowerShell/PSResourceGet

# Preference Variables
# $env:PSExecutionPolicyPreference
# $ConfirmPreference 	High
# $DebugPreference 	SilentlyContinue
# $ErrorActionPreference 	Continue
# $ErrorView 	ConciseView
# $FormatEnumerationLimit 	4
# $InformationPreference 	SilentlyContinue
# $LogCommandHealthEvent 	$false (not logged)
# $LogCommandLifecycleEvent 	$false (not logged)
# $LogEngineHealthEvent 	$true (logged)
# $LogEngineLifecycleEvent 	$true (logged)
# $LogProviderHealthEvent 	$true (logged)
# $LogProviderLifecycleEvent 	$true (logged)
# $MaximumHistoryCount 	4096
# $OFS 	Space character (" ")
# $OutputEncoding 	UTF8Encoding object
# $ProgressPreference 	Continue
# $PSDefaultParameterValues 	@{} (empty hash table)
# $PSEmailServer 	$null (none)
# $PSModuleAutoLoadingPreference 	All
# $PSNativeCommandArgumentPassing 	Windows on Windows, Standard on Non-Windows
# $PSNativeCommandUseErrorActionPreference 	$false
# $PSSessionApplicationName 	'wsman'
# $PSSessionConfigurationName 	'http://schemas.microsoft.com/powershell/Microsoft.PowerShell'
# $PSSessionOption 	PSSessionOption object
# $PSStyle 	PSStyle object
# $Transcript 	$null (none)
# $VerbosePreference 	SilentlyContinue
# $WarningPreference 	Continue
# $WhatIfPreference 	$false
