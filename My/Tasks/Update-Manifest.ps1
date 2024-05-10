$modulePath = "$Env:dotfiles\My"
$manifestPath = "$modulePath\My.psd1"
# $PSM = Import-PowerShellDataFile -Path "$manifestPath\My.psd1"
# Get all relevant files and convert them to module-relative paths
$files = @()
$files = Get-ChildItem -Path $modulePath -Recurse -File |
    ForEach-Object {
        # Trim any trailing spaces when constructing file paths
        $_.FullName.Replace($modulePath + '\', '').Trim()
    }

# Update the PSD1 file with new FileList
Update-ModuleManifest -Path $manifestPath -FileList @($files)


