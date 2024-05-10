$AppFolder = $PSScriptRoot
$AppId = Split-Path $AppFolder -Leaf

[AppRunner]::Apps."$AppId" = [ScoopApps]::new([ordered]@{
        # Apps
        Logo            = @"
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
        Name            = "Git"
        AppId           = $AppId
        AppFolder       = $AppFolder
        AppStateJson    = "$AppFolder\$AppId.json"
        VerifyFile      = "$Env:SCOOP\apps\Git\current\git-cmd.exe"
        GithubOwnerRepo = "git-for-windows/git"
        DocsUrl         = "https://git-scm.com/docs" # Replace DocsUrl with your specific docs URL
        ChangeLogUrl    = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        Dotfiles        = @(
            "$Env:HOME\.bash_profile",
            "$Env:HOME\.bashrc",
            "$Env:HOME\.gitattributes",
            "$Env:HOME\.gitconfig",
            "$Env:HOME\.gitignore",
            "$Env:HOME\.minttyrc"
        )
        EnvVars         = @{
            # https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables
            "GIT_INSTALL_ROOT" = "$Env:SCOOP\apps\git\current"
            "GIT_EXEC_PATH"    = "$Env:SCOOP\apps\git\current\mingw64\libexec\git-core"
        }

        # PacketManager
        ScoopId         = $AppId # Scoop name
        Store           = "main"
    }
)
Remove-Variable -Name @("AppFolder", "AppId")

