

class CascadiaCode : ScoopApps {

    CascadiaCode() {
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
A fun, new monospaced font that includes programming ligatures and is
designed to enhance the modern look and feel of the Windows Terminal.
"@
        $this.Name = "CascadiaCode"
        $this.Id = "Cascadia-Code"
        $this.Store = "nerd-fonts"
        $this.VerifyFile = "$Env:SystemRoot\Fonts\CascadiaMono.ttf"
        $this.GithubOwnerRepo = "microsoft/cascadia-code"
        $this.DocsUrl = "https://www.nerdfonts.com/cheat-sheet"
        $this.ChangeLogUrl = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        $this.AppFolder = "$PSScriptRoot"

        $this.AppStatePath = "$Env:dotfiles\Apps\CascadiaCode\CascadiaCode.json"
    }

    # [void] Clear() {}

    # [void] Enable() {}

    # [uri] GetRepoUri([string]$Switch) {}

    # [void] Install() {}

    # [void] Invoke() {}



    # [void] Reset() {}

    # [void] SetEnvironmentVariables() {}

    # [void] ShowDocs() {}

    # [void] ShowLogo() {}

    # [void] ShowReleases() {}

    # [void] ShowRepo() {}

    # [void] Uninstall() {}

    # [void] Update([string] $Version) {}

    # [void] UpdateSystemState() {}
}
[AppRunner]::InitApp("NerdFonts")


# Cascadia Code: standard version of Cascadia
# Cascadia Mono: a version of Cascadia that doesn't have ligatures
# Cascadia (Code|Mono) PL: a version of Cascadia that has embedded Powerline symbols
# Cascadia (Code|Mono) NF: a version of Cascadia that has Nerd Font symbols
# For the italic, there is a standard italic and a cursive variant accessible via ss01
# "editor.fontLigatures": "'ss01', 'ss02', 'ss03', 'ss19', 'ss20'"
