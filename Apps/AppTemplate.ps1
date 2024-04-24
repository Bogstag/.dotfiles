using module DotfilesModule

# Define a class for app-specific operations
class Template : App {
    [string] $Logo

    Template() : base(
        "Template", # CTRL+H Template with your specific app name, same as folder name
        "main",
        "$Env:SCOOP\apps\$($this.Name)\current\$($this.Name).exe",
        "https://github.com/RepoUrl", # Replace RepoUrl with your specific repo URL
        "https://github.com/DocsUrl", # Replace DocsUrl with your specific docs URL
        "$Env:XDG_CONFIG_HOME\$($this.Name)",
        "$($this.Name).json"
    ) {
        $this.Logo = @"
░▀█▀░█▀▀░█▄█░█▀█░█░░░█▀█░▀█▀░█▀▀
░░█░░█▀▀░█░█░█▀▀░█░░░█▀█░░█░░█▀▀
░░▀░░▀▀▀░▀░▀░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀
"@
    }

    [void] Clear() {
        # Logic to clean app's cache or other maintenance tasks.
    }

    [void] CompareDotfiles() {
        # Logic to compare dotfiles with reference to see if something has changed.
    }

    [void] DeployDotfiles() {
        # Logic to get dotfiles to the right location, by copying or symlink.
    }

    [void] Enable() {
        # Logic to run in profile to import, dotsource or invoke app
        # Import-Module "$Env:SCOOP\modules\$($this.Name)"
    }

    [void] Install() {
        # Logic to install app
        if (-Not (Test-Path "$Env:SCOOP\buckets\$($this.Bucket)" -PathType Container)) {
            scoop bucket add -Name "$($this.Bucket)"
        }
        if (-Not (Test-Path $this.VerifyFile -PathType Leaf)) {
            scoop install "$($this.Bucket)/$($this.Name)"
        }
    }

    [void] Invoke() {
        # Logic to run the app.
    }

    [void] SetEnvironmentVariables() {
        # Logic to set app env variables
        # if ($null -eq $Env:$app_ENV_VAR) {
        #     [Environment]::SetEnvironmentVariable("$app_ENV_VAR", "ENV_VAR_VALUE",[EnvironmentVariableTarget]::User)
        # }
    }

    [void] ShowDocs() {
        # Logic to show app documentation
        Start-Process "$($this.Repo)"
    }

    # [void] ShowLogo() {
    # }

    [void] ShowReleases() {
        # Logic to show release notes or changelog
        Start-Process "$($this.Repo)/releases"
    }

    [void] ShowRepo() {
        # Logic to show app repository
        Start-Process "$($this.Repo)"
    }

    [void] Reset() {
        # Logic to reset app
        scoop reset "$($this.Bucket)/$($this.Name)"
    }

    [void] Uninstall() {
        # Logic to uninstall app
        scoop uninstall "$($this.Bucket)/$($this.Name)"
    }

    [void] Update() {
        # Logic to update app
        scoop update "$($this.Bucket)/$($this.Name)"
    }

    [void] UpdateSystemState([SystemState] $systemState) {
        $systemState.UpdateAppData($this.Name, $this)
    }
}
