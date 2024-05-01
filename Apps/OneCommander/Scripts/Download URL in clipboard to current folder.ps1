#PS7
. ./_helper.ps1
$scriptName = Split-Path -Leaf $PSCommandPath
Log "📜 Running: $scriptName"

$CurrentDir = CurrentDir
$url = Get-Clipboard
$file = $url | Split-Path -Leaf
aria2c --file-allocation=none --dir=$CurrentDir --out=$file $url

Log "📜 Done: $scriptName"
