$fileName = Split-Path -Leaf $PSCommandPath
Write-Host "Running $fileName"
Remove-Variable fileName
