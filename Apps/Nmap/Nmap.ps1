using module DotfilesModule

class Nmap : App {

    Nmap() : base(@{
            Logo       = @"
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

            Name       = "Nmap" # CTRL+H Nmap with your specific app name, same as folder name
            Store      = "main"
            VerifyFile = "$Env:SCOOP\apps\Nmap\current\Nmap.exe"
            Repo       = "https://svn.nmap.org/" # Replace RepoUrl with your specific repo URL
            Docs       = "https://nmap.org/book/man.html" # Replace DocsUrl with your specific docs URL
            AppFolder  = "$PSScriptRoot"
        }) {
    }

    # [void] Clear() {}

    # [void] DeployDotfiles() {}

    # [void] Enable() {}

    # [uri] GetRepoUri([string]$Switch) {}

    # [void] Install() {}

    # [void] Invoke() {}

    # [void] RemoveDotfiles() {}

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

    [void] UpdateSystemState([SystemState] $systemState) {
        $systemState.UpdateAppData($this.Name, $this)
    }
}
