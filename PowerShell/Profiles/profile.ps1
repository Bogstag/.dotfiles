using module DotfilesModule

$ErrorActionPreference = "Stop"
$DebugPreference = 'Stop'

$fileName = Split-Path -Leaf $PSCommandPath
Write-Host "Running $fileName"

$SystemState = New-SystemState
if ($null -eq $SystemState) {
    Write-Error "Failed to initialize SystemState from the DotfilesModule."
}

if ($null -eq $ProfileLoadTime) {
    $ProfileLoadTime = New-Object -TypeName PSObject -Property @{
        Milliseconds = 0
        Measurements = 0
    }
}

. $Env:dotfiles\PowerShell\Set-Paths.ps1
. $Env:dotfiles\PowerShell\Set-Envs.ps1
. $Env:dotfiles\PowerShell\Set-Alias.ps1
. $Env:dotfiles\Apps\Starship\Add-Starship.ps1

