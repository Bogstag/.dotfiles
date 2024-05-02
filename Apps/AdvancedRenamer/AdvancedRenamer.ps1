using module My

class AdvancedRenamer : MyScoopApps {

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
            Repo           = "https://www.advancedrenamer.com/versionlog" # Unset if GithubOwnerRepo is set.
            Docs           = "https://www.advancedrenamer.com/user_guide/complete_guide" # Replace DocsUrl with your specific docs URL
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
