using module DotfilesModule

class ScoopUnmanaged : App {
    [array] $AppsList

    ScoopUnmanaged() : base(@{
            Name      = "ScoopUnmanaged"
            AppFolder = "$PSScriptRoot"
        }) {
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
