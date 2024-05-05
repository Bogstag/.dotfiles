# using module My
# using module My/My.ScoopApps.psm1

class NerdFonts : ScoopApps {

    NerdFonts() {
        $this.Logo = @"
@@@@@@@%%%%##############%%%%@@@@@@@@@@@@@@@@@@@@@@@@%%%##############%%%@@@@@@@
%%######*####%%%%%%%@@%%%%%#######%%%%%%%%%%%%%#######%%%%%%%%%%%%%%###**#####%%
########%@@@@@@@@@@@@%#%@@@@@@@%%#*##@@@@@@#*#*#%%@@@@@@@@@@@@@@%######%%#######
#######@@@@@@@@@@%%#%###*##@@@@@@@%###@@@@@%##%@@@@@@@@@@@%##%#*#%%%%%@@@@######
@%####%@@@@@@@@@##@%@@@@%###@@@@@@@###%@@@@##%@@@@@@@@@@%%#*#@%##%%%@@@@@@####%@
@@@###%@@@@@@%%###@%%@@@@###@@@@@@@###%%%%%##%@@@@@@@@#######@%#####%@@@@@###%@@
@@@%###@@@@@@@%###@%@@@@@%*#@@@@@@%##@@@@@@%##@@@@@@@@@@@@%##@%##@@@@@@@@@###@@@
@@@@###@@@@@@@%###@%%@@@%##@@@@@@@###@@@@@@@###@@@@@@@@@@@%##@%##@@@@@@@@%##@@@@
@@@@@##%@@@@@@%###@%@@@@#%@@@@@@@###@@@@@@@@@###@@@@@@@@@@%##@%##@@@@@@@@###@@@@
@@@@@%##%@@@@@@@%#@%@@@##%%%%@@@#*#@@@@@@@@@@@#*#@@@@@@@@@%*%@#*%@@@@@@@%##@@@@@
@@@@@@%##%@%%%%%#%%@@@######@@%##%@@@@@@@@@@@@@#*#%@%@@@@@##@##%@@@@@@@%*#@@@@@@
@@@@@@@%########%%@@@@%@@@@@%#*#%@@@@@@@@@@@@@@@%#*#####%%%@%@@@@@@@@%###@@@@@@@
@@@@@@@@@%####%%@@@@@@@%%#####%@@@@@@@@@@@@@@@@@@@%%#####%@@@@@%%%%###%@@@@@@@@@
@@@@@@@@@@@@%%############%%@@@@@@@@@@@@@@@@@@@@@@@@@@%%##########%%@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"@
        $this.Name = @("CascadiaCode-NF-Mono", "CascadiaCode-NF-Propo", "FiraCode-NF-Mono")
        $this.Store = "nerd-fonts"
        $this.VerifyFile = @("$Env:SCOOP\apps\CascadiaCode-NF-Mono\current\manifest.json",
            "$Env:SCOOP\apps\CascadiaCode-NF-Propo\current\manifest.json",
            "$Env:SCOOP\apps\FiraMono-NF-Mono\current\manifest.json")
        $this.GithubOwnerRepo = "ryanoasis/nerd-fonts"
        $this.DocsUrl = "https://www.nerdfonts.com/cheat-sheet"
        $this.ChangeLogUrl = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        $this.AppFolder = "$PSScriptRoot"

        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
        # TODO: This need a solution! Is this a one off?
    }

    # [void] Clear() {}

    # [void] Enable() {}

    # [uri] GetRepoUri([string]$Switch) {}

    [void] Install() {
        # Logic to install app
        if (-Not (Test-Path "$Env:SCOOP\buckets\$($this.Store)" -PathType Container)) {
            scoop bucket add -Name "$($this.Store)"
        }
        if (-Not (Test-Path "$Env:SCOOP\apps\CascadiaCode-NF-Mono\current\manifest.json" -PathType Leaf)) {
            scoop install "$($this.Store)/CascadiaCode-NF-Mono"
        }

        if (-Not (Test-Path "$Env:SCOOP\apps\CascadiaCode-NF-Propo\current\manifest.json" -PathType Leaf)) {
            scoop install "$($this.Store)/CascadiaCode-NF-Propo"
        }

        if (-Not (Test-Path "$Env:SCOOP\apps\FiraMono-NF-Mono\current\manifest.json" -PathType Leaf)) {
            scoop install "$($this.Store)/FiraMono-NF-Mono"
        }
    }

    # [void] Invoke() {}



    # [void] Reset() {}

    # [void] SetEnvironmentVariables() {}

    # [void] ShowDocs() {}

    # [void] ShowLogo() {}

    # [void] ShowReleases() {}

    # [void] ShowRepo() {}

    # [void] Uninstall() {}

    [void] Update([string] $Version) {
        # Logic to update app
        scoop update "$($this.Store)/CascadiaCode-NF-Mono"
        scoop update "$($this.Store)/CascadiaCode-NF-Propo"
        scoop update "$($this.Store)/FiraMono-NF-Mono"
        $this.AppLastUpdate = (Get-Date).ToShortDateString()
        $this.UpdateSystemState()
    }

    # [void] UpdateSystemState() {}
}
[AppRunner]::makeApp("NerdFonts")
