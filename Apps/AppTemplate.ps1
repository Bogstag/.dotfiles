using module DotfilesModule
# TODO: Templateing, handlebars?
# Define a class for app-specific operations
class Template : App {
    [string] $Cache
    [string] $AppFolder
    [string] $Logo

    Template() : base(@{
            Name         = "Template" # CTRL+H Template with your specific app name, same as folder name
            Store        = "main"
            VerifyFile   = "$Env:SCOOP\apps\Template\current\Template.exe"
            Repo         = "https://github.com/RepoUrl" # Replace RepoUrl with your specific repo URL
            Docs         = "https://github.com/DocsUrl" # Replace DocsUrl with your specific docs URL
            ConfigFolder = "$Env:XDG_CONFIG_HOME\Template"
            ConfigFile   = "Template.json"
        }) {
        $this.Cache = $null
        $this.AppFolder = $PSScriptRoot
        $this.Logo = @"
░▀█▀░█▀▀░█▄█░█▀█░█░░░█▀█░▀█▀░█▀▀
░░█░░█▀▀░█░█░█▀▀░█░░░█▀█░░█░░█▀▀
░░▀░░▀▀▀░▀░▀░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀
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
    #     $this.AppDeployDotfiles($this.AppFolder)
    # }

    # [void] Enable() {
    #     # Logic to run in profile to import, dotsource or invoke app
    # }

    # [void] Install() {
    #     # Logic to install app
    # }

    # [void] Invoke() {
    #     # Logic to run the app.
    # }

    # [void] SetEnvironmentVariables() {
    #     # Logic to set app env variables
    #     if ($null -eq $Env:$app_ENV_VAR) {
    #         [Environment]::SetEnvironmentVariable("$app_ENV_VAR", "ENV_VAR_VALUE",[EnvironmentVariableTarget]::User)
    #     }
    # }

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

    # [void] Uninstall() {
    #     # Logic to uninstall app
    #     # scoop uninstall "$($this.Store)/$($this.Name)"

    #     # Logic to unset env variables
    #     # if ($null -ne $Env:GIT_INSTALL_ROOT) {
    #         # [Environment]::SetEnvironmentVariable("GIT_INSTALL_ROOT", $null, [EnvironmentVariableTarget]::User)
    #     # }

    #     # Logic to remove dotfiles
    #     # Remove-Item -Path "$($this.ConfigFolder)\$($Dotfile).old" -Force -ErrorAction SilentlyContinue
    #     # Remove-Item -Path "$($this.ConfigFolder)\$($Dotfile)" -Force -ErrorAction SilentlyContinue
    # }

    # [void] Update() {
    #     # Logic to update app
    # }

    # [void] UpdateSystemState([SystemState] $systemState) {
    # }
}
