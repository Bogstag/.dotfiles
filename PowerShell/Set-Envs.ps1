$timer = $State.MyStartMeasurement("Setting Env Vars")
# ░█▀▀░█▀▀░▀█▀░░░░░█▀▀░█▀█░█░█░█▀▀
# ░▀▀█░█▀▀░░█░░▄▄▄░█▀▀░█░█░▀▄▀░▀▀█
# ░▀▀▀░▀▀▀░░▀░░░░░░▀▀▀░▀░▀░░▀░░▀▀▀

# Template
# if ($null -eq $Env:VAR) { [Environment]::SetEnvironmentVariable("VAR", "VALUE", [EnvironmentVariableTarget]::User) }

if ($null -eq $Env:HOME) { [Environment]::SetEnvironmentVariable("HOME", "$HOME", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:DOME) { [Environment]::SetEnvironmentVariable("DOME", "$Env:dotfiles\HOME", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:SCOOP) { [Environment]::SetEnvironmentVariable("SCOOP", "$HOME\scoop", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:dotfiles) { [Environment]::SetEnvironmentVariable("DOTFILES", "$HOME\.dotfiles", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:PSPROFILE) { [Environment]::SetEnvironmentVariable("PSPROFILE", "$HOME\Documents\PowerShell", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:MyPSPROFILE) { [Environment]::SetEnvironmentVariable("MyPSPROFILE", "$Env:DOTFILES\PowerShell\Profiles", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:XDG_DATA_HOME) { [Environment]::SetEnvironmentVariable("XDG_DATA_HOME", "$HOME\.data", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:XDG_CACHE_HOME) { [Environment]::SetEnvironmentVariable("XDG_CACHE_HOME", "$HOME\.cache", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:XDG_CONFIG_HOME) { [Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", "$HOME\.config", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:XDG_DOWNLOAD_DIR) { [Environment]::SetEnvironmentVariable("XDG_DOWNLOAD_DIR", "$HOME\Downloads", [EnvironmentVariableTarget]::User) }

if ($null -eq $Env:CUDA_PATH) { [Environment]::SetEnvironmentVariable("CUDA_PATH", "$HOME\scoop\apps\cuda\current", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:PNPM_HOME) { [Environment]::SetEnvironmentVariable("PNPM_HOME", "$ENV:LOCALAPPDATA\pnpm", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:CARGO_HOME) { [Environment]::SetEnvironmentVariable("CARGO_HOME", "$HOME\scoop\persist\rustup\.cargo", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:GRAMPS_DIR) { [Environment]::SetEnvironmentVariable("GRAMPS_DIR", "$HOME\scoop\apps\gramps\current", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:GRAMPSHOME) { [Environment]::SetEnvironmentVariable("GRAMPSHOME", "$HOME\scoop\persist\gramps", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:GRAMPSHOME) { [Environment]::SetEnvironmentVariable("GRAMPSHOME", "$HOME\scoop\persist\gramps", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:HF_HUB_OFFLINE) { [Environment]::SetEnvironmentVariable("HF_HUB_OFFLINE", "True", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:DISABLE_TELEMETRY) { [Environment]::SetEnvironmentVariable("DISABLE_TELEMETRY", "YES", [EnvironmentVariableTarget]::User) }

if ($null -eq $Env:LANG ) { [Environment]::SetEnvironmentVariable("LANG ", "en_SE", [EnvironmentVariableTarget]::User) }
if ($null -eq $Env:LANGUAGE) { [Environment]::SetEnvironmentVariable("LANGUAGE", "en:sv", [EnvironmentVariableTarget]::User) }

$State.MyStopMeasurement($timer)
