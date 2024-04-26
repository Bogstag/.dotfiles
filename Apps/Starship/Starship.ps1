using module DotfilesModule

# Define a class for app-specific operations
class Starship : App {
    [string] $Cache
    [string] $AppFolder
    [string] $Logo

    Starship() : base(@{
            Name         = "Starship"
            Store        = "main"
            VerifyFile   = "$Env:SCOOP\apps\starship\current\starship.exe"
            Repo         = "https://github.com/starship/starship"
            Docs         = "https://starship.rs/config/"
            ConfigFolder = "$Env:XDG_CONFIG_HOME"
            ConfigFile   = "Starship.toml"
        }) {
        $this.Cache = "$Env:XDG_CACHE_HOME\starship"
        $this.AppFolder = $PSScriptRoot
        $this.Logo = @"
             .:::::--:::::.
         .::----------------::.
      .:------------------------:.
    .:---:::------------::----:---:
   :------**----------::==:---------.
  :-----=#@@#=------::=#@@*:---------:
 :--------*+-------:=%@@@@@#:-------:-:
.---------::------:=@@#=-*@@=:---------.
:---------------:::%@@#--*@@=:---------:
--------------:-+#%@@@@@@@@#:-----------
--------------+@@@@@@@@@@@@@+:----------
:--------------=+*%@@@@@@@@@@-:--------:
.--------------:::#@@@@@@%@@@*:--------.
 :------------------=+*#=:--==--------:
  :----------------:::::----:--------:
   :----------:-#@@%#*=-------------:
    .:---:::-=*@@@@@@@=-----------:.
      .:=++#%@@@@@@@@*:---------:.
        :+#@@@@@@@@@*:-------:.
           .:=*#%@%+:--:::. "
The minimal, blazing fast,
and extremely customizable prompt!
"@
    }

    # [void] Clear() {
    #     # Logic to clean app's cache or other maintenance tasks.
    # }

    # [void] CompareDotfiles() {
    #     # Logic to compare dotfiles with reference to see if something has changed.
    # }

    [void] DeployDotfiles() {
        # Logic to get dotfiles to the right location, by copying or symlink.
        $this.AppDeployDotfiles($this.AppFolder)
    }

    # [void] Enable() {
    #     # Logic to run in profile to import, dotsource or invoke app
    #     # Import-Module "$Env:SCOOP\modules\$($this.Name)"
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

    [void] Invoke() {
        # Logic to run the app.
    }

    [void] SetEnvironmentVariables() {
        # Logic to set app env variables
        if ($null -eq $Env:STARSHIP_CONFIG) {
            [Environment]::SetEnvironmentVariable("STARSHIP_CONFIG", "$($this.ConfigFolder)\$($this.ConfigFile)", [EnvironmentVariableTarget]::User)
        }

        if ($null -eq $Env:STARSHIP_CACHE) {
            [Environment]::SetEnvironmentVariable("STARSHIP_CACHE", "$($this.Cache)", [EnvironmentVariableTarget]::User)
        }
    }

    # [void] ShowDocs() {
    #     # Logic to show app documentation
    # }

    # [void] ShowLogo() {
    #     # Logic to show Logo
    # }

    # [void] ShowReleases() {
    #     # Logic to show release notes or changelog
    # }

    # [void] ShowRepo() {
    #     # Logic to show app repository
    # }

    # [void] Reset() {
    #     # Logic to reset app
    # }

    [void] Uninstall() {

        scoop uninstall "$($this.Store)/$($this.Name)"

        if ($null -ne $Env:STARSHIP_CONFIG) {
            [Environment]::SetEnvironmentVariable("STARSHIP_CONFIG", $null, [EnvironmentVariableTarget]::User)
        }

        if ($null -ne $Env:STARSHIP_CACHE) {
            [Environment]::SetEnvironmentVariable("STARSHIP_CACHE", $null, [EnvironmentVariableTarget]::User)
        }
    }

    # [void] Update() {
    #     scoop update "$($this.Store)/$($this.Name)"
    #     'install-context', 'uninstall-context', 'install-file-associations', 'uninstall-file-associations' | ForEach-Object {
    #         $reg_file_in = "$Env:SCOOP\buckets\$($this.Store)\scripts\git\$_.reg"
    #         $reg_file_out = "$dir\$_.reg"
    #         $git_root = "$dir".Replace('\', '\\')
    #         if (Test-Path $reg_file_in) {
    #             $content = Get-Content $reg_file_in
    #             $content = $content.Replace('$git_root', $git_root)
    #             if ($global) {
    #                 $content = $content.Replace('HKEY_CURRENT_USER', 'HKEY_LOCAL_MACHINE')
    #             }
    #             Set-Content -Path $reg_file_out -Value $content -Encoding Ascii
    #         }
    #     }
    # }

    # [void] UpdateSystemState([SystemState] $systemState) {
    # }
}
