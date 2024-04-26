using module DotfilesModule

class TerminalIcons : App {
    [string] $Cache
    [string] $AppFolder
    [string] $Logo

    TerminalIcons() : base(@{
            Name       = "Terminal-Icons"
            Store      = "extras"
            VerifyFile = "$Env:SCOOP\modules\Terminal-Icons\Terminal-Icons.psd1"
            Repo       = "https://github.com/devblackops/Terminal-Icons"
            Docs       = "https://github.com/devblackops/Terminal-Icons"
            # ConfigFolder =
            # ConfigFile =
        }) {
        $this.Cache = $null
        $this.AppFolder = $PSScriptRoot
        $this.Logo = @"
░▀█▀░█▀▀░█▀▄░█▄█░▀█▀░█▀█░█▀█░█░░░░░░░▀█▀░█▀▀░█▀█░█▀█░█▀▀
░░█░░█▀▀░█▀▄░█░█░░█░░█░█░█▀█░█░░░▄▄▄░░█░░█░░░█░█░█░█░▀▀█
░░▀░░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░░░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
"@
    }

    # [void] Clear() {
    #     # Logic to clean app's cache or other maintenance tasks.
    # }

    # [void] CompareDotfiles() {
    #     # Logic to compare dotfiles with reference to see if something has changed.
    # }

    # [void] DeployDotfiles() {
    #     # Logic to get dotfiles to the right location, by copying or symlink.
    # }

    [void] Enable() {
        Import-Module "$Env:SCOOP\modules\Terminal-Icons"
    }

    # [void] Install() {
    #     # Logic to install app
    # }

    # [void] Invoke() {
    #     # Logic to run the app.
    # }

    # [void] SetEnvironmentVariables() {
    #     # Logic to set app env variables
    #     # if ($null -eq $Env:$app_ENV_VAR) {
    #     #     [Environment]::SetEnvironmentVariable("$app_ENV_VAR", "ENV_VAR_VALUE",[EnvironmentVariableTarget]::User)
    #     # }
    # }

    # [void] ShowDocs() {
    #     # Logic to show app documentation
    # }

    # [void] ShowLogo() {
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

    # [void] Uninstall() {
    #     # Logic to uninstall app
    # }

    # [void] Update() {
    #     # Logic to update app
    # }

    # [void] UpdateSystemState([SystemState] $systemState) {
    # }
}
