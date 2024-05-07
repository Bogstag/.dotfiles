using module My
# $ErrorActionPreference = "Continue"
# $DebugPreference = 'Continue'

$fileName = Split-Path -Leaf $PSCommandPath
Write-Host "Running $fileName"
Remove-Variable fileName

if ($env:TERM_PROGRAM -eq "vscode") {
    # script injection:  . "$(code-insiders --locate-shell-integration-path pwsh)"
}

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
# Import-PackageProvider -Name "PowerShellGet" -RequiredVersion "2.2.5.0" -Verbose -Force

. $Env:dotfiles\Apps\Starship\Add-Starship.ps1
