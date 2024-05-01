using module DotfilesModule

class Template : App {

    Template() : base(@{
            Logo               = @"
░▀█▀░█▀▀░█▄█░█▀█░█░░░█▀█░▀█▀░█▀▀
░░█░░█▀▀░█░█░█▀▀░█░░░█▀█░░█░░█▀▀
░░▀░░▀▀▀░▀░▀░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀
"@
            Name               = "Template" # CTRL+H Template with your specific app name, same as folder name
            Store              = "main"
            VerifyFile         = "$Env:SCOOP\apps\Template\current\Template.exe"
            GithubOwnerRepo    = "OWNER/REPO"
            Repo               = "https://github.com/RepoUrl" # Unset if GithubOwnerRepo is set.
            Docs               = "https://github.com/DocsUrl" # Replace DocsUrl with your specific docs URL
            DotfilesSourcePath = "$PSScriptRoot"
            Dotfiles           = @(
                "$Env:XDG_CONFIG_HOME\Template\Template.json"
            )
            CacheFolder        = "$Env:XDG_CACHE_HOME\Template"
            AppFolder          = "$PSScriptRoot"
        }) {
        # [IO.DirectoryInfo]::new("$this.CacheFolder")
        # [IO.FileInfo]::new("$this.Dotfiles[0]")
    }

    # [void] Clear() {}
    # [void] CompareDotfiles() {}
    # [void] DeployDotfile() {}
    # [void] DeployDotfiles() {}
    # [void] DotfilesSwitch() {}
    # [void] Enable() {}
    # [void] GetRepoUri() {}
    # [void] Install() {}
    # [void] Invoke() {}
    # [void] RemoveDotfile() {}
    # [void] RemoveDotfiles() {}
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
    # [void] UpdateSystemState() {}
}
