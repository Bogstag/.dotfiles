using module DotfilesModule
# TODO: Finish
# Define a class for app-specific operations
class Nmap : App {
    [string] $Cache
    [string] $AppFolder
    [string] $Logo

    Nmap() : base(@{
            Name         = "Nmap" # CTRL+H Nmap with your specific app name, same as folder name
            Store        = "main"
            VerifyFile   = "$Env:SCOOP\apps\Nmap\current\Nmap.exe"
            Repo         = "https://svn.nmap.org/" # Replace RepoUrl with your specific repo URL
            Docs         = "https://nmap.org/book/man.html" # Replace DocsUrl with your specific docs URL
            ConfigFolder = "$Env:XDG_CONFIG_HOME\Nmap"
            ConfigFile   = ""
        }) {
        $this.Cache = "$Env:XDG_CACHE_HOME\Nmap"
        $this.AppFolder = $PSScriptRoot
        $this.Logo = @"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@@@@@@@@@@@@@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@%%###*********###%%@@@@@%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%@@@%%#*+=-::.............::--=+*#%@@@@%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%@@@%#*+--..                        .:-=*#%@@@%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%@@@%#+-:.. .     ........::::.....      . :.-=*#%@@%%%%%%%%%%%%%%%
%%%%%%%%%%%@@@%*+-.. . . .:.::-------------------:::.: .. . ::-+*%@@%%%%%%%%%%%%
%%%%%%%%@@@%#=-... . ...::::--:::::-----::...::::---::::... . ..:-+#%@@%%%%%%%%%
%%%%%%@@%*+::... ...::::...:::::::----====-::--::::::...::::... . .:-+#%@@%%%%%%
%%%%@@#+-... . ...::......:::.:::---+**+***+---:::::::......::::. . ..:=+%@@%%%%
%%@%*-:... ...:::... .....::...::::=*++-=++*+:::::.:::.....  ...::..  ..:-=#@@%%
%@#-:. ....:::.          .::...::::+*++-=++*+::::...::           .:::.....::=%@%
@%-::.:::::::             ......::::+**+***+-:::....:.             ::::::..::-%%
%%-::.--:::-:...           ......::::-=-==-::::....:.           ..::-:::-:.::=%%
%@%*++==--::::::::....      .:.....::::::::::.....:.      ..::::::::::-==++*#%%%
%%@@@@%%%%##*+=--:::::::...  ..:.......:::......:.. ...::::::::--++*#%%%%@@@@%%%
%%%%%%%%@@@@@@%%#*+--:::::::::.:::::........::::::::-::::::--+*#%@@@@@@%%%%%%%%%
%%%%%%%%%%%%%%%%@@@%#*=--::..::::::::::::::::::::::..::--+*#%@@@%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%@@@%@@@@@%#*+-::::..::::::::::...:::::-+*#%@@@@@@@%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%*+%#+**+%@#+*+==+===---=-::::--====+*+***#%%#+++*%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%+.-*--+.-*-.*#---#@+:*+:*####%*-*#*-#=:+=-#+-**++%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%@*-*=-+*-+-+-*+-+--%*:+++%@%%@@+-%@#-*+-+-=%=+%+==#@%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%+=*#=**=*#*=+=+#*=++=+*@@%*+%%%*+++*#+=*#++#+++++%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%@@%%%%%%%%@%%%@%%%%%%%%%%%%%@%%@@%%%%@@%@@%%%@%%%%%%%%%%%%%%%%
Network exploration and security auditing utility.
"@
    }

    # [void] Clear() {
    #     # Logic to clean app's cache or other maintenance tasks.
    # }

    # [void] CompareDotfiles() {
    #     # Logic to compare dotfiles with reference to see if something has changed.
    # }

    # [void] DeployDotfiles() {
    #     # Logic to get dotfiles to the right location, by copying or symlink.
    #     $this.AppDeployDotfiles($this.AppFolder)
    # }

    # [void] Enable() {
    #     # Logic to run in profile to import, dotsource or invoke app
    # }

    # [void] Install() {
    #     # Logic to install app
    # }

    # [void] Invoke() {
    #     # Logic to run the app.
    # }

    # [void] SetEnvironmentVariables() {
    #     # Logic to set app env variables
    #     $Value = ""
    #     if (($null -eq $Env:NMAPDIR ) -or ($Value -ne $Env:NMAPDIR )) {
    #         [Environment]::SetEnvironmentVariable("NMAPDIR ", "$Value", [EnvironmentVariableTarget]::User)
    #     }
    # }

    # [void] ShowDocs() {
    #     # Logic to show app documentation
    # }

    # [void] ShowLogo() {
    #     # Logic to show Logo
    # }

    # [void] ShowReleases() {
    #     # Logic to show release notes or changelog
    # }

    # [void] ShowRepo() {
    #     # Logic to show app repository
    # }

    # [void] Reset() {
    #     # Logic to reset app
    # }

    # [void] Uninstall() {
    #     # Logic to uninstall app
    #     # scoop uninstall "$($this.Store)/$($this.Name)"

    #     # Logic to unset env variables
    #     # if ($null -ne $Env:GIT_INSTALL_ROOT) {
    #         # [Environment]::SetEnvironmentVariable("GIT_INSTALL_ROOT", $null, [EnvironmentVariableTarget]::User)
    #     # }

    #     # Logic to remove dotfiles
    #     # Remove-Item -Path "$($this.ConfigFolder)\$($Dotfile).old" -Force -ErrorAction SilentlyContinue
    #     # Remove-Item -Path "$($this.ConfigFolder)\$($Dotfile)" -Force -ErrorAction SilentlyContinue
    # }

    [void] Update([string] $Version) {
        # Logic to update app
        scoop update "$($this.Store)/$($this.Name)"
        $this.Version = $Version
        $this.AppLastUpdate = [DateTime]::Now.ToString("yyyy-MM-dd")
        $this.UpdateSystemState()

        Write-Host "Starting SUDO install npcap"
        SUDO "$Env:SCOOP\apps\Nmap\current\npcap.exe"

        Write-Host "Adding Nmap registry"
        regedt32 "$Env:SCOOP\apps\Nmap\current\nmap_performance.reg"
    }

    # [void] UpdateSystemState([SystemState] $systemState) {
    # }
}
