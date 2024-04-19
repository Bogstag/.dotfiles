$fileName = Split-Path -Leaf $PSCommandPath
Write-Host "Running $fileName"

if ($null -eq $totalTimeMs) {
    # Init a variable that holds total execution time in ms.
    $totalTimeMs = 0
}

. $env:dotfiles\PowerShell\Set-Envs.ps1
. $env:dotfiles\PowerShell\Set-Paths.ps1
. $env:dotfiles\PowerShell\Set-Alias.ps1
. $env:dotfiles\PowerShell\Add-Starship.ps1
