$profileDir = Split-Path -Parent $profile
$Profiles = Get-ChildItem -Path $PSScriptRoot\Profiles\

# If Profile folder dont exist, create it.
if ($false -eq (Test-Path $profileDir -PathType Container)) {

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
