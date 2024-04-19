# ░▀█▀░█▀▀░█▀▄░█▄█░▀█▀░█▀█░█▀█░█░░░░░▀█▀░█▀▀░█▀█░█▀█░█▀▀░
# ░░█░░█▀▀░█▀▄░█░█░░█░░█░█░█▀█░█░░░░░░█░░█░░░█░█░█░█░▀▀█░
# ░░▀░░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░
if ($null -eq $app.Name) {
    $app = Get-Item -Path $PSScriptRoot
}

$appName = $app.Name
$bucket = "extras"
$verify = "$HOME\scoop\modules\Terminal-Icons\Terminal-Icons.psd1"
$repo = "https://github.com/devblackops/Terminal-Icons"

function Clear-Terminal-Icons {
    # Logic to clean apps cache or other maintenance tasks.
}

function Compare-Terminal-IconsDotfiles {
    # Logic to compare dotfiles with reference to see if something has changed.
}

function Deploy-Terminal-IconsDotfiles {
    # Logic to get dotfiles to the right location, by copying or symlink.
}
function Enable-Terminal-Icons {
    Write-Host " ⏱️ $appName => " -NoNewline -ForegroundColor Green
    Import-Module "$HOME\scoop\modules\$appName"
    $totalTimeMs = $totalTimeMs + $t.Milliseconds
    Write-Host $t.Milliseconds"ms" -ForegroundColor Green
}

function Install-Terminal-Icons {
    if ($false -eq (Test-Path $HOME\scoop\buckets\$bucket -PathType Container)) {
        scoop bucket add $bucket
    }

    if ($false -eq (Test-Path $verify -PathType Leaf)) {
        scoop install $bucket/$appName
    }
}

function Invoke-Terminal-Icons {
    # Logic to run the app.
}

function Set-Terminal-IconsEnvironmentVariables {
    # if ($null -eq $env:$app_ENV_VAR) {
    #     [Environment]::SetEnvironmentVariable("$app_ENV_VAR", "ENV_VAR_VALUE",[EnvironmentVariableTarget]::User)
    # }
}

function Show-Terminal-IconsDocs {
    # Logic to show app documentation
    Start-Process $repo
}

function Show-Terminal-IconsLogo {
    # Logic to show logo in terminal
}

function Show-Terminal-IconsReleases {
    # Logic to show release notes or changelog
    Start-Process "$repo/releases"
}

function Show-Terminal-IconsRepo {
    # Logic to show app repository
    Start-Process $repo
}

function Reset-Terminal-Icons {
    scoop reset $bucket/$appName
}

function Uninstall-Terminal-Icons {
    scoop uninstall $bucket/$appName
}

function Update-Terminal-Icons {
    scoop update $bucket/$appName
}

