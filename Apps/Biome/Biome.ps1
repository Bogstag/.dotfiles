using module DotfilesModule

class Biome : App {
    [string] $Logo

    Biome() : base(
        "Biome",
        "main",
        "$Env:SCOOP\apps\biome\current\biome.exe",
        "https://github.com/biomejs/biome",
        "https://biomejs.dev/guides/getting-started/",
        "$Env:XDG_CONFIG_HOME\biome",
        "biome.json"
    ) {
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

    # [void] DeployDotfiles() {
    #     # Logicc to deploy dotfile
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

    [void] SetEnvironmentVariables() {
        if ($null -eq $Env:BIOME_BINARY) {
            [Environment]::SetEnvironmentVariable("BIOME_BINARY", $($this.VerifyFile), [EnvironmentVariableTarget]::User)
        }

        if ($null -eq $Env:BIOME_CONFIG_PATH) {
            [Environment]::SetEnvironmentVariable("BIOME_CONFIG_PATH", "$Env:XDG_CONFIG_HOME\biome\biome.json", [EnvironmentVariableTarget]::User)
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
        scoop uninstall "$($this.Bucket)/$($this.Name)"

        if ($null -eq $Env:BIOME_BINARY) {
            [Environment]::SetEnvironmentVariable("BIOME_BINARY", $null, [EnvironmentVariableTarget]::User)
        }

        if ($null -eq $Env:BIOME_CONFIG_PATH) {
            [Environment]::SetEnvironmentVariable("BIOME_CONFIG_PATH", $null, [EnvironmentVariableTarget]::User)
        }
    }

    # [void] Update() {
    #     # Logic to update app
    # }

    # [void] UpdateSystemState([SystemState] $SystemState) {
    # }
}
