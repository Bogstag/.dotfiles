$AppFolder = $PSScriptRoot
$AppId = Split-Path $AppFolder -Leaf

[AppRunner]::Apps."$AppId" = [ScoopApps]::new([ordered]@{
        # Apps
        Logo            = @"
SAST tool for detecting and preventing
hardcoded secrets like passwords,
api keys, and tokens in git repos.
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@%#####* % ##############@@@@@@@@
@@@@@@@@ #@@@@%#%@%@@@@@@@@@@@@ @@@@@@@@
@@@@@@@@ %@@@@@@ @ %@@@@@@@@@@@ @@@@@@@@
@@@@@@@@ %@@@@@% @@ #@@@@@@@@@@ @@@@@@@@
@@@@@@@@ %@@@@@@ @@@ #@@@@@@@@@ @@@@@@@@
@@@@@@@@ %@@@@@@ @@@@ @@@@@@@@@ @@@@@@@@
@@@@@@@@ %@@@@@@ @@@@@@%%@@@@@@ @@@@@@@@
@@@@@@@@ %@@@@@@ @@@@@ %% @@@@@ @@@@@@@@
@@@@@@@@ %@@@@@@ @@@@@ %% @@@@@ @@@@@@@@
@@@@@@@@ %@@@@@@%@@@@@@@@@@@@@@ @@@@@@@@
@@@@@@@@ %@@@@ %% %@@|####|@@@@ @@@@@@@@
@@@@@@@@ %@@@@ %% @@@|####|@@@@ @@@@@@@@
@@@@@@@@ %@@@@@@@@@@@|####|@@@@ @@@@@@@@
@@@@@@@@ %@@@|####|%%|####|%%@% @@@@@@@@
@@@@@@@@_____|####|_____________@@@@@@@@
@@@@@@@@@@@@@|####|@@@@@@@@@@@@@@@@@@@@@
             |####|
"@
        # Also including pre-commit
        Name            = "Gitleaks" # CTRL+H Gitleaks with your specific app name, same as folder name
        AppId           = $AppId
        AppFolder       = $AppFolder
        AppStateJson    = "$AppFolder\$AppId.json"
        VerifyFile      = "$Env:SCOOP\apps\Gitleaks\current\Gitleaks.exe"
        GithubOwnerRepo = "gitleaks/gitleaks"
        DocsUrl         = "https://github.com/gitleaks/gitleaks#configuration" # Replace DocsUrl with your specific docs URL
        ChangeLogUrl    = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        Dotfiles        = @(
            "$Env:HOME\.dotfiles\.pre-commit-config.yaml"
        )
        # EnvVars         = @{ "ENV_Name" = "$Env:SCOOP\ENV_VALUE" }
        CacheFolder     = "$Env:XDG_CACHE_HOME\Gitleaks"

        # PacketManager
        ScoopId         = $AppId # Scoop name
        Store           = "main" # AKA Buckets

        AppInstall      = {
            # Logic to install app
            # https://pre-commit.com/#install
            python -m pip install pre-commit

            # Update after install
            pre-commit autoupdate

            # Copy config to profile, This have no real purpose other then easy access to a starter config.
            $this.DotfilesSwitch('deploy')

            # Add gitleaks to git pre-commit
            pre-commit install
        }


    }
)
Remove-Variable -Name @("AppFolder", "AppId")


