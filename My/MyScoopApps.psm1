using module .\MyApps.psm1

class MyScoopApps : MyApps {

    # MyScoopApps() : base(@{}) {
    MyScoopApps() {
        Write-Debug -Message "MyScoopApps Ctor"
        $this.MyScoopAppsInit(@{})
    }

    MyScoopApps([hashtable]$Properties) {
        Write-Debug -Message "MyScoopApps Ctor props"
        $this.MyScoopAppsInit($Properties)
    }

    hidden MyScoopAppsInit([hashtable]$Properties) {
        $this.PackageManager = "Scoop"
        if ($Properties -ne @{}) {
            [MyApps]::Init($Properties)
        }
    }

    # [void] Clear() {}

    # [void] Enable() {}

    # [uri] GetRepoUri([string]$Switch) {}

    # [void] Install() {}

    # [void] Invoke() {}

    # [void] Reset() {}

    # [void] SetEnvironmentVariables() {
    #     $Value1 = "$($this.VerifyFile)"
    #     if (($null -eq $Env:BIOME_BINARY) -or ($Value1 -ne $Env:BIOME_BINARY)) {
    #         [Environment]::SetEnvironmentVariable("BIOME_BINARY", "$Value1", [EnvironmentVariableTarget]::User)
    #     }

    #     $Value2 = "$Env:XDG_CONFIG_HOME\biome\biome.json"
    #     if (($null -eq $Env:BIOME_CONFIG_PATH) -or ($Value2 -ne $Env:BIOME_CONFIG_PATH)) {
    #         [Environment]::SetEnvironmentVariable("BIOME_CONFIG_PATH", "$Value2", [EnvironmentVariableTarget]::User)
    #     }
    # }

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

