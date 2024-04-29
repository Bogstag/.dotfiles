using module DotfilesModule

class Biome : App {

    Biome() : base(@{
            Logo            = @"
          -=
         -**=              ......      ..
       .+****+.           +@@%%%%%#:  =%%.
       =====+++:          +@@.   #@@  -*+    :+++=:   :=-:++=: -++=:    .=+++-
      ..:::. -**-         +@@%##%@@*  +@@. =%@#**@@#. +@@%*#@@@#*#@@+  *@%+=*@%-
   :=+*****. +*+*=        +@@=---+@%- +@@ .@@=    %@# =@@.  *@%   #@% =@@#***%@@
 .+**+-.... -*+*+*=       +@@.   -@@+ +@@  %@#: .-@@+ +@@.  *@%   #@# :@@*-:-+=:
.**+- :=+++=+****+*+.     +@%%%%%%#=  =@%. .+%@%%@#-  =@%.  +@%   *@#  :*%%%%%+
+*+*++************+**:        .               ...                         ...
Formatter, linter, bundler for JavaScript, JSON, HTML, Markdown, and CSS.
"@
            Name            = "Biome"
            Store           = "main"
            VerifyFile      = "$Env:SCOOP\apps\biome\current\biome.exe"
            GithubOwnerRepo = "biomejs/biome"
            Docs            = "https://biomejs.dev/guides/getting-started/"
            DotfilesFolder  = "$Env:XDG_CONFIG_HOME\biome"
            Dotfiles        = @(
                "$Env:XDG_CONFIG_HOME\biome\biome.json"
            )
            AppFolder       = "$PSScriptRoot"
        }) {
    }

    # [void] Clear() {}

    # [void] DeployDotfiles() {}

    # [void] Enable() {}

    # [uri] GetRepoUri([string]$Switch) {}

    # [void] Install() {}

    # [void] Invoke() {}

    # [void] RemoveDotfiles() {}

    # [void] Reset() {}

    [void] SetEnvironmentVariables() {
        $Value1 = "$($this.VerifyFile)"
        if (($null -eq $Env:BIOME_BINARY) -or ($Value1 -ne $Env:BIOME_BINARY)) {
            [Environment]::SetEnvironmentVariable("BIOME_BINARY", "$Value1", [EnvironmentVariableTarget]::User)
        }

        $Value2 = "$Env:XDG_CONFIG_HOME\biome\biome.json"
        if (($null -eq $Env:BIOME_CONFIG_PATH) -or ($Value2 -ne $Env:BIOME_CONFIG_PATH)) {
            [Environment]::SetEnvironmentVariable("BIOME_CONFIG_PATH", "$Value2", [EnvironmentVariableTarget]::User)
        }
    }

    # [void] ShowDocs() {}

    # [void] ShowLogo() {}

    # [void] ShowReleases() {}

    # [void] ShowRepo() {}

    # [void] Uninstall() {}

    # [void] Update() {}

    [void] UpdateSystemState([SystemState] $systemState) {
        $systemState.UpdateAppData($this.Name, $this)
    }
}
