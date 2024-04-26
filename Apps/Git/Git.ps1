using module DotfilesModule

# Define a class for app-specific operations
class Git : App {
    [string] $Cache
    [string] $AppFolder
    [string[]] $Dotfiles
    [string] $Logo

    Git() : base(@{
            Name         = "Git" # CTRL+H Git with your specific app name, same as folder name
            Store        = "main"
            VerifyFile   = "$Env:SCOOP\apps\Git\current\git-cmd.exe"
            Repo         = "https://github.com/git-for-windows/git" # Replace RepoUrl with your specific repo URL
            Docs         = "https://git-scm.com/docs" # Replace DocsUrl with your specific docs URL
            ConfigFolder = $Env:USERPROFILE
            # ConfigFile   =
        }) {
        $this.Cache = $null
        $this.AppFolder = $PSScriptRoot
        $this.Dotfiles = @(".bash_profile", ".bashrc", ".gitattributes", ".gitconfig", ".gitignore", ".minttyrc")
        $this.Logo = @"
             .=***=.
            =*******=.
         .-..-********=.
        :*#*=..-==******-
     :+*=-=***:    ***=-=*+:
   :+##*#*=-=*+.   :=-=*####+:
 :+##*****#*=:=+ .-  :***#**##*:
+#**********#*=   =#*.   :*#**##*.
+*#***********=.  -*%=   .*#***##.
 .=*#*****#*==#% .#-=**++##*##*=
   .=*#***=+#@%-  *@*-=*####*-
     .=*++#@@@-    %@@*-=**-
        -%@%%%%*==#%%%@@+.
          =%@@%@@@@%@@#-
            =#@%%%@@#-
              =%%%*-
"@
    }

    # [void] Clear() {
    #     # Logic to clean app's cache or other maintenance tasks.
    # }

    # [void] CompareDotfiles() {
    #     # Logic to compare dotfiles with reference to see if something has changed.
    # }

    [void] DeployDotfiles() {
        foreach ($Dotfile in $this.Dotfiles) {
            $this.ConfigFile = $Dotfile
            $this.AppDeployDotfiles($this.AppFolder)
        }
    }

    # [void] Enable() {
    #     # Logic to run in profile to import, dotsource or invoke app
    # }

    [void] Install() {
        # Logic to install app
        if (-Not (Test-Path "$Env:SCOOP\buckets\$($this.Store)" -PathType Container)) {
            scoop Store add -Name "$($this.Store)"
        }

        if (-Not (Test-Path $this.VerifyFile -PathType Leaf)) {
            scoop install "$($this.Store)/$($this.Name)"
        }

        $this.SetEnvironmentVariables()

        $this.DeployDotfiles()
    }

    # [void] Invoke() {
    #     # Logic to run the app.
    # }

    [void] SetEnvironmentVariables() {
        if ($null -eq $Env:GIT_INSTALL_ROOT) {
            [Environment]::SetEnvironmentVariable("GIT_INSTALL_ROOT", "$Env:SCOOP\apps\git\current", [EnvironmentVariableTarget]::User)
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
        scoop uninstall "$($this.Store)/$($this.Name)"

        if ($null -ne $Env:GIT_INSTALL_ROOT) {
            [Environment]::SetEnvironmentVariable("GIT_INSTALL_ROOT", $null, [EnvironmentVariableTarget]::User)
        }

        foreach ($Dotfile in $this.Dotfiles) {
            Remove-Item -Path "$($this.ConfigFolder)\$($Dotfile).old" -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "$($this.ConfigFolder)\$($Dotfile)" -Force -ErrorAction SilentlyContinue
        }
    }

    # [void] Update() {
    #     # Logic to update app
    # }

    # [void] UpdateSystemState([SystemState] $systemState) {
    # }
}
