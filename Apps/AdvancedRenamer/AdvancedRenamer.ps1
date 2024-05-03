using module My

class AdvancedRenamer : ScoopApps {

    AdvancedRenamer() : base(@{
            Logo           = @"
░█▀█░█▀▄░█░█░█▀█░█▀█░█▀▀░█▀▀░█▀▄░░░█▀▄░█▀▀░█▀█░█▀█░█▄█░█▀▀░█▀▄
░█▀█░█░█░▀▄▀░█▀█░█░█░█░░░█▀▀░█░█░░░█▀▄░█▀▀░█░█░█▀█░█░█░█▀▀░█▀▄
░▀░▀░▀▀░░░▀░░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀░░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀░▀░▀▀▀░▀░▀
Batch file renaming utility for Windows
"@
            Name           = "AdvancedRenamer" # CTRL+H AdvancedRenamer with your specific app name, same as folder name
            PackageManager = "Scoop"
            Store          = "extras"
            VerifyFile     = "$Env:SCOOP\apps\AdvancedRenamer\current\arenc.exe"
            RepoUrl        = $null # Unset if GithubOwnerRepo is set.
            DocsUrl        = "https://www.advancedrenamer.com/user_guide/complete_guide" # Replace DocsUrl with your specific docs URL
            ChangeLogUrl   = "https://www.advancedrenamer.com/versionlog"
            AppFolder      = "$PSScriptRoot"
        }) {
        # $Env:SCOOP\persist\advancedrenamer TODO: see if there is sonething here i care about.
    }

    # [void] Clear() {}
    [void] CompareDotfiles() {}
    [void] DeployDotfile() {}
    [void] DotfilesSwitch() {}
    [void] Enable() {}
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
