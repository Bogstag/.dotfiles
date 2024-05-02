using module My

class Starship : MyScoopApps {

    Starship() : base(@{
            Logo               = @"
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
            Name               = "Starship"
            Store              = "main"
            VerifyFile         = "$Env:SCOOP\apps\starship\current\starship.exe"
            GithubOwnerRepo    = "starship/starship"
            Docs               = "https://starship.rs/config/"
            DotfilesSourcePath = "$PSScriptRoot"
            Dotfiles           = @(
                "$Env:XDG_CONFIG_HOME\Starship.toml"
            )
            CacheFolder        = "$Env:XDG_CACHE_HOME\starship"
            AppFolder          = "$PSScriptRoot"
        }) {
    }

    # [void] Clear() {}

    # [void] Enable() {}

    # [uri] GetRepoUri([string]$Switch) {}

    # [void] Install() {}

    # [void] Invoke() {}



    # [void] Reset() {}

    [void] SetEnvironmentVariables() {
        # Logic to set app env variables
        $Value1 = "$($this.Dotfiles.FullName)"
        if (($null -eq $Env:STARSHIP_CONFIG) -or ($Value1 -ne $Env:STARSHIP_CONFIG)) {
            [Environment]::SetEnvironmentVariable("STARSHIP_CONFIG", "$Value1", [EnvironmentVariableTarget]::User)
        }

        $Value2 = "$($this.CacheFolder)"
        if (($null -eq $Env:STARSHIP_CACHE) -or ($Value2 -ne $Env:STARSHIP_CACHE)) {
            [Environment]::SetEnvironmentVariable("STARSHIP_CACHE", "$Value2", [EnvironmentVariableTarget]::User)
        }
    }

    # [void] ShowDocs() {}

    # [void] ShowLogo() {}

    # [void] ShowReleases() {}

    # [void] ShowRepo() {}

    # [void] Uninstall() {}

    # [void] Update() {}

    [void] UpdateSystemState() {
        [MySystemState].UpdateAppData($this.GetType(), $this)
    }
}
