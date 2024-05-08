

# $ErrorActionPreference = "Stop"
# $DebugPreference = 'Stop'
class Git : ScoopApps {

    Git() {
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
Distributed version control system
"@
        $this.Name = "Git"
        $this.Id = "git"
        $this.Store = "main"
        $this.VerifyFile = "$Env:SCOOP\apps\Git\current\git-cmd.exe"
        $this.GithubOwnerRepo = "git-for-windows/git"
        $this.DocsUrl = "https://git-scm.com/docs" # Replace DocsUrl with your specific docs URL
        # $this.ChangeLogUrl = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        $this.DotfilesSourcePath = "$PSScriptRoot"
        $this.Dotfiles = @(
            "$Env:USERPROFILE\.bash_profile",
            "$Env:USERPROFILE\.bashrc",
            "$Env:USERPROFILE\.gitattributes",
            "$Env:USERPROFILE\.gitconfig",
            "$Env:USERPROFILE\.gitignore",
            "$Env:USERPROFILE\.minttyrc"
        )
        # $this.Version = "0.0.0"
        # $this.AppLastUpdate = $null
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
        # [AppRunner]::InitApp("Git")
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
        # $this.Install() # TODO: verify this solution

        [ScoopApps]::install()

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
    #     [State].UpdateAppData($this.GetType(), $this)
    # }
}
[Git]::new()
