class AdvancedRenamer : ScoopApps {

    AdvancedRenamer() {
        $this.Logo = @"
░█▀█░█▀▄░█░█░█▀█░█▀█░█▀▀░█▀▀░█▀▄░░░█▀▄░█▀▀░█▀█░█▀█░█▄█░█▀▀░█▀▄
░█▀█░█░█░▀▄▀░█▀█░█░█░█░░░█▀▀░█░█░░░█▀▄░█▀▀░█░█░█▀█░█░█░█▀▀░█▀▄
░▀░▀░▀▀░░░▀░░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀░░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀░▀░▀▀▀░▀░▀
Batch file renaming utility for Windows
"@
        $this.Name = "Advanced Renamer"
        $this.Id = "advancedrenamer"
        $this.MyPM = "Scoop"
        $this.Store = "extras"
        $this.VerifyFile = "$Env:SCOOP\apps\AdvancedRenamer\current\arenc.exe"
        # $this.GithubOwnerRepo = "OWNER/REPO" # Or $this.RepoUrl = "https://github.com/" + $this.GithubOwnerRepo
        # $this.RepoUrl = $null
        $this.DocsUrl = "https://www.advancedrenamer.com/user_guide/complete_guide"
        $this.ChangeLogUrl = "https://www.advancedrenamer.com/versionlog"
        # $this.DotfilesSourcePath = "$PSScriptRoot"
        # $this.Dotfiles = @()
        # $this.Version = "0.0.0"
        # $this.AppLastUpdate = $null
        # $this.CacheFolder = "$($this.AppFolder)\$($this.GetType()).json"
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
        # $Env:SCOOP\persist\advancedrenamer TODO: see if there is sonething here i care about.
    }

    # [void] Clear() {}
    [void] CompareDotfiles() {}
    [void] DeployDotfile() {}
    [void] DotfilesSwitch() {}
    # [void] Enable() {}
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
    # [void] UpdateSystemState() {}
}
[AppRunner]::InitApp("advancedrenamer")
