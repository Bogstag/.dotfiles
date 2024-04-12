function isAdmin {
    if (!(isElevated)) {
        Write-Host 'You need to be an Admin to run this script.'
        exit
    }
}

function isElevated {
    # Get the ID and security principal of the current user account
    $myIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $myPrincipal = New-Object System.Security.Principal.WindowsPrincipal($myIdentity)
    # Check to see if we are currently running "as Administrator"
    return $myPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Install-Scoop {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

function clone($repo, $directory) {
    git clone $repo $directory
}

$repo = "https://github.com/Bogstag/.dotfiles.git"

Write-Host "This will try to install your .dotfiles (Yes, it is not my anymore. I take no responsibility)" -ForegroundColor "Blue"

# Create a .dotfiles SymbolicLink in USERPROFILE
New-Item -ItemType "SymbolicLink" -Path "$env:USERPROFILE\.dotfiles" -Target "$PSScriptRoot"

# Invoke-Expression "$env:DOTFILES_PATH\Dotfiles.ps1";

Write-Host "Installation and configuration complete, please restart your device if needed and 🙏." -ForegroundColor "Blue"
