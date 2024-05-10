# New-Item -ItemType SymbolicLink -Path $Env:HOME\.config\Biome -Target $Env:DOME\.config\Biome
$AppFolder = $PSScriptRoot
$AppId = Split-Path $AppFolder -Leaf

[AppRunner]::Apps."$AppId" = [ScoopApps]::new([ordered]@{
        # Apps
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
        Name            = "Biome" # Pretty Name
        AppId           = $AppId
        AppFolder       = $AppFolder
        AppStateJson    = "$AppFolder\$AppId.json"
        VerifyFile      = "$Env:SCOOP\apps\biome\current\biome.exe" # File that exist if installed, recommended is exe file.
        GithubOwnerRepo = "biomejs/biome"
        DocsUrl         = "https://biomejs.dev/guides/getting-started/"
        ChangeLogUrl    = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        Dotfiles        = @(
            "$Env:HOME\.config\biome"
        )
        EnvVars         = @{
            "BIOME_BINARY"      = "$Env:SCOOP\apps\biome\current\biome.exe"
            "BIOME_CONFIG_PATH" = "$Env:XDG_CONFIG_HOME\biome\biome.json"
        }

        # PacketManager
        ScoopId         = $AppId
        Store           = "main"
    }
)
Remove-Variable -Name @("AppFolder", "AppId")
