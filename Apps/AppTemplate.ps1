using module DotfilesModule

class Template : App {

    Template() : base(@{
            Logo            = @"
░▀█▀░█▀▀░█▄█░█▀█░█░░░█▀█░▀█▀░█▀▀
░░█░░█▀▀░█░█░█▀▀░█░░░█▀█░░█░░█▀▀
░░▀░░▀▀▀░▀░▀░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀
"@
            Name            = "Template" # CTRL+H Template with your specific app name, same as folder name
            Store           = "main"
            VerifyFile      = "$Env:SCOOP\apps\Template\current\Template.exe"
            GithubOwnerRepo = "OWNER/REPO"
            Repo            = "https://github.com/RepoUrl" # Unset if GithubOwnerRepo is set.
            Docs            = "https://github.com/DocsUrl" # Replace DocsUrl with your specific docs URL
            DotfilesFolder  = [IO.DirectoryInfo]::new("$Env:XDG_CONFIG_HOME\Template")
            Dotfiles        = @(
                [IO.FileInfo]::new("$Env:XDG_CONFIG_HOME\Template\Template.json")
            )
            CacheFolder     = [IO.DirectoryInfo]::new("$Env:XDG_CACHE_HOME\Template")
            AppFolder       = [IO.DirectoryInfo]::new("$PSScriptRoot")
        }) {
    }

    # [void] Clear() {}

    # [void] DeployDotfiles() {}

    # [void] Enable() {}

    # [uri] GetRepoUri([string]$Switch) {}

    # [void] Install() {}

    # [void] Invoke() {}

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

    [void] UpdateSystemState([SystemState] $systemState) {
        $systemState.UpdateAppData($this.Name, $this)
    }

    # [void] UpdateSystemState([SystemState] $systemState) {}
}
