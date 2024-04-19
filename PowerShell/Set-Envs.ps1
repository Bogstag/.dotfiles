# ░░░█▀▀░█▀▀░▀█▀░░░░░█▀▀░█▀█░█░█░
# ░░░▀▀█░█▀▀░░█░░▄▄▄░█▀▀░█░█░▀▄▀░
# ░░░▀▀▀░▀▀▀░░▀░░░░░░▀▀▀░▀░▀░░▀░░

Write-Host " ⏱️ Environment variables => " -NoNewline -ForegroundColor Green

$t = Measure-Command {
    if ($null -eq $env:PSPROFILE) {
        [Environment]::SetEnvironmentVariable("PSPROFILE", "$HOME\Documents\PowerShell", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:MyPSPROFILE) {
        [Environment]::SetEnvironmentVariable("MyPSPROFILE", "$HOME\.dotfiles\PowerShell\Profiles", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:SCOOP) {
        [Environment]::SetEnvironmentVariable("SCOOP", "$HOME\scoop", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:dotfiles) {
        [Environment]::SetEnvironmentVariable("dotfiles", "$HOME\.dotfiles", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:XDG_CACHE_HOME) {
        [Environment]::SetEnvironmentVariable("XDG_CACHE_HOME", "$HOME\.cache", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:XDG_CONFIG_HOME) {
        [Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", "$HOME\.config", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:XDG_DOWNLOAD_DIR) {
        [Environment]::SetEnvironmentVariable("XDG_DOWNLOAD_DIR", "$HOME\Downloads", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:PNPM_HOME) {
        [Environment]::SetEnvironmentVariable("PNPM_HOME", "$ENV:LOCALAPPDATA\pnpm", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:DISABLE_TELEMETRY) {
        [Environment]::SetEnvironmentVariable("DISABLE_TELEMETRY", "YES", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:HF_HUB_OFFLINE) {
        [Environment]::SetEnvironmentVariable("HF_HUB_OFFLINE", "True", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:CARGO_HOME) {
        [Environment]::SetEnvironmentVariable("CARGO_HOME", "$HOME\scoop\persist\rustup\.cargo", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:CUDA_PATH) {
        [Environment]::SetEnvironmentVariable("CUDA_PATH", "$HOME\scoop\apps\cuda\current", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:GRAMPS_DIR) {
        [Environment]::SetEnvironmentVariable("GRAMPS_DIR", "$HOME\scoop\apps\gramps\current", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:GRAMPSHOME) {
        [Environment]::SetEnvironmentVariable("GRAMPSHOME", "$HOME\scoop\persist\gramps", [EnvironmentVariableTarget]::User)
    }
    if ($null -eq $env:GRAMPSHOME) {
        [Environment]::SetEnvironmentVariable("GRAMPSHOME", "$HOME\scoop\persist\gramps", [EnvironmentVariableTarget]::User)
    }
}
$totalTimeMs = $totalTimeMs + $t.Milliseconds
Write-Host $t.Milliseconds"ms" -ForegroundColor Green

# TODO: $env:SCOOP_GLOBAL

# Template
# if ($null -eq $env:VAR) { [Environment]::SetEnvironmentVariable("VAR", "VALUE", [EnvironmentVariableTarget]::User) }

