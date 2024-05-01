#PS7
. ./_helper.ps1
$scriptName = Split-Path -Leaf $PSCommandPath
Log "📜 Running: $scriptName"

$CurrentDir = CurrentDir
&"C:\Program Files\Smart SVG Viewer\SmartSvgViewer.exe" $CurrentDir

Log "📜 Done: $scriptName"

