# using module My
# using module My/My.ScoopApps.psm1

class Starship : ScoopApps {

    Starship() {
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
        $this.Name = "Starship"
        $this.Id = "Starship"
        $this.PackageManager = "Scoop"
        $this.Store = "main"
        $this.VerifyFile = "$Env:SCOOP\apps\starship\current\starship.exe"
        $this.GithubOwnerRepo = "starship/starship"
        $this.DocsUrl = "https://starship.rs/config/"
        $this.DotfilesSourcePath = "$PSScriptRoot"
        $this.Dotfiles = @(
            "$Env:XDG_CONFIG_HOME\Starship.toml"
        )
        $this.CacheFolder = "$Env:XDG_CACHE_HOME\starship"
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
    }

    # [void] Clear() {}
    [void] CompareDotfiles() {}
    [void] DeployDotfile() {}
    [void] DotfilesSwitch() {}
    [void] Enable() {}
    # [void] GetRepoUri() {}
    # [void] Install() {}
    # [void] Invoke() {}
    [void] RemoveDotfile() {}
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
        [GenericState].UpdateAppData($this.GetType(), $this)
    }
}
[AppRunner]::makeApp("Starship")
