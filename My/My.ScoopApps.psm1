# using module My

using module ./My.Apps.psm1

[NoRunspaceAffinity()]
class ScoopApps : Apps {
    [string] $ScoopId
    [string] $PacketManager
    [string] $Store # AKA Buckets
    [scriptblock] $AppInstall # If apps need additional install steps

    ScoopApps() {
        # Write-Host "ScoopApps()"
        $this.ScoopAppsInit(@{})
    }
    # : base([hashtable]$Properties)
    ScoopApps([hashtable]$Properties) {
        # Write-Host "ScoopApps([hashtable]$Properties)"
        $this.IsState = "Init"
        $this.ScoopAppsInit($Properties)
    }

    ScoopAppsInit([hashtable]$Properties) {
        # Write-Host "ScoopAppsInit([hashtable]$Properties)"
        $this.IsState = "Init"
        if (-Not $this.PacketManager) {
            $this.PacketManager = "Scoop"
            $this.IsState = "NeedUpdate"
        }

        if (@{} -eq $Properties) {
            $this.AppsExit()
        } else {
            $this.UpdateProperties($Properties)
        }
    }

    [void] UpdateProperties([hashtable]$Properties) {
        # Write-Host "UpdateProperties([hashtable]$Properties)"
        foreach ($Property in $Properties.Keys) {
            $this.$Property = $Properties.$Property
        }

        if ("Init" -ne $this.IsState) {
            $this.IsState = "NeedUpdate"
        }
        $this.AppsExit()
    }

    [void] Install() {
        # Logic to install app
        $this.InstallStore()
        $this.InstallPackage()
        $this.SetEnvironmentVariables($this.EnvVars)
        $this.DotfilesSwitch('deploy')
        # TODO: Add env var

        if ($this.AppInstall) {
            Invoke-Command -ScriptBlock $this.AppInstall
        }

        $this.AppsExit()
    }

    [void] InstallStore() {
        if (-Not (Test-Path "$Env:SCOOP\buckets\$($this.Store)" -PathType Container)) {
            scoop bucket add -Name "$($this.Store)"
        }
    }

    [void] InstallPackage() {
        if (-Not (Test-Path $this.VerifyFile -PathType Leaf)) {
            scoop install "$($this.Store)/$($this.Id)"
        }
    }

    [void] Reset() {
        # Logic to reset app
        scoop reset "$($this.Store)/$($this.Id)"
        $this.AppsExit()
    }

    [void] Uninstall() {
        scoop uninstall "$($this.Store)/$($this.Id)"
        $this.DotfilesSwitch('remove')
        # TODO: Remove env var
        $this.AppsExit()
    }

    [void] Update([string] $Version) {
        # Logic to update app
        scoop update "$($this.Store)/$($this.Id)"
        $this.Version = [version]::Parse($Version)
        $this.AppLastUpdate = (Get-Date).ToShortDateString()
        # $this.UpdateSystemState()
        $this.SaveAppState()
    }
}
