# using module My

# class CascadiaCodeNFMono : ScoopApps {

#     CascadiaCodeNFMono() : base(@{
#             Logo            = @"
# @@@@@@@%%%%##############%%%%@@@@@@@@@@@@@@@@@@@@@@@@%%%##############%%%@@@@@@@
# %%######*####%%%%%%%@@%%%%%#######%%%%%%%%%%%%%#######%%%%%%%%%%%%%%###**#####%%
# ########%@@@@@@@@@@@@%#%@@@@@@@%%#*##@@@@@@#*#*#%%@@@@@@@@@@@@@@%######%%#######
# #######@@@@@@@@@@%%#%###*##@@@@@@@%###@@@@@%##%@@@@@@@@@@@%##%#*#%%%%%@@@@######
# @%####%@@@@@@@@@##@%@@@@%###@@@@@@@###%@@@@##%@@@@@@@@@@%%#*#@%##%%%@@@@@@####%@
# @@@###%@@@@@@%%###@%%@@@@###@@@@@@@###%%%%%##%@@@@@@@@#######@%#####%@@@@@###%@@
# @@@%###@@@@@@@%###@%@@@@@%*#@@@@@@%##@@@@@@%##@@@@@@@@@@@@%##@%##@@@@@@@@@###@@@
# @@@@###@@@@@@@%###@%%@@@%##@@@@@@@###@@@@@@@###@@@@@@@@@@@%##@%##@@@@@@@@%##@@@@
# @@@@@##%@@@@@@%###@%@@@@#%@@@@@@@###@@@@@@@@@###@@@@@@@@@@%##@%##@@@@@@@@###@@@@
# @@@@@%##%@@@@@@@%#@%@@@##%%%%@@@#*#@@@@@@@@@@@#*#@@@@@@@@@%*%@#*%@@@@@@@%##@@@@@
# @@@@@@%##%@%%%%%#%%@@@######@@%##%@@@@@@@@@@@@@#*#%@%@@@@@##@##%@@@@@@@%*#@@@@@@
# @@@@@@@%########%%@@@@%@@@@@%#*#%@@@@@@@@@@@@@@@%#*#####%%%@%@@@@@@@@%###@@@@@@@
# @@@@@@@@@%####%%@@@@@@@%%#####%@@@@@@@@@@@@@@@@@@@%%#####%@@@@@%%%%###%@@@@@@@@@
# @@@@@@@@@@@@%%############%%@@@@@@@@@@@@@@@@@@@@@@@@@@%%##########%%@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Nerd Fonts patched 'CascadiaCode' Font family.
# "@
#             Name            = "CascadiaCode-NF-Mono"
#             Store           = "nerd-fonts"
#             VerifyFile      = "$Env:SCOOP\apps\CascadiaCode-NF-Mono\current\manifest.json"
#             GithubOwnerRepo = "ryanoasis/nerd-fonts"
#             Docs            = "https://www.nerdfonts.com/cheat-sheet"
#             AppFolder       = "$PSScriptRoot"
#         }) {
#     }

#     # [void] Clear() {}

#     # [void] Enable() {}

#     # [uri] GetRepoUri([string]$Switch) {}

#     # [void] Install() {}

#     # [void] Invoke() {}

#

#     # [void] Reset() {}

#     # [void] SetEnvironmentVariables() {
#     #     # Logic to set app env variables
#     #     $Value = ""
#     #     if (($null -eq $Env:app_ENV_VAR) -or ($Value -ne $Env:app_ENV_VAR)) {
#     #         [Environment]::SetEnvironmentVariable("app_ENV_VAR", "$Value", [EnvironmentVariableTarget]::User)
#     #     }
#     # }

#     # [void] ShowDocs() {}

#     # [void] ShowLogo() {}

#     # [void] ShowReleases() {}

#     # [void] ShowRepo() {}

#     # [void] Uninstall() {}

#     # [void] Update() {}

#     [void] UpdateSystemState() {
#         [GenericState].UpdateAppData($this.GetType(), $this)
#     }
# }