# Name folder to scoop app name
# CTRL + H $App$ -> Foldername
if ($null -eq $app.Name) {
    $app = Get-Item -Path $PSScriptRoot
}

$appName = $app.Name
$bucket = "main"
$verify = "$HOME\scoop\apps\$appName\current\$appName.exe"
$repo = "https://github.com/"

function Clear-$App$ {
    # Logic to clean apps cache or other maintenance tasks.
}

function Compare-$App$Dotfiles {
    # Logic to compare dotfiles with reference to see if something has changed.
}

function Deploy-$App$Dotfiles {
    # Logic to get dotfiles to the right location, by copying or symlink.
}

function Enable-$App$ {
    # Write-Host " ⏱️ $appName => " -NoNewline -ForegroundColor Green
    # Logic to run in profile to import, dotsource or invoke app
    # $totalTimeMs = $totalTimeMs + $t.Milliseconds
    # Write-Host $t.Milliseconds"ms" -ForegroundColor Green
}

function Install-$App$ {
    # Logic to install app
    if ($false -eq (Test-Path $HOME\scoop\buckets\$bucket -PathType Container)) {
        scoop bucket add $bucket
    }

    if ($false -eq (Test-Path $verify -PathType Leaf)) {
        scoop install $bucket/$appName
    }
}

function Invoke-$App$ {
    # Logic to run the app.
}

function Set-$App$EnvironmentVariables {
    # Logic to set app env variables
    # if ($null -eq $env:$app_ENV_VAR) {
    #     [Environment]::SetEnvironmentVariable("$app_ENV_VAR", "ENV_VAR_VALUE",[EnvironmentVariableTarget]::User)
    # }
}

function Show-$App$Docs {
    # Logic to show app documentation
    Start-Process $repo
}

function Show-$App$Logo {
    # Logic to show logo in terminal
}

function Show-$App$Releases {
    # Logic to show release notes or changelog
    Start-Process "$repo/releases"
}

function Show-$App$Repo {
    # Logic to show app repository
    Start-Process $repo
}

function Reset-$App$ {
    # Logic to reset app
    scoop reset $bucket/$appName
}

function Uninstall-$App$ {
    # Logic to uninstall app
    scoop uninstall $bucket/$appName
}

function Update-$App$ {
    # Logic to update app
    scoop update $bucket/$appName
}
