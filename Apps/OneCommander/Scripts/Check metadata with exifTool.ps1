#PS7
. ./_helper.ps1
$scriptName = Split-Path -Leaf $PSCommandPath
Log "📜 Running: $scriptName"

# "$env:USERPROFILE\scoop\shims\exiftool.exe" '-fast -G -t -m -q -H $(SelectedFiles)'
$SelectedFiles = SelectedFiles

&"$env:USERPROFILE\scoop\apps\exiftool\current\exiftool.exe" $SelectedFiles

Log "📜 Done: $scriptName"
