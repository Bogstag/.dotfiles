using module ./My.Apps.psm1

class ScoopApps : Apps {

    # ScoopApps() : base(@{}) {
    ScoopApps() {
        Write-Debug -Message "ScoopApps Ctor"
        $this.ScoopAppsInit()
    }

    ScoopApps([hashtable]$Properties) {
        Write-Debug -Message "ScoopApps Ctor props"
        $this.ScoopAppsInit($Properties)
    }

    [void] ScoopAppsInit() {
        Write-Debug -Message "ScoopApps Init Empty"
        $this.ScoopAppsInit(@{})
    }

    [void] ScoopAppsInit([hashtable]$Properties) {
        Write-Debug -Message "ScoopApps Init props"
        $this.PackageManager = "Scoop"
        if ($Properties -ne @{}) {
            $this.Init($Properties)
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
    #     [GenericState].UpdateAppData($this.GetType(), $this)
    # }
}

