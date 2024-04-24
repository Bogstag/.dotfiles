$modulePath = "$Env:dotfiles\DotfilesModule"
$manifestPath = "$modulePath\DotfilesModule.psd1"

# Get all relevant files and convert them to module-relative paths
$files = @()
$files = Get-ChildItem -Path $modulePath -Recurse -File |
    ForEach-Object {
        # Trim any trailing spaces when constructing file paths
        $_.FullName.Replace($modulePath + '\', '').Trim()
    }

# Update the PSD1 file with new FileList
Update-ModuleManifest -Path $manifestPath -FileList @($files)

Invoke-ScriptAnalyzer -Path $manifestPath `
    -Settings "$Env:dotfiles\PSScriptAnalyzerSettings.psd1" `
    -Fix

# Invoke-Formatter -ScriptDefinition $manifestPath `
#     -Settings "$Env:dotfiles\PSScriptAnalyzerSettings.psd1"

Invoke-ScriptAnalyzer -Path $manifestPath `
    -Settings "$Env:dotfiles\PSScriptAnalyzerSettings.psd1" `
    -Fix

Write-Host "Open $manifestPath and add @() to FileList and Format page once more to remove all validation errors."
