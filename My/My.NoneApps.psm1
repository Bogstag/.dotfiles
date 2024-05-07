using module ./My.Apps.psm1

class NoneApps : Apps {

    # ScoopApps() : base([ordered]@{}) {
    NoneApps() {
        Write-Debug -Message "NoneApps Ctor"
        $this.NoneAppsInit()
    }

    NoneApps($Properties) {
        Write-Debug -Message "NoneApps Ctor props"
        $this.NoneAppsInit([hashtable]$Properties)
    }

    [void] NoneAppsInit() {
        $this.NoneAppsInit(@{})
    }

    [void] NoneAppsInit([hashtable]$Properties) {
        $this.MyPM = "None"
        $this.Store = $null
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
    #     [State].UpdateAppData($this.GetType(), $this)
    # }
}

