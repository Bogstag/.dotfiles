

class Scoop : NoneApps {

    Scoop() {
        $this.Logo = @"
░█▀▀░█▀▀░█▀█░█▀█░█▀█░
░▀▀█░█░░░█░█░█░█░█▀▀░
░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░░░
"@
        $this.Name = "Scoop"
        $this.Id = "scoop"
        $this.Store = "main"
        $this.VerifyFile = "$Env:SCOOP\apps\Scoop\current\Scoop.exe"
        $this.GithubOwnerRepo = "OWNER/REPO"
        $this.RepoUrl = "https://github.com/RepoUrl" # Unset if GithubOwnerRepo is set.
        $this.DocsUrl = "https://github.com/DocsUrl" # Replace DocsUrl with your specific docs URL
        $this.ChangeLogUrl = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        $this.DotfilesSourcePath = "$PSScriptRoot"
        $this.Dotfiles = @(
            "$Env:XDG_CONFIG_HOME\Scoop\Scoop.json"
        )
        $this.CacheFolder = "$Env:XDG_CACHE_HOME\Scoop"
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
    }

    # [void] Clear() {}
    # [void] CompareDotfiles() {}
    # [void] DeployDotfile() {}
    # [void] DotfilesSwitch() {}
    # [void] Enable() {}
    # [void] GetRepoUri() {}
    # [void] Install() {}
    # [void] Invoke() {}
    # [void] RemoveDotfile() {}
    # [void] Reset() {}

    # [void] SetEnvironmentVariables() {
    #     # Logic to set app env variables
    #     $Value = "" TODO: Config
    #     if (($null -eq $Env:SCOOP_GH_TOKEN) -or ($Value -ne $Env:SCOOP_GH_TOKEN)) {
    #         [Environment]::SetEnvironmentVariable("SCOOP_GH_TOKEN", "$Value", [EnvironmentVariableTarget]::User)
    #     }


    # [void] ShowDocs() {}
    # [void] ShowLogo() {}
    # [void] ShowReleases() {}
    # [void] ShowRepo() {}
    # [void] Uninstall() {}
    # [void] Update() {}
    # [void] UpdateScoopUnmanaged() {}
    # [void] UpdateSystemState() {}
}
[AppRunner]::InitApp("Scoop")
