#PS7
. ./_helper.ps1
$scriptName = Split-Path -Leaf $PSCommandPath
Log "📜 Running: $scriptName"
# Log "   Log an error!" $true

# $SelectedFiles = SelectedFiles
# $CurrentDir = CurrentDir
# $SelectedFilesInactive = SelectedFilesInactive
# $CurrentDirInactive = CurrentDirInactive

# &"$env:USERPROFILE\scoop\apps\exiftool\current\exiftool.exe" $SelectedFiles

Log "📜 Done: $scriptName"
