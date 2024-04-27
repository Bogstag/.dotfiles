using module DotfilesModule

# Also including pre-commit
class Gitleaks : App {
    [string] $Cache
    [string] $AppFolder
    [string] $Logo

    Gitleaks() : base(@{
            Name         = "Gitleaks" # CTRL+H Gitleaks with your specific app name, same as folder name
            Store        = "main"
            VerifyFile   = "$Env:SCOOP\apps\Gitleaks\current\Gitleaks.exe"
            Repo         = "https://github.com/gitleaks/gitleaks" # Replace RepoUrl with your specific repo URL
            Docs         = "https://github.com/gitleaks/gitleaks#configuration" # Replace DocsUrl with your specific docs URL
            ConfigFolder = "$Env:XDG_CONFIG_HOME\Gitleaks"
            ConfigFile   = ".pre-commit-config.yaml"
        }) {
        $this.Cache = "$Env:XDG_CACHE_HOME\Gitleaks"
        $this.AppFolder = $PSScriptRoot
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
    }

    [void] Clear() {
        # Logic to clean app's cache or other maintenance tasks.
        Remove-Item -Path "$($this.ConfigFolder)\$($this.ConfigFile).old" -Force -ErrorAction SilentlyContinue
        Remove-Item -Path "$($Env:dotfiles)\$($this.ConfigFile).old" -Force -ErrorAction SilentlyContinue
    }

    # [void] CompareDotfiles() {
    #     # Logic to compare dotfiles with reference to see if something has changed.
    # }

    [void] DeployDotfiles() {
        # Logic to get dotfiles to the right location, by copying or symlink.
        $this.AppDeployDotfiles($this.AppFolder)

        Remove-Item -Path "$($Env:dotfiles)\$($this.ConfigFile).old" -Force -ErrorAction SilentlyContinue
        Rename-Item -Path "$($Env:dotfiles)\$($this.ConfigFile)" -NewName "$($this.ConfigFile).old" -Force -ErrorAction SilentlyContinue
        New-Item -ItemType SymbolicLink -Path "$($Env:dotfiles)\$($this.ConfigFile)" -Target "$($this.AppFolder)\$($this.ConfigFile)"
    }

    # [void] Enable() {
    #     # Logic to run in profile to import, dotsource or invoke app
    # }

    [void] Install() {
        # Logic to install app
        # https://pre-commit.com/#install
        python -m pip install pre-commit

        # Update after install
        pre-commit autoupdate

        # Copy config to profile, This have no real purpose other then easy access to a starter config.
        $this.DeployDotfiles()

        # Add gitleaks to git pre-commit
        pre-commit install
        # pre-commit installed at $this.dotfiles\.git\hooks\pre-commit

        $this.SetEnvironmentVariables()
    }

    # [void] Invoke() {
    #     # Logic to run the app.
    # }

    [void] SetEnvironmentVariables() {
        # Logic to set app env variables
        if (($null -eq $Env:GITLEAKS_CONFIG) -or ($this.ConfigFolder -ne $Env:GITLEAKS_CONFIG)) {
            [Environment]::SetEnvironmentVariable("GITLEAKS_CONFIG", "$($this.ConfigFolder)", [EnvironmentVariableTarget]::User)
        }
    }

    # [void] ShowDocs() {
    #     # Logic to show app documentation
    # }

    # [void] ShowLogo() {
    #     # Logic to show Logo
    # }

    # [void] ShowReleases() {
    #     # Logic to show release notes or changelog
    # }

    # [void] ShowRepo() {
    #     # Logic to show app repository
    # }

    # [void] Reset() {
    #     # Logic to reset app
    # }

    [void] Uninstall() {
        # Logic to uninstall app
        scoop uninstall "$($this.Store)/$($this.Name)"

        # Logic to unset env variables
        if ($null -ne $Env:GITLEAKS_CONFIG) {
            [Environment]::SetEnvironmentVariable("GITLEAKS_CONFIG", $null, [EnvironmentVariableTarget]::User)
        }

        # Logic to remove dotfiles
        Remove-Item -Path "$($Env:dotfiles)\$($this.ConfigFile).old" -Force -ErrorAction SilentlyContinue
        Rename-Item -Path "$($Env:dotfiles)\$($this.ConfigFile)" -NewName "$($this.ConfigFile).old" -Force -ErrorAction SilentlyContinue

        Remove-Item -Path "$($this.ConfigFolder)\$($this.ConfigFile)" -Force -ErrorAction SilentlyContinue
        Remove-Item -Path "$($this.ConfigFolder)\$($this.ConfigFile)" -Force -ErrorAction SilentlyContinue
    }

    # [void] Update() {
    #     # Logic to update app
    # }

    # [void] UpdateSystemState([SystemState] $systemState) {
    # }
}
