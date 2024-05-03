using module My

class Template : ScoopApps {
    # class Template : NoneApps {

    Template() : base([ordered]@{
            Logo               = @"
░▀█▀░█▀▀░█▄█░█▀█░█░░░█▀█░▀█▀░█▀▀
░░█░░█▀▀░█░█░█▀▀░█░░░█▀█░░█░░█▀▀
░░▀░░▀▀▀░▀░▀░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀
"@
            Name               = "Template"
            Id                 = (Convert-ToPascalCase($this.Name)) # Package Manager or Safe Name
            PackageManager     = "Scoop" # Remove if NoneApps
            Store              = "main" # Remove if NoneApps
            VerifyFile         = "$Env:SCOOP\apps\Template\current\Template.exe"
            GithubOwnerRepo    = "OWNER/REPO"
            RepoUrl            = "https://github.com/" + $this.GithubOwnerRepo # Unset if GithubOwnerRepo is set.
            DocsUrl            = "https://github.com/DocsUrl"
            ChangeLogUrl       = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
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

    # [void] Enable() {}
    # [void] Invoke() {}

    # [void] SetEnvironmentVariables() {
    #     # Logic to set app env variables
    #     $Value = ""
    #     if (($null -eq $Env:app_ENV_VAR) -or ($Value -ne $Env:app_ENV_VAR)) {
    #         [Environment]::SetEnvironmentVariable("app_ENV_VAR", "$Value", [EnvironmentVariableTarget]::User)
    #     }
    # }

}
