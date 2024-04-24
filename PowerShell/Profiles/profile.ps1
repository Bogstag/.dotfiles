using module DotfilesModule
# Import-Module DotfilesModule
# Get-Module DotfilesModule

$ErrorActionPreference = "Stop"
$DebugPreference = 'Stop'

$fileName = Split-Path -Leaf $PSCommandPath
Write-Host "Running $fileName"

$SystemState = New-SystemState
if ($null -eq $SystemState) {
    Write-Error "Failed to initialize SystemState from the DotfilesModule."
}

# if ($env:TERM_PROGRAM -eq "vscode") {
#     . "$(code --locate-shell-integration-path pwsh)"
# }



if ($null -eq $ProfileLoadTime) {
    $ProfileLoadTime = New-Object -TypeName PSObject -Property @{
        Milliseconds = 0
        Measurements = 0
    }
}

. $Env:dotfiles\PowerShell\Set-Paths.ps1
. $Env:dotfiles\PowerShell\Set-Envs.ps1
. $Env:dotfiles\PowerShell\Set-Alias.ps1
. $Env:dotfiles\PowerShell\Add-Starship.ps1

