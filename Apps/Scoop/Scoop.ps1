using module My

class Scoop : ScoopApps {

    Scoop() : base(@{
            Logo               = @"
# ░█▀▀░█▀▀░█▀█░█▀█░█▀█░
# ░▀▀█░█░░░█░█░█░█░█▀▀░
# ░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░░░
"@
            Name               = "Scoop" # CTRL+H Scoop with your specific app name, same as folder name
            Store              = "main"
            VerifyFile         = "$Env:SCOOP\apps\Scoop\current\Scoop.exe"
            GithubOwnerRepo    = "OWNER/REPO"
            RepoUrl            = "https://github.com/RepoUrl" # Unset if GithubOwnerRepo is set.
            DocsUrl            = "https://github.com/DocsUrl" # Replace DocsUrl with your specific docs URL
            DotfilesSourcePath = "$PSScriptRoot"
            Dotfiles           = @(
                "$Env:XDG_CONFIG_HOME\Scoop\Scoop.json"
            )
            CacheFolder        = "$Env:XDG_CACHE_HOME\Scoop"
            AppFolder          = "$PSScriptRoot"
        }) {
        # [IO.DirectoryInfo]::new("$this.CacheFolder")
        # [IO.FileInfo]::new("$this.Dotfiles[0]")
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

