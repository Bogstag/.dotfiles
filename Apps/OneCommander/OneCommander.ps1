using module My

class OneCommander : MyScoopApps {

    OneCommander() : base(@{
            Logo               = @"
░█▀█░█▀█░█▀▀░█▀▀░█▀█░█▄█░█▄█░█▀█░█▀█░█▀▄░█▀▀░█▀▄
░█░█░█░█░█▀▀░█░░░█░█░█░█░█░█░█▀█░█░█░█░█░█▀▀░█▀▄
░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░▀░▀░▀░▀▀░░▀▀▀░▀░▀
A modern dual-pane file manager.
"@
            Name               = "OneCommander"
            Store              = "extras"
            VerifyFile         = "$Env:SCOOP\apps\OneCommander\current\OneCommander.exe"
            Repo               = "https://onecommander.com/releasenotes.txt" # Unset if GithubOwnerRepo is set.
            Docs               = "https://onecommander.com/help" # Replace DocsUrl with your specific docs URL
            DotfilesSourcePath = "$PSScriptRoot"
            Dotfiles           = @( # Dotfile source must exist
                "$Env:SCOOP/persist/onecommander/Resources/Scripts",
                "$Env:SCOOP/persist/onecommander/Resources/FileDesigns"
                "$Env:SCOOP/persist/onecommander/Settings/OneCommanderV3.json"
                "$Env:SCOOP/persist/onecommander/Settings/ScriptExecutors.json"
                "$Env:SCOOP/persist/onecommander/Templates"
            )
            AppFolder          = "$PSScriptRoot"
        }) {
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
