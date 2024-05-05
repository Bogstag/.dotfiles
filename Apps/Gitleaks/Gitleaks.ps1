# using module My
# using module My/My.ScoopApps.psm1

# Also including pre-commit
class Gitleaks : ScoopApps {

    Gitleaks() {
        $this.Logo = @"
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
        $this.Name = "Gitleaks" # CTRL+H Gitleaks with your specific app name, same as folder name
        $this.Id = "Gitleaks"
        $this.PackageManager = "Scoop"
        $this.Store = "main"
        $this.VerifyFile = "$Env:SCOOP\apps\Gitleaks\current\Gitleaks.exe"
        $this.GithubOwnerRepo = "gitleaks/gitleaks"
        $this.DocsUrl = "https://github.com/gitleaks/gitleaks#configuration" # Replace DocsUrl with your specific docs URL
        $this.ChangeLogUrl = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        $this.DotfilesSourcePath = "$PSScriptRoot"
        $this.Dotfiles = @(
            "$Env:dotfiles\.pre-commit-config.yaml"
        )
        # $this.Version = "0.0.0"
        # $this.AppLastUpdate = $null
        $this.CacheFolder = "$Env:XDG_CACHE_HOME\Gitleaks"
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
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
    #     [GenericState].UpdateAppData($this.GetType(), $this)
    # }
}
[AppRunner]::makeApp("Gitleaks")

