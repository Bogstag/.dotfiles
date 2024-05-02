using module My

$ErrorActionPreference = "Continue"
$DebugPreference = 'Continue'

$fileName = Split-Path -Leaf $PSCommandPath
Write-Host "Running $fileName"

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
# Import-PackageProvider -Name "PowerShellGet" -RequiredVersion "2.2.5.0" -Verbose -Force

$MySystemState = New-MySystemState
if ($null -eq $MySystemState) {
    Write-Error "Failed to initialize MySystemState from My."
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

