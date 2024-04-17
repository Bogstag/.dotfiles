$bucket = "main"
$app = "biome"
$verify = "$HOME\scoop\apps\biome\current\biome.exe"

function Clear-Biome {
    # Add cleaning logic here
}

function Compare-BiomeDotfiles {
    # Add Compare logic here
}

function Deploy-BiomeDotfiles {
    # Add setup logic for dotfiles here
}

function Install-Biome {
    if ($false -eq (Test-Path $HOME\scoop\buckets\$bucket -PathType Container)) {
        scoop bucket add $bucket
    }

    if ($false -eq (Test-Path $verify -PathType Leaf)) {
        scoop install $bucket/$app
    }
}

function Open-BiomeHomepage {
    # Add open home logic here
}

function Open-BiomeRepo {
    # Add open repo logic here
}

function Reset-Biome {
    # Add Reset logic her$e
}

function Set-BiomeEnvironmentVariables {
    if ($null -eq $env:BIOME_BINARY) {
        [Environment]::SetEnvironmentVariable("BIOME_BINARY", $verify, [EnvironmentVariableTarget]::User)
    }

    if ($null -eq $env:BIOME_CONFIG_PATH) {
        [Environment]::SetEnvironmentVariable("BIOME_CONFIG_PATH", "$HOME\scoop\persist\biome", [EnvironmentVariableTarget]::User)
    }
}

function Show-BiomeLogo {
    Write-Host ""
    Write-Host "          -=" -ForegroundColor Blue
    Write-Host "         -**=              ......      .." -ForegroundColor Blue
    Write-Host "       .+****+.           +@@%%%%%#:  =%%." -ForegroundColor Blue
    Write-Host "       =====+++:          +@@.   #@@  -*+    :+++=:   :=-:++=: -++=:    .=+++-" -ForegroundColor Blue
    Write-Host "      ..:::. -**-         +@@%##%@@*  +@@. =%@#**@@#. +@@%*#@@@#*#@@+  *@%+=*@%-" -ForegroundColor Blue
    Write-Host "   :=+*****. +*+*=        +@@=---+@%- +@@ .@@=    %@# =@@.  *@%   #@% =@@#***%@@" -ForegroundColor Blue
    Write-Host " .+**+-.... -*+*+*=       +@@.   -@@+ +@@  %@#: .-@@+ +@@.  *@%   #@# :@@*-:-+=:" -ForegroundColor Blue
    Write-Host ".**+- :=+++=+****+*+.     +@%%%%%%#=  =@%. .+%@%%@#-  =@%.  +@%   *@#  :*%%%%%+" -ForegroundColor Blue
    Write-Host "+*+*++************+**:        .               ...                         ..." -ForegroundColor Blue
    Write-Host "Formatter, linter, bundler, and more for JavaScript, TypeScript, JSON, HTML, Markdown, and CSS." -ForegroundColor Blue
    Write-Host ""
}

function Uninstall-Biome {
    # Add Uninstall logic here
}

function Update-Biome {
    # Add Update logic here
}
