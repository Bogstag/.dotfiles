# ░█▀▀░█▀▀░▀█▀░░░░░█▀█░█▀█░▀█▀░█░█░█▀▀
# ░▀▀█░█▀▀░░█░░▄▄▄░█▀▀░█▀█░░█░░█▀█░▀▀█
# ░▀▀▀░▀▀▀░░▀░░░░░░▀░░░▀░▀░░▀░░▀░▀░▀▀▀

Write-Host " ⏱️ Paths => " -NoNewline -ForegroundColor Green

# $DebugPreference = 'Continue'
$DebugPreference = 'SilentlyContinue'

$t = Measure-Command {
    function Add-ToMyPath {
        param(
            [Parameter(Mandatory, Position = 0)]
            [string]$LiteralPath,
            [Parameter(Position = 1)]
            [string]$Path = "Path"
        )
        $ErrorActionPreference = "Stop"

        if ((Test-Path $LiteralPath) -eq $false) {
            Write-Error "The path dont exist: $LiteralPath"
        }

        if ($Path -eq "Path") {
            $regPath = "registry::HKEY_CURRENT_USER\Environment"
            $currentPathDirs = (Get-Item -LiteralPath $regPath).GetValue("Path", "", "DoNotExpandEnvironmentNames") -split "; " -ne ""
        } else {
            $currentPathDirs = (Get-ChildItem env:${Path}).Value -split ";" -ne ""
        }

        if ($LiteralPath -in $currentPathDirs) {
            Write-Debug "Found LiteralPath: $LiteralPath in currentPathDirs: $currentPathDirs"
            return
        }
        Write-Debug "currentPathDirs: $currentPathDirs"

        $newPath = ($currentPathDirs + $LiteralPath) -join ";"
        Write-Debug "newPath: $newPath"

        $newCleanPath = ((($newPath -split ";").Trim().TrimEnd('\') | Sort-Object -Unique) -join ";").TrimStart(";")
        Write-Debug "newCleanPath: $newCleanPath"

        if ($Path -eq "Path") {
            Set-ItemProperty -Type ExpandString -LiteralPath $regPath Path $newCleanPath
            $Env:Path = $newCleanPath
        } else {
            [Environment]::SetEnvironmentVariable($Path, $newCleanPath, [EnvironmentVariableTarget]::User)
            # [Environment]::SetEnvironmentVariable($Path, $newPath, [EnvironmentVariableTarget]::User)
        }
    }

    # Add to Path
    Add-ToMyPath "$HOME\scoop\shims"
    Add-ToMyPath "$HOME\.dotnet\tools"
    Add-ToMyPath "$ENV:LOCALAPPDATA\pnpm"

    # Add to other Path
    Add-ToMyPath "$Env:dotfiles" "PSModulePath"
    Add-ToMyPath "$HOME\Documents\PowerShell\Modules" "PSModulePath"
    # Add-ToMyPath "C:\Program Files\Microsoft Azure AD Connect Authentication Agent\Modules\" "PSModulePath"
}
$ProfileLoadTime.Milliseconds += $t.Milliseconds
$ProfileLoadTime.Measurements += 1
Write-Host $t.Milliseconds"ms" -ForegroundColor Green


