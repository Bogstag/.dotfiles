# using module My
# using module My/My.ScoopApps.psm1
# $ErrorActionPreference = "Stop"
# $DebugPreference = 'Stop'
class Template : ScoopApps {
    # class Template : NoneApps {
    Template() {
        $this.Logo = @"
░▀█▀░█▀▀░█▄█░█▀█░█░░░█▀█░▀█▀░█▀▀
░░█░░█▀▀░█░█░█▀▀░█░░░█▀█░░█░░█▀▀
░░▀░░▀▀▀░▀░▀░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀
"@
        $this.Name = "Template"
        $this.Id = (ConvertTo-SafePascalCase($this.GetType()))
        $this.PackageManager = "Scoop"
        $this.Store = "main"
        $this.VerifyFile = "$Env:SCOOP\apps\Template\current\Template.exe"
        $this.GithubOwnerRepo = "OWNER/REPO" # Or $this.RepoUrl = "https://github.com/" + $this.GithubOwnerRepo
        $this.DocsUrl = "https://github.com/DocsUrl"
        $this.ChangeLogUrl = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        $this.DotfilesSourcePath = "$PSScriptRoot"
        $this.Dotfiles = @(
            "$Env:XDG_CONFIG_HOME\Template\Template.json"
        )
        # $this.Version = "0.0.0"
        # $this.AppLastUpdate = $null
        $this.CacheFolder = "$Env:XDG_CACHE_HOME\Template"
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
        # Anything else? or notes?
    }

    # Methods below is disabled in parent.
    [void] Enable() {} # Logic to run in profile to import
    [void] Clear() {} # Logic to clean app's cache or other maintenance tasks.
    [void] Invoke() {} # Logic to run the app.
    # [void] SetEnvironmentVariables() {
    #     # Logic to set app env variables
    #     $Value = ""
    #     if (($null -eq $Env:app_ENV_VAR) -or ($Value -ne $Env:app_ENV_VAR)) {
    #         [Environment]::SetEnvironmentVariable("app_ENV_VAR", "$Value", [EnvironmentVariableTarget]::User)
    #     }
    # }

    # Enable if repos and docs are missing
    # [void] ShowDocs() {}
    # [string] ShowChangeLog ($uri = $null) {} # Logic to show release notes or changelog
    # [void] ShowRepo() {}
    # [void] GetRepoUri() {}

    # Enable this if app dont have any dotfiles or you need to override. Else disable if not needed.
    # [void] CompareDotfiles() {}
    # [bool] DeployDotfile($DotfileString) {
    # [void] DeployDotfiles() {}
    # [void] DotfilesSwitch([DotfilesAction]$DotfilesAction) {}
    # [void] DotfilesSwitch([DotfilesAction]$DotfilesAction, [array]$DotArray = @()) {}

    # [void] Install() {} # Logic to install app
    # [bool] RemoveDotfile($Dotfile) {}
    # [void] RemoveDotfiles() {}
    # [void] Reset() {} # Logic to reset app
    # [void] ShowLogo() {}
    # [void] Uninstall() {}
    # [void] Update([string] $Version) {}
    # [void] UpdateScoopUnmanaged() {}

}
[AppRunner]::makeApp("Template")

