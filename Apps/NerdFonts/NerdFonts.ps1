using module My

class NerdFonts : ScoopApps {

    NerdFonts() : base(@{
            Logo            = @"
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
            Name            = @("CascadiaCode-NF-Mono", "CascadiaCode-NF-Propo", "FiraCode-NF-Mono")
            Store           = "nerd-fonts"
            VerifyFile      = @("$Env:SCOOP\apps\CascadiaCode-NF-Mono\current\manifest.json",
                "$Env:SCOOP\apps\CascadiaCode-NF-Propo\current\manifest.json",
                "$Env:SCOOP\apps\FiraMono-NF-Mono\current\manifest.json")
            GithubOwnerRepo = "ryanoasis/nerd-fonts"
            DocsUrl         = "https://www.nerdfonts.com/cheat-sheet"
            AppFolder       = "$PSScriptRoot"
        }) {
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

