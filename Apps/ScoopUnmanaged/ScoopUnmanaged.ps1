# using module My
# using module My/My.ScoopApps.psm1

class ScoopUnmanaged : ScoopApps {
    [array] $AppsList

    ScoopUnmanaged() {
        $this.Name = "ScoopUnmanaged"
        $this.Id = "ScoopUnmanaged"
        $this.PackageManager = "Scoop"
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
    }

    [void] Clear() {}

    [void] DeployDotfile() {}
    [void] DeployDotfiles() {}
    [void] DotfilesSwitch() {}

    # [void] Enable() {}

    [void] GetRepoUri() {}

    [void] Install($Name) {}

    [void] Invoke() {}

    [void] RemoveDotfile() {}
    [void] RemoveDotfiles() {}

    [void] Reset() {}

    [void] SetEnvironmentVariables() {}

    [void] ShowDocs() {}

    [void] ShowLogo() {}

    [void] ShowReleases() {}

    [void] ShowRepo() {}

    [void] Uninstall() {}

    [void] Update() {}

    [void] UpdateScoopUnmanaged([string] $Name) {
        $this.AppsList += $Name
        scoop update $Name
    }

    # [void] UpdateSystemState() {}
}
[AppRunner]::makeApp("ScoopUnmanaged")
