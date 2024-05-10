# $Env:SCOOP\persist\advancedrenamer TODO: see if there is sonething here i care about.
$AppFolder = $PSScriptRoot
$AppId = Split-Path $AppFolder -Leaf

[AppRunner]::Apps."$AppId" = [ScoopApps]::new([ordered]@{
        # Apps
        Logo         = @"
░█▀█░█▀▄░█░█░█▀█░█▀█░█▀▀░█▀▀░█▀▄░░░█▀▄░█▀▀░█▀█░█▀█░█▄█░█▀▀░█▀▄
░█▀█░█░█░▀▄▀░█▀█░█░█░█░░░█▀▀░█░█░░░█▀▄░█▀▀░█░█░█▀█░█░█░█▀▀░█▀▄
░▀░▀░▀▀░░░▀░░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀░░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀░▀░▀▀▀░▀░▀
Batch file renaming utility for Windows
"@
        Name         = "Advanced Renamer" # Pretty name
        AppId        = $AppId # Used for folder and script name
        AppFolder    = $AppFolder
        AppStateJson = "$AppFolder\$AppId.json"
        VerifyFile   = "$Env:SCOOP\apps\$AppId\current\arenc.exe"
        DocsUrl      = "https://www.advancedrenamer.com/user_guide/complete_guide"
        ChangeLogUrl = "https://www.advancedrenamer.com/versionlog"

        # ScoopApps
        ScoopId      = "advancedrenamer" # Same as scoop name
        Store        = "extras"
    }
)
Remove-Variable -Name @("AppFolder", "AppId")
