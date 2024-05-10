using module ./My.Apps.psm1

[NoRunspaceAffinity()]
class NoneApps : Apps {

    # ScoopApps() : base([ordered]@{}) {
    NoneApps() {
        Write-Debug -Message "NoneApps Ctor"
        $this.NoneAppsInit(@{})
    }

    NoneApps([hashtable]$Properties) {
        Write-Debug -Message "NoneApps Ctor props"
        $this.NoneAppsInit([hashtable]$Properties)
    }

    [void] NoneAppsInit([hashtable]$Properties) {
        Write-Debug -Message "NoneAppsInit Properties: $($Properties)"
        $this.PacketManager = "None"
        $this.Store = $null
        if (@{} -eq $Properties) {
            Write-Debug -Message "NoneAppsInit Init"
            $this.AppsExit()
        } else {
            Write-Debug -Message "NoneAppsInit UpdateProperties"
            $this.UpdateProperties($Properties)
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

