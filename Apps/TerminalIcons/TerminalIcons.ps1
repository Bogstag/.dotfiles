# using module My
# using module My/My.ScoopApps.psm1

class TerminalIcons : ScoopApps {

    TerminalIcons() {
        $this.Logo = @"
░▀█▀░█▀▀░█▀▄░█▄█░▀█▀░█▀█░█▀█░█░░░░░░░▀█▀░█▀▀░█▀█░█▀█░█▀▀
░░█░░█▀▀░█▀▄░█░█░░█░░█░█░█▀█░█░░░▄▄▄░░█░░█░░░█░█░█░█░▀▀█
░░▀░░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░░░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
"@
        $this.Name = "Terminal-Icons"
        $this.Id = "TerminalIcons"
        $this.PackageManager = "Scoop"
        $this.Store = "extras"
        $this.VerifyFile = "$Env:SCOOP\modules\Terminal-Icons\Terminal-Icons.psd1"
        $this.GithubOwnerRepo = "devblackops/Terminal-Icons"
        $this.DocsUrl = "https://github.com/devblackops/Terminal-Icons"
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
    }

    # [void] Clear() {}
    [void] CompareDotfiles() {}
    [void] DeployDotfile() {}
    [void] DotfilesSwitch() {}
    [void] Enable() {
        Import-Module "$Env:SCOOP\modules\Terminal-Icons"
    }
    # [void] GetRepoUri() {}
    # [void] Install() {}
    # [void] Invoke() {}
    [void] RemoveDotfile() {}
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
    # [void] UpdateScoopUnmanaged() {}

    [void] UpdateSystemState() {
        [GenericState].UpdateAppData($this.GetType(), $this)
    }
}
[AppRunner]::makeApp("TerminalIcons")
