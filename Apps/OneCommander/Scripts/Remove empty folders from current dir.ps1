#PS7
. ./_helper.ps1
$scriptName = Split-Path -Leaf $PSCommandPath
Log "📜 Running: $scriptName"

$CurrentDir = CurrentDir
Get-ChildItem $CurrentDir -Directory -Recurse | `
        Where-Object { (Get-ChildItem $_.fullName).count -eq 0 } | `
        Select-Object -ExpandProperty FullName | `
        ForEach-Object { Remove-Item $_ }


Log "📜 Done: $scriptName"
