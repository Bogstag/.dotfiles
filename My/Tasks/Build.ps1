Invoke-ScriptAnalyzer -Path $manifestPath `
    -Settings "$Env:dotfiles\PSScriptAnalyzerSettings.psd1" `
    -Fix

Invoke-Formatter -ScriptDefinition $manifestPath `
    -Settings "$Env:dotfiles\PSScriptAnalyzerSettings.psd1"

Invoke-ScriptAnalyzer -Path $manifestPath `
    -Settings "$Env:dotfiles\PSScriptAnalyzerSettings.psd1" `
    -Fix

Write-Host "Open $manifestPath and add @() to FileList and Format page once more to remove all validation errors."
