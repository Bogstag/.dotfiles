using module DotfilesModule

class sfsu : App {

    sfsu() : base(@{
            Logo               = @"
░█▀▀░▀█▀░█░█░█▀█░▀█▀░█▀▄░░░█▀▀░█▀█░█▀▀░▀█▀░░░█▀▀░█▀▀░█▀█░█▀█░█▀█░░░█░█░▀█▀░▀█▀░█░░░█▀▀
░▀▀█░░█░░█░█░█▀▀░░█░░█░█░░░█▀▀░█▀█░▀▀█░░█░░░░▀▀█░█░░░█░█░█░█░█▀▀░░░█░█░░█░░░█░░█░░░▀▀█
░▀▀▀░░▀░░▀▀▀░▀░░░▀▀▀░▀▀░░░░▀░░░▀░▀░▀▀▀░░▀░░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░░░░░▀▀▀░░▀░░▀▀▀░▀▀▀░▀▀▀
"@
            Name               = "sfsu" # CTRL+H sfsu with your specific app name, same as folder name
            Store              = "extras"
            VerifyFile         = "$Env:SCOOP\apps\sfsu\current\sfsu.exe"
            GithubOwnerRepo    = "jewlexx/sfsu"
            Docs               = "https://github.com/jewlexx/sfsu" # Replace DocsUrl with your specific docs URL
            DotfilesSourcePath = "$PSScriptRoot"
            Dotfiles           = @(
                "$Env:XDG_CONFIG_HOME\sfsu\sfsu.json"
            )
            CacheFolder        = "$Env:XDG_CACHE_HOME\sfsu"
            AppFolder          = "$PSScriptRoot"
        }) {
    }

    # [void] Clear() {}

    [void] Enable() {
        # Handle changes to the function by save it to a file and use git to detect changes.
        & sfsu hook > "$($this.AppFolder)\sfsuHook.ps1"
        # Replacing Invoke-Expression (&sfsu hook)
        function global:scoop {
            switch ($args[0]) {
                'search' {
                    return sfsu.exe search @($args | Select-Object -Skip 1)
                }   'list' {
                    return sfsu.exe list @($args | Select-Object -Skip 1)
                }   'unused-buckets' {
                    return sfsu.exe unused-buckets @($args | Select-Object -Skip 1)
                }   'describe' {
                    return sfsu.exe describe @($args | Select-Object -Skip 1)
                }   'info' {
                    return sfsu.exe info @($args | Select-Object -Skip 1)
                }   'outdated' {
                    return sfsu.exe outdated @($args | Select-Object -Skip 1)
                }   'depends' {
                    return sfsu.exe depends @($args | Select-Object -Skip 1)
                }   'status' {
                    return sfsu.exe status @($args | Select-Object -Skip 1)
                }   'home' {
                    return sfsu.exe home @($args | Select-Object -Skip 1)
                }   'cat' {
                    return sfsu.exe cat @($args | Select-Object -Skip 1)
                }   'export' {
                    return sfsu.exe export @($args | Select-Object -Skip 1)
                }   'checkup' {
                    return sfsu.exe checkup @($args | Select-Object -Skip 1)
                } default {
                    scoop.ps1 @args
                }
            }
        }
    }

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

    # [void] Update() {}

    [void] UpdateSystemState() {
        [MySystemState].UpdateAppData($this.GetType(), $this)
    }
}
