# Name folder to scoop app name
# Replace $App$ with folder name (CTRL+H)

$bucket = "main"
$app = "ScoopAppName"
$verify = "Path to exe or something else that can tell its installed"
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
    # Logic to run in profile to import, dotsource or invoke app
}

function Install-$App$ {
    # Logic to install app
    if ($false -eq (Test-Path $HOME\scoop\buckets\$bucket -PathType Container)) {
        scoop bucket add $bucket
    }

    if ($false -eq (Test-Path $verify -PathType Leaf)) {
        scoop install $bucket/$app
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
    scoop reset $bucket/$app
}

function Uninstall-$App$ {
    # Logic yo uninstall app
    scoop uninstall $bucket/$app
}

function Update-$App$ {
    # Logic to update app
    scoop update $bucket/$app
}
