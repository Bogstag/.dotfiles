using module DotfilesModule

class Git : App {

    Git() : base(@{
            Logo               = @"
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
            Name               = "Git"
            Store              = "main"
            VerifyFile         = "$Env:SCOOP\apps\Git\current\git-cmd.exe"
            GithubOwnerRepo    = "git-for-windows/git"
            Docs               = "https://git-scm.com/docs" # Replace DocsUrl with your specific docs URL
            DotfilesSourcePath = "$PSScriptRoot"
            Dotfiles           = @(
                "$Env:USERPROFILE\.bash_profile",
                "$Env:USERPROFILE\.bashrc",
                "$Env:USERPROFILE\.gitattributes",
                "$Env:USERPROFILE\.gitconfig",
                "$Env:USERPROFILE\.gitignore",
                "$Env:USERPROFILE\.minttyrc"
            )
            AppFolder          = "$PSScriptRoot"
        }) {

    }

    # [void] Clear() {}

    # [void] Enable() {}

    # [uri] GetRepoUri([string]$Switch) {}

    [void] Install() {
        # Logic to install app
        # if (-Not (Test-Path "$Env:SCOOP\buckets\$($this.Store)" -PathType Container)) {
        #     scoop Store add -Name "$($this.Store)"
        # }

        # if (-Not (Test-Path $this.VerifyFile -PathType Leaf)) {
        #     scoop install "$($this.Store)/$($this.Name)"
        #     $this.DotfilesSwitch()
        # }
        [App].Install() # TODO: verify this solution

        $this.SetEnvironmentVariables()

    }

    # [void] Invoke() {}

    # [void] Reset() {}

    [void] SetEnvironmentVariables() {
        $Value = "$Env:SCOOP\apps\git\current"
        if (($null -eq $Env:GIT_INSTALL_ROOT) -or ($Value -ne $Env:GIT_INSTALL_ROOT)) {
            [Environment]::SetEnvironmentVariable("GIT_INSTALL_ROOT", "$Value ", [EnvironmentVariableTarget]::User)
        }
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
