# using module My
# using module My/My.ScoopApps.psm1

class Nmap : ScoopApps {

    Nmap() {
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

        $this.Name = "Nmap" # CTRL+H Nmap with your specific app name, same as folder name
        $this.Id = "Nmap"
        $this.PackageManager = "Scoop"
        $this.Store = "main"
        $this.VerifyFile = "$Env:SCOOP\apps\Nmap\current\Nmap.exe"
        $this.RepoUrl = "https://svn.nmap.org/" # Replace RepoUrl with your specific repo URL
        $this.DocsUrl = "https://nmap.org/book/man.html" # Replace DocsUrl with your specific docs URL
        $this.ChangeLogUrl = "" # TODO: Exists?
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
    }

    # [void] Clear() {}

    # [void] Enable() {}

    # [uri] GetRepoUri([string]$Switch) {}

    # [void] Install() {}

    # [void] Invoke() {}



    # [void] Reset() {}

    # [void] SetEnvironmentVariables() {
    #     # Logic to set app env variables
    #     $Value = ""
    #     if (($null -eq $Env:app_ENV_VAR) -or ($Value -ne $Env:app_ENV_VAR)) {
    #         [Environment]::SetEnvironmentVariable("app_ENV_VAR", "$Value", [EnvironmentVariableTarget]::User)
    #     }
    # }

    # [void] ShowDocs() {}

    # [void] ShowLogo() {}

    # [void] ShowReleases() {}

    # [void] ShowRepo() {}

    # [void] Uninstall() {}

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

    # [void] UpdateSystemState() {
    #     [GenericState].UpdateAppData($this.GetType(), $this)
    # }
}
[AppRunner]::makeApp("Nmap")

