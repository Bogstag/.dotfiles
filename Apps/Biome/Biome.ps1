# using module My
# using module My/My.ScoopApps.psm1

class Biome : ScoopApps {

    Biome() {
        $this.Logo = @"
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
        $this.Name = "Biome"
        $this.Id = "Biome"
        $this.PackageManager = "Scoop"
        $this.Store = "main"
        $this.VerifyFile = "$Env:SCOOP\apps\biome\current\biome.exe"
        $this.GithubOwnerRepo = "biomejs/biome"
        $this.DocsUrl = "https://biomejs.dev/guides/getting-started/"
        $this.DotfilesSourcePath = "$PSScriptRoot\dotfile"
        $this.Dotfiles = @(
            "$Env:XDG_CONFIG_HOME\biome\biome.json"
        )
        # $this.Version = "0.0.0"
        # $this.AppLastUpdate = $null
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
    }

    # [void] Clear() {}

    # [void] Enable() {}

    # [uri] GetRepoUri([string]$Switch) {}

    # [void] Install() {}

    # [void] Invoke() {}

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

    # [void] UpdateSystemState() {
    #     [GenericState].UpdateAppData($this.GetType(), $this)
    # }
}
[AppRunner]::makeApp("Biome")
