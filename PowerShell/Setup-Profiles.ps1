$profileDir = Split-Path -Parent $profile
$Profiles = Get-ChildItem -Path $PSScriptRoot\Profiles\

# TODO: Check if symlink
# $file = Get-Item "$profileDirScoop\profile.ps1" -Force -ea SilentlyContinue
# [bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint)
# Is true if symlink

# If Profile folder dont exist, create it.
if (-Not (Test-Path $profileDir -PathType Container)) {

    New-Item $profileDir -ItemType Directory
    #  -Force -ErrorAction SilentlyContinue

} else {

    # If there is a .old file there, remove them.
    # If there are existing file there, rename it to .old
    $Profiles |
        ForEach-Object {
            $oldFileName = "$($_.Name).old"
            Remove-Item -Path $profileDir\$oldFileName -Force -ErrorAction SilentlyContinue
            Rename-Item -Path $profileDir\$($_.Name) -NewName $oldFileName -Force -ErrorAction SilentlyContinue
        }
}

# Create Symlinks to profiles
$Profiles |
    ForEach-Object {
        New-Item -ItemType SymbolicLink -Path $profileDir\$($_.Name) -Target $($_.FullName) -Force
    }

# Special handeling for Scoop Pwsh Persistent profile.ps1
# TODO: This is not a good solution

# If Profile folder dont exist, create it.
$profileDirScoop = "$Env:SCOOP\apps\pwsh-beta\current"

if (Test-Path "$profileDirScoop\profile.ps1" -PathType Leaf) {

    Remove-Item -Path "$($profileDirScoop)\profile.ps1.old" -Force -ErrorAction SilentlyContinue
    Rename-Item -Path "$($profileDirScoop)\profile.ps1" -NewName "profile.ps1.old" -Force -ErrorAction SilentlyContinue
    New-Item -ItemType SymbolicLink -Path "$($profileDirScoop)\profile.ps1" -Target "$Env:dotfiles\PowerShell\Profiles\profile.ps1" -Force

}
