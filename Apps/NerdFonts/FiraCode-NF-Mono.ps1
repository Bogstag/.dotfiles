# # using module My
# using module My/My.ScoopApps.psm1

# class FiraCodeNFMono : ScoopApps {

#     FiraCodeNFMono() {
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
# Nerd Fonts patched 'FiraCode' Font family.
# "@
#             Name            = "FiraCode-NF-Mono"
#             Store           = "nerd-fonts"
#             $this.VerifyFile      = "$Env:SCOOP\apps\FiraMono-NF-Mono\current\manifest.json"
#             $this.GithubOwnerRepo = "ryanoasis/nerd-fonts"
#             Docs            = "https://www.nerdfonts.com/cheat-sheet"
#             $this.AppFolder = "$PSScriptRoot"
#
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
