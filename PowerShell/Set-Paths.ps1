$timer = $State.MyStartMeasurement("Setting Paths")
# ░█▀▀░█▀▀░▀█▀░░░░░█▀█░█▀█░▀█▀░█░█░█▀▀
# ░▀▀█░█▀▀░░█░░▄▄▄░█▀▀░█▀█░░█░░█▀█░▀▀█
# ░▀▀▀░▀▀▀░░▀░░░░░░▀░░░▀░▀░░▀░░▀░▀░▀▀▀

# $DebugPreference = 'Continue'
# $DebugPreference = 'SilentlyContinue'

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
    }
}

function Remove-FromPSModulePath {
    param(
        [Parameter(Mandatory, Position = 0)]
        [array]$BannedDirs
    )
    $ErrorActionPreference = "Stop"

    $currentDirs = [array] (Get-ChildItem env:PSModulePath).Value -split ";" -ne ""

    $newDirs = Compare-Object -ReferenceObject $currentDirs -DifferenceObject $BannedDirs

    $newCleanPath = (($newDirs.InputObject.Trim().TrimEnd('\') | Sort-Object -Unique) -join ";").TrimStart(";")

    [Environment]::SetEnvironmentVariable("PSModulePath", $newCleanPath, [EnvironmentVariableTarget]::User)
}

Add-ToMyPath "$Env:dotfiles"
Add-ToMyPath "$Env:dotfiles" "PSModulePath"

Add-ToMyPath "$env:LOCALAPPDATA\Microsoft\PowerShell" "PSModulePath"
Add-ToMyPath "$ENV:LOCALAPPDATA\pnpm"

Add-ToMyPath "$HOME\.dotnet\tools"
Add-ToMyPath "$HOME\Documents\PowerShell"
Add-ToMyPath "$HOME\Documents\PowerShell\Modules" "PSModulePath"

Add-ToMyPath "$HOME\scoop\shims"
Add-ToMyPath "$HOME\scoop\apps\vscode-insiders\current"

Add-ToMyPath "C:\Program Files\PackageManagement\ProviderAssemblies" "PSModulePath"

Add-ToMyPath "C:\Windows\System32"

# Because i have symlinked this can not be in PSModulePath
Remove-FromPSModulePath @(
    "C:\Users\bogge\.dotfiles\Apps",
    "c:\program files\powershell\7-preview\Modules",
    "C:\Program Files\PowerShell\Modules",
    "C:\Program Files\WindowsPowerShell\Modules",
    "C:\Users\bogge\Documents\PowerShell\Modules",
    "C:\Windows\system32\WindowsPowerShell\v1.0\Modules",
    "C:\WINDOWS\System32\WindowsPowerShell\v1.0\Modules"
)

$State.MyStopMeasurement($timer)
