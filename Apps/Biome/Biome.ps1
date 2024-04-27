using module DotfilesModule

class Biome : App {
    [string] $Cache
    [string] $AppFolder
    [string] $Logo

    Biome() : base(@{
            Name         = "Biome"
            Store        = "main"
            VerifyFile   = "$Env:SCOOP\apps\biome\current\biome.exe"
            Repo         = "https://github.com/biomejs/biome"
            Docs         = "https://biomejs.dev/guides/getting-started/"
            ConfigFolder = "$Env:XDG_CONFIG_HOME\biome"
            ConfigFile   = "biome.json"
        }) {
        $this.Cache = $null
        $this.AppFolder = $PSScriptRoot
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
    }

    # [void] Clear() {
    #     # Logic to clean app's cache or other maintenance tasks.
    # }

    # [void] CompareDotfiles() {
    #     # Logic to compare dotfiles with reference to see if something has changed.
    # }

    [void] DeployDotfiles() {
        # Logic to get dotfiles to the right location, by copying or symlink.
        $this.AppDeployDotfiles($this.AppFolder)
    }

    # [void] Enable() {
    #     # Logic to run in profile to import, dotsource or invoke app
    # }

    # [void] Install() {
    #     # Logic to install app
    # }

    # [void] Invoke() {
    #     # Logic to run the app.
    # }

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

    [void] Uninstall() {
        scoop uninstall "$($this.Store)/$($this.Name)"

        if ($null -ne $Env:BIOME_BINARY) {
            [Environment]::SetEnvironmentVariable("BIOME_BINARY", $null, [EnvironmentVariableTarget]::User)
        }

        if ($null -ne $Env:BIOME_CONFIG_PATH) {
            [Environment]::SetEnvironmentVariable("BIOME_CONFIG_PATH", $null, [EnvironmentVariableTarget]::User)
        }
    }

    # [void] Update() {
    #     # Logic to update app
    # }

    # [void] UpdateSystemState([SystemState] $SystemState) {
    # }
}
