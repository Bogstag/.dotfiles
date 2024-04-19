if ($null -eq $app.Name) {
    $app = Get-Item -Path $PSScriptRoot
}

$appName = $app.Name
$bucket = "main"
$verify = "$HOME\scoop\apps\$appName\current\$appName.exe"
$repo = "https://github.com/biomejs/biome"

function Clear-Biome {
    # Logic to clean apps cache or other maintenance tasks.
}

function Compare-BiomeDotfiles {
    # Logic to compare dotfiles with reference to see if something has changed.
}

function Deploy-BiomeDotfiles {
    # Logic to get dotfiles to the right location, by copying or symlink.
}

function Enable-Biome {
    # Logic to run in profile to import, dotsource or invoke app
}

function Install-Biome {
    # Logic to install app
    if ($false -eq (Test-Path $HOME\scoop\buckets\$bucket -PathType Container)) {
        scoop bucket add $bucket
    }

    if ($false -eq (Test-Path $verify -PathType Leaf)) {
        scoop install $bucket/$appName
    }
}

function Invoke-Biome {
    # Logic to run the app.
}

function Set-BiomeEnvironmentVariables {
    if ($null -eq $env:BIOME_BINARY) {
        [Environment]::SetEnvironmentVariable("BIOME_BINARY", $verify, [EnvironmentVariableTarget]::User)
    }

    if ($null -eq $env:BIOME_CONFIG_PATH) {
        [Environment]::SetEnvironmentVariable("BIOME_CONFIG_PATH", "$HOME\.config\biome\biome.json", [EnvironmentVariableTarget]::User)
    }
}

function Show-BiomeDocs {
    # Logic to show app documentation
    Start-Process "https://biomejs.dev/guides/getting-started/"
}

function Show-BiomeLogo {
    $widthLogo = 80
    $space = " " * (($host.ui.RawUI.WindowSize.Width - $widthLogo) / 2)
    Write-Host ""
    Write-Host $space"          -=" -ForegroundColor Blue
    Write-Host $space"         -**=              ......      .." -ForegroundColor Blue
    Write-Host $space"       .+****+.           +@@%%%%%#:  =%%." -ForegroundColor Blue
    Write-Host $space"       =====+++:          +@@.   #@@  -*+    :+++=:   :=-:++=: -++=:    .=+++-" -ForegroundColor Blue
    Write-Host $space"      ..:::. -**-         +@@%##%@@*  +@@. =%@#**@@#. +@@%*#@@@#*#@@+  *@%+=*@%-" -ForegroundColor Blue
    Write-Host $space"   :=+*****. +*+*=        +@@=---+@%- +@@ .@@=    %@# =@@.  *@%   #@% =@@#***%@@" -ForegroundColor Blue
    Write-Host $space" .+**+-.... -*+*+*=       +@@.   -@@+ +@@  %@#: .-@@+ +@@.  *@%   #@# :@@*-:-+=:" -ForegroundColor Blue
    Write-Host $space".**+- :=+++=+****+*+.     +@%%%%%%#=  =@%. .+%@%%@#-  =@%.  +@%   *@#  :*%%%%%+" -ForegroundColor Blue
    Write-Host $space"+*+*++************+**:        .               ...                         ..." -ForegroundColor Blue
    Write-Host $space"Formatter, linter, bundler, and more for JavaScript, TypeScript, JSON, HTML, Markdown, and CSS." -ForegroundColor Blue
    Write-Host ""
}

function Show-BiomeReleases {
    # Logic to show release notes or changelog
    Start-Process "$repo/releases"
}

function Show-BiomeRepo {
    # Logic to show app repository
    Start-Process $repo
}

function Reset-Biome {
    # Logic to reset app
    scoop reset $bucket/$appName
}

function Uninstall-Biome {
    scoop uninstall $bucket/$appName

    if ($null -eq $env:BIOME_BINARY) {
        [Environment]::SetEnvironmentVariable("BIOME_BINARY", $null, [EnvironmentVariableTarget]::User)
    }

    if ($null -eq $env:BIOME_CONFIG_PATH) {
        [Environment]::SetEnvironmentVariable("BIOME_CONFIG_PATH", $null, [EnvironmentVariableTarget]::User)
    }
}

function Update-Biome {
    # Logic to update app
    scoop update $bucket/$appName
}
