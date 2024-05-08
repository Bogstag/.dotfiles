using module My

$fileName = Split-Path -Leaf $PSCommandPath
Write-Host " $fileName" -ForegroundColor DarkGreen
Remove-Variable fileName

$State = [State]::new()
$State = New-Object -TypeName State
$State.StartCollectingMeasurements("Profile")

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12


$timer = $State.MyStartMeasurement("Starship Loading")
Invoke-Expression (&starship init powershell)
$State.MyStopMeasurement($timer)
# . $Env:dotfiles\Apps\Starship\Add-Starship.ps1 # This broke, so i only us starship init for now.

# if ($env:TERM_PROGRAM -eq "vscode") {
#     # script injection:  . "$(code-insiders --locate-shell-integration-path pwsh)"
# }
