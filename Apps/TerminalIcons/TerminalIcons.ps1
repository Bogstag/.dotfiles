using module My

class TerminalIcons : MyScoopApps {

    TerminalIcons() : base(@{
            Logo            = @"
░▀█▀░█▀▀░█▀▄░█▄█░▀█▀░█▀█░█▀█░█░░░░░░░▀█▀░█▀▀░█▀█░█▀█░█▀▀
░░█░░█▀▀░█▀▄░█░█░░█░░█░█░█▀█░█░░░▄▄▄░░█░░█░░░█░█░█░█░▀▀█
░░▀░░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░░░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
"@

            Name            = "Terminal-Icons"
            Store           = "extras"
            VerifyFile      = "$Env:SCOOP\modules\Terminal-Icons\Terminal-Icons.psd1"
            GithubOwnerRepo = "devblackops/Terminal-Icons"
            Docs            = "https://github.com/devblackops/Terminal-Icons"
            AppFolder       = "$PSScriptRoot"
        }) {
    }

    # [void] Clear() {}

    [void] Enable() {
        Import-Module "$Env:SCOOP\modules\Terminal-Icons"
    }

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

    [void] UpdateSystemState() {
        [MySystemState].UpdateAppData($this.GetType(), $this)
    }
}
