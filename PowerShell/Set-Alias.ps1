# ░░░█▀▀░█▀▀░▀█▀░░░░░█▀█░█░░░▀█▀░█▀█░█▀▀░
# ░░░▀▀█░█▀▀░░█░░▄▄▄░█▀█░█░░░░█░░█▀█░▀▀█░
# ░░░▀▀▀░▀▀▀░░▀░░░░░░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░

Write-Host " ⏱️ Alias => " -NoNewline -ForegroundColor Green

# There is some out commented "real" alias in this file.
# They are here to remind me its already taken.

# TODO: Make this a own module, so i can populate source

$t = Measure-Command {

    function Open-Recycle-Bin {
        explorer.exe Shell:RecycleBinFolder
    }

    Set-Alias -Name "trash" -Value "Open-Recycle-Bin" -Option ReadOnly -ErrorAction SilentlyContinue

    function Set-Location-Two-Times {
        Set-Location "..\.."
    }
    Set-Alias -Name "..." -Value "Set-Location-Two-Times" -Option ReadOnly -ErrorAction SilentlyContinue

    function Set-Location-Three-Times {
        Set-Location "..\..\.."
    }
    Set-Alias -Name "...." -Value "Set-Location-Three-Times" -Option ReadOnly -ErrorAction SilentlyContinue

    function Update-Package-Managers {
        Write-Host "🪟📦"
        winget upgrade --disable-interactivity
        Write-Host "🍨"
        scoop checkup
        scoop update
        scoop status
        Write-Host "💪🐚"
        Update-Module
        Update-Script
    }
    Set-Alias -Name "upm" -Value "Update-Package-Managers" -Option ReadOnly -ErrorAction SilentlyContinue

    function Update-Scoop {
        Scoop update
    }
    Set-Alias -Name "su" -Value "Update-Scoop" -Option ReadOnly -ErrorAction SilentlyContinue

    function Update-All-Scoop-Apps {
        Scoop update *
    }
    Set-Alias -Name "sua" -Value "Update-All-Scoop-Apps" -Option ReadOnly -ErrorAction SilentlyContinue
    # Set-Alias -Name sl -Value Set-Location

    function Show-Status-Scoop {
        Scoop status
    }
    Set-Alias -Name "ss" -Value "Show-Status-Scoop" -Option ReadOnly -ErrorAction SilentlyContinue

    Set-Alias -Name "oc" -Value $HOME\scoop\apps\onecommander\current\OneCommander.exe -ErrorAction SilentlyContinue

    # https://github.com/PhMajerus/ANSI-art
    function testtest1 {
        curl -s "https://raw.githubusercontent.com/PhMajerus/ANSI-art/main/TestPattern%20ANSI.ans"
    }
    Set-Alias -Name "testtest1" -Value "testtest1" -Option ReadOnly -ErrorAction SilentlyContinue
    function testtest2 {
        curl -s "https://raw.githubusercontent.com/PhMajerus/ANSI-art/main/Windows%20Terminal.ans"
    }
    Set-Alias -Name "testtest2" -Value "testtest2" -Option ReadOnly -ErrorAction SilentlyContinue
    function testtest3 {
        curl -s "https://raw.githubusercontent.com/PhMajerus/ANSI-art/main/WSL%20logo%20(UTF-8).txt"
    }
    Set-Alias -Name "testtest3" -Value "testtest3" -Option ReadOnly -ErrorAction SilentlyContinue
    function testtest4 {
        curl -s "https://raw.githubusercontent.com/PhMajerus/ANSI-art/main/TestPattern%2024-bit.ans"
    }
    Set-Alias -Name "testtest4" -Value "testtest4" -Option ReadOnly -ErrorAction SilentlyContinue
    function testtest5 {
        curl -s "https://raw.githubusercontent.com/PhMajerus/ANSI-art/main/Commodore%2064%20(80x25).ans"
    }
    Set-Alias -Name "testtest5" -Value "testtest5" -Option ReadOnly -ErrorAction SilentlyContinue
    function testtest6 {
        curl -s "https://raw.githubusercontent.com/PhMajerus/ANSI-art/main/Commodore%2064.ans"
    }
    Set-Alias -Name "testtest6" -Value "testtest6" -Option ReadOnly -ErrorAction SilentlyContinue
    function testtest7 {
        curl -s "https://raw.githubusercontent.com/PhMajerus/ANSI-art/main/Palettes/Commodore%2064.ans"
    }
    Set-Alias -Name "testtest7" -Value "testtest7" -Option ReadOnly -ErrorAction SilentlyContinue
    function testtest8 {
        curl -s "https://raw.githubusercontent.com/PhMajerus/ANSI-art/main/Palettes/VSCode.ans"
    }
    Set-Alias -Name "testtest8" -Value "testtest8" -Option ReadOnly -ErrorAction SilentlyContinue

    function testtest9 {
        curl -s "https://raw.githubusercontent.com/PhMajerus/ANSI-art/main/Palettes/Windows.ans"
    }
    Set-Alias -Name "testtest9" -Value "testtest9" -Option ReadOnly -ErrorAction SilentlyContinue
}
$totalTimeMs = $totalTimeMs + $t.Milliseconds
Write-Host $t.Milliseconds"ms" -ForegroundColor Green
