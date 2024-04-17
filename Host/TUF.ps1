

if ($null -eq $env:InstallAppsOnHost) {
    [Environment]::SetEnvironmentVariable("InstallAppsOnHost", $true, [EnvironmentVariableTarget]::User)
}

if ($null -eq $env:REPOS) {
    [Environment]::SetEnvironmentVariable("REPOS", "$HOME\repos", [EnvironmentVariableTarget]::User)
}
if ($null -eq $env:sd_staging_path) {
    [Environment]::SetEnvironmentVariable("sd_staging_path", "$HOME\AI\SD", [EnvironmentVariableTarget]::User)
}
if ($null -eq $env:smatrix_install_path) {
    [Environment]::SetEnvironmentVariable("smatrix_install_path", "$HOME\AI\SD\Data", [EnvironmentVariableTarget]::User)
}
if ($null -eq $env:comfyui_install_path) {
    [Environment]::SetEnvironmentVariable("comfyui_install_path", "$HOME\AI\SD\Data\Packages\ComfyUI", [EnvironmentVariableTarget]::User)
}
if ($null -eq $env:invokeai_install_path) {
    [Environment]::SetEnvironmentVariable("invokeai_install_path", "$HOME\AI\SD\Data\Packages\InvokeAI", [EnvironmentVariableTarget]::User)
}
if ($null -eq $env:sdwebui_install_path) {
    [Environment]::SetEnvironmentVariable("sdwebui_install_path", "$HOME\AI\SD\Data\Packages\Stable Diffusion WebUI", [EnvironmentVariableTarget]::User)
}
if ($null -eq $env:forgeui_install_path) {
    [Environment]::SetEnvironmentVariable("forgeui_install_path", "NotInstalled", [EnvironmentVariableTarget]::User)
}
if ($null -eq $env:swarmui_install_path) {
    [Environment]::SetEnvironmentVariable("swarmui_install_path", "$HOME\AI\SD\Data\Packages\StableSwarmUI", [EnvironmentVariableTarget]::User)
}

