using module My

# Also including pre-commit
class Gitleaks : MyScoopApps {

    Gitleaks() : base(@{
            Logo               = @"
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
            Name               = "Gitleaks" # CTRL+H Gitleaks with your specific app name, same as folder name
            Store              = "main"
            VerifyFile         = "$Env:SCOOP\apps\Gitleaks\current\Gitleaks.exe"
            GithubOwnerRepo    = "gitleaks/gitleaks"
            Docs               = "https://github.com/gitleaks/gitleaks#configuration" # Replace DocsUrl with your specific docs URL
            DotfilesSourcePath = "$PSScriptRoot"
            Dotfiles           = @(
                "$Env:dotfiles\.pre-commit-config.yaml"
            )
            CacheFolder        = "$Env:XDG_CACHE_HOME\Gitleaks"
            AppFolder          = "$PSScriptRoot"
        }) {
    }

    # [void] Clear() {}

    # [void] Enable() {}

    # [uri] GetRepoUri([string]$Switch) {}

    [void] Install() {
        # Logic to install app
        # https://pre-commit.com/#install
        python -m pip install pre-commit

        # Update after install
        pre-commit autoupdate

        # Copy config to profile, This have no real purpose other then easy access to a starter config.
        $this.DotfilesSwitch('deploy')

        # Add gitleaks to git pre-commit
        pre-commit install

        # $this.SetEnvironmentVariables()
    }

    # [void] Invoke() {}



    # [void] Reset() {}

    [void] SetEnvironmentVariables() {
        # Logic to set app env variables
        # if (($null -eq $Env:GITLEAKS_CONFIG) -or ($this.DotfilesSourcePath -ne $Env:GITLEAKS_CONFIG)) {
        #     [Environment]::SetEnvironmentVariable("GITLEAKS_CONFIG", "$($this.DotfilesSourcePath)", [EnvironmentVariableTarget]::User)
        # }
    }

    # [void] ShowDocs() {}

    # [void] ShowLogo() {}

    # [void] ShowReleases() {}

    # [void] ShowRepo() {}

    # [void] Uninstall() {}

    # [void] Update() {}

    # [void] UpdateSystemState() {
    #     [MySystemState].UpdateAppData($this.GetType(), $this)
    # }
}
