# using module My
using module ./My.Apps.psm1

class ScoopApps : Apps {

    ScoopApps() {
        $this.ScoopAppsInit(@{})
    }

    ScoopApps([hashtable]$Properties) {
        $this.ScoopAppsInit($Properties)
    }

    ScoopAppsInit([hashtable]$Properties) {
        $this.MyPM = "Scoop"

        if (@{} -eq $Properties) {
            $this.Init()
        } else {
            $this.SplatProperties($Properties)
        }
    }

    [void] Install() {
        # Logic to install app
        if (-Not (Test-Path "$Env:SCOOP\buckets\$($this.Store)" -PathType Container)) {
            scoop bucket add -Name "$($this.Store)"
        }
        if (-Not (Test-Path $this.VerifyFile -PathType Leaf)) {
            scoop install "$($this.Store)/$($this.Id)"
            $this.DotfilesSwitch('deploy')
            # TODO: Add env var
        }
        $this.SaveAppState()
    }
    
    [void] Reset() {
        # Logic to reset app
        scoop reset "$($this.Store)/$($this.Id)"
        $this.SaveAppState()
    }

    [void] Uninstall() {
        scoop uninstall "$($this.Store)/$($this.Id)"
        $this.DotfilesSwitch('remove')
        # TODO: Remove env var
        $this.SaveAppState()
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
