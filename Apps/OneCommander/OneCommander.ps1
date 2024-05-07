

class OneCommander : ScoopApps {

    OneCommander() {
        $this.Logo = @"
░█▀█░█▀█░█▀▀░█▀▀░█▀█░█▄█░█▄█░█▀█░█▀█░█▀▄░█▀▀░█▀▄
░█░█░█░█░█▀▀░█░░░█░█░█░█░█░█░█▀█░█░█░█░█░█▀▀░█▀▄
░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░▀░▀░▀░▀▀░░▀▀▀░▀░▀
A modern dual-pane file manager.
"@
        $this.Name = "OneCommander"
        $this.Id = "onecommander"
        $this.MyPM = "Scoop"
        $this.Store = "extras"
        $this.VerifyFile = "$Env:SCOOP\apps\OneCommander\current\OneCommander.exe"
        $this.DocsUrl = "https://onecommander.com/help" # Replace DocsUrl with your specific docs URL
        $this.ChangeLogUrl = "https://onecommander.com/releasenotes.txt"
        $this.DotfilesSourcePath = "$PSScriptRoot"
        $this.Dotfiles = @( # Dotfile source must exist
            "$Env:SCOOP/persist/onecommander/Resources/Scripts",
            "$Env:SCOOP/persist/onecommander/Resources/FileDesigns"
            "$Env:SCOOP/persist/onecommander/Settings/OneCommanderV3.json"
            "$Env:SCOOP/persist/onecommander/Settings/ScriptExecutors.json"
            "$Env:SCOOP/persist/onecommander/Templates"
        )
        # $this.Version = "0.0.0"
        # $this.AppLastUpdate = $null
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
    }

    # [void] Clear() {}
    # [void] Enable() {}
    # [uri] GetRepoUri([string]$Switch) {}
    # [void] Install() {}
    # [void] Invoke() {}
    # [void] Reset() {}

    # [void] SetEnvironmentVariables() {
    #     # Logic to set app env variables
    #     $Value = ""
    #     if (($null -eq $Env:app_ENV_VAR) -or ($Value -ne $Env:app_ENV_VAR)) {
    #         [Environment]::SetEnvironmentVariable("app_ENV_VAR", "$Value", [EnvironmentVariableTarget]::User)
    #     }
    # }

    # [void] ShowDocs() {}
    # [void] ShowLogo() {}
    # [void] ShowReleases() {}
    # [void] ShowRepo() {}
    # [void] Uninstall() {}
    # [void] Update() {}
    # [void] UpdateSystemState() {}
}
[AppRunner]::InitApp("OneCommander")
