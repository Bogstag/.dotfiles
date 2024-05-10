using module ./My.State.psm1
$ErrorActionPreference = "Stop"
# $DebugPreference = 'Continue'

[NoRunspaceAffinity()]
class AppRunner {

    static [Hashtable] $Apps = @{}
    static [AppRunner] $Instance
    static [string] $Command
    static [IO.DirectoryInfo] $AppFolderRoot
    static [IO.DirectoryInfo[] ] $AppFolders
    static [object] $AppScriptFiles
    static [object] $AppJsonFiles

    static AppRunner() {
        if ($null -eq [AppRunner]::Instance) {
            [AppRunner]::Instance = [AppRunner]::new()
            # [AppRunner]::Apps = [Hashtable[]]::new()
            # [AppRunner]::AppsList = [List[object]]::new()
        }
    }

    # static [AppRunner] GetInstance() {
    #     if ($null -eq [AppRunner]::Instance) {
    #         [AppRunner]::Instance = [AppRunner]::new()
    #         # [AppRunner]::Apps = [Hashtable[]]::new()
    #         # [AppRunner]::AppsList = [List[object]]::new()
    #     }

    #     return [AppRunner]::Instance
    # }
    static [Int32] GetAppCount() {
        return [AppRunner]::Apps.Count
    }

    static [Object] getByType([String] $type) {
        return [AppRunner]::Apps.values | Where-Object { $_ -is $type }
    }

    static [Object] getByType([Object] $O) {
        return [AppRunner]::Apps.Where({ $_ -is $O })
    }

    static [Object] getByName([String] $Name) {
        return [AppRunner]::Apps.ForEach({ $_.Name -eq $Name })
    }

    static [void] LoadApps() {
        # Write-Host "LoadApps"
        [AppRunner]::AppFolderRoot = [IO.DirectoryInfo]::new("$Env:dotfiles\Apps")
        [AppRunner]::AppFolders = [AppRunner]::AppFolderRoot.GetDirectories()

        # Write-Host "AppScriptFile"
        [AppRunner]::AppScriptFiles = ([AppRunner]::AppFolders.GetFiles()).Where({ (($_.Extension -eq ".ps1") -And ($_.BaseName -eq $_.Directory.BaseName)) })
        foreach ($AppScriptFile in [AppRunner]::AppScriptFiles) {
            # Write-Host "Pretending to dot sourcing $($AppScriptFile.FullName) if $($AppScriptFile.BaseName)"
            # if ($AppScriptFile.BaseName -in @("AdvancedRenamer", "Biome", "CascadiaCode", "Git", "Gitleaks", "Nmap", "OneCommander", "PowerShellPreview", "PowerShellUniversal", "PSReadLine", "Ruff", "Scoop", "ScoopUnmanaged", "sfsu", "Starship", "TerminalIcons")) {
            . $AppScriptFile.FullName
            # }
        }

        # Write-Host "AppJsonFiles"
        [AppRunner]::AppJsonFiles = ([AppRunner]::AppFolders.GetFiles()).Where({ (($_.Extension -eq ".json") -And ($_.BaseName -eq $_.Directory.BaseName)) })
        # [AppRunner]::AppJsonFiles | ForEach-Object { [AppRunner]::LoadAppStateFromJsonFile($_.FullName) }

        foreach ($AppJsonFile in [AppRunner]::AppJsonFiles) {
            # Write-Host "Pretending to load state from json $($AppJsonFile.FullName)"
            [AppRunner]::LoadAppStateFromJsonFile($AppJsonFile)
        }

        # $Config = @{"$([AppRunner]::AppFolders.BaseName)" = @{
        #         "Name"         = [AppRunner]::AppFolders.BaseName
        #         "AppFolder"    = [AppRunner]::AppFolders.FullName
        #         "PSScriptPath" = [AppRunner]::AppScriptFiles.FullName
        #         "AppStateJson" = [AppRunner]::AppJsonFiles.FullName
        #     }
        # }
    }

    static [void] InitApp([String] $TypeString) {
        # Loads when app gets dot sourced
        # Write-Debug -Message "Init TypeString: $TypeString"
        # [AppRunner]::Apps = New-Object -TypeName $TypeString
        # Write-Debug -Message "Load Json TypeString: $TypeString"
        # [AppRunner]::LoadAppStateFromAppStateJson("$($TypeString)")
    }

    static [void] AllAppState([string]$Action) {
        switch ($Action) {
            'Save' {
                [AppRunner]::Apps.ForEach({ [AppRunner]::SaveAppState($_.Id) })
                break
            }

            'Load' {
                [AppRunner]::Apps.ForEach({ [AppRunner]::LoadAppState($_.Id) })
                break
            }
            Default {
                Write-Warning -Message "Action not found: $Action"
            }
        }
    }

    static [void] SaveAppState([String] $TypeString) {
        $json = [AppRunner]::Apps."$($TypeString)" | ConvertTo-Json -Depth 20
        $jsonFile = [AppRunner]::Apps."$($TypeString)".AppStateJson
        Write-Host $jsonFile
        Set-Content -Path $jsonFile -Value $json
    }

    static [void] LoadAppStateFromJsonFile([IO.FileInfo]$JsonFile) {
        if ($JsonFile.Exists) {
            try {
                # TODO: This dont work, they dont have add
                # [AppRunner]::Apps."$($JsonFile.Directory.BaseName)".Add([AppRunner]::LoadJsonFile($JsonFile))
            } catch {
                Write-Error "Failed to parse the system state JSON file. ($($JsonFile)) $_"
            }
        } else {
            Write-Warning "System state JSON file does not exist. Creating file and initializing with default values."
            $JsonFile.Create()
        }
    }

    static [void] LoadAppStateFromAppStateJson([String] $TypeString) {
        Write-Host "$([AppRunner]::Apps."$($TypeString)".AppStateJson)"
        $JsonFile = [IO.FileInfo]::new("$([AppRunner]::Apps."$($TypeString)".AppStateJson)")
        if ($JsonFile.Exists) {
            $App = [AppRunner]::Apps."$($TypeString)"
            Write-Host "App: $App"
            $Config = [AppRunner]::LoadJsonFile($JsonFile)
            Write-Host "Config: $Config"
            try {
                [AppRunner]::Apps."$($TypeString)" = New-Object -TypeName $TypeString.ToString() -Property @{
                    $Config = $Config."$($TypeString)"
                    $App    = $App."$($TypeString)"
                }
            } catch {
                Write-Error "Failed to parse the system state JSON file. ($($JsonFile))"
                Write-Error "$_"
                Get-Error
            }
        } else {
            Write-Warning "System state JSON file does not exist. Creating file and initializing with default values."
            $JsonFile.Create()
        }
    }

    static [Hashtable] LoadJsonFile([IO.FileInfo] $JsonFile) {
        $Hashtable = (Get-Content -Raw $JsonFile) | ConvertFrom-Json -AsHashtable -DateKind Local

        return $Hashtable
    }

    static [void] Command([object] $App, [string] $Command = $null ) {
        if ($null -ne $Command) {
            $Method = [AppRunner]::Command2Method($Command)
            [AppRunner]::Command = $Command

            If ($App -ne [AppRunner]::Apps.Name) {
                Write-Warning -Message "Cant find $($App), trying to reload it."
                [AppRunner]::LoadApps($App)
            }

            if ([AppRunner]::Apps["$($App)"].GetType().GetMethod("$($Method)")) {
                [AppRunner]::Execute($App, $Command)
            }
        }
    }

    static [void] CommandAll([string] $Command = $null) {
        if ($null -ne $Command) {
            [AppRunner]::Command = $Command
            foreach ($App in [AppRunner]::Apps) {
                [AppRunner]::Command($App, $Command)
            }
        }
    }

    static [string] Command2Method($Command = $null) {
        switch ($Command) {
            'load-all' { return '' }
            'clear-apps' { return 'Clear' }
            'compare-apps-dotfiles' { return 'CompareDotfiles' }
            'enable-apps' { return 'Enable' }
            'install-apps' { return 'Install' }
            'invoke-apps' { return 'Invoke' }
            'set-apps-environmentvariables' { return 'SetEnvironmentVariables' }
            'show-apps-docs' { return 'ShowDocs' }
            'show-apps-logo' { return 'ShowLogo' }
            'show-apps-releases' { return 'ShowReleases' }
            'show-apps-repo' { return 'ShowRepo' }
            'reset-apps' { return 'Reset' }
            'uninstall-apps' { return 'Uninstall' }
            'update-apps' { return 'Update' }
        }
        return "Command not found: $Command"
    }


    static [void] Execute($App, [string] $Command) {
        switch ($Command) {
            'load-all' {
                # Loading the classes, not running anything.
            }

            'clear-apps' {
                [AppRunner]::Apps[$App.Name].Clear()
            }

            'compare-apps-dotfiles' {
                [AppRunner]::Apps[$App.Name].CompareDotfiles()
            }

            'enable-apps' {
                if ([AppRunner]::Apps[$App.Name].GetType().GetMethod('Enable')) {
                    $stopWatch = [State]::MyStartMeasurement("Enable: $($App.Name)")

                    [AppRunner]::Apps[$App.Name].Enable()

                    [State]::MyStopMeasurement($stopWatch)
                }
            }

            'install-apps' {
                [AppRunner]::Apps[$App.Name].Install()
            }

            'invoke-apps' {
                [AppRunner]::Apps[$App.Name].Invoke()
            }

            'set-apps-environmentvariables' {
                if ([AppRunner]::Apps[$App.Name].GetType().GetMethod('SetEnvironmentVariables')) {
                    $stopWatch = [State].MyStartMeasurement("Set Env: $($App.Name)")

                    [AppRunner]::Apps[$App.Name].SetEnvironmentVariables()

                    [State].MyStopMeasurement($stopWatch)
                }
            }

            'show-apps-docs' {
                Write-Warning "Really show all docs including $([AppRunner]::Apps[$App.Name].Name)?" -BackgroundColor Red
                # $Apps[$AppFolder.Name].ShowDocs()
            }

            'show-apps-logo' {
                $windowWidth = $global:host.ui.RawUI.WindowSize.Width
                [AppRunner]::Apps[$App.Name].ShowLogo($windowWidth)
            }

            'show-apps-releases' {
                Write-Warning "Really show all releases including $([AppRunner]::Apps[$App.Name].Name)?" -BackgroundColor Red
                # $Apps[$AppFolder.Name].ShowReleases()
            }

            'show-apps-repo' {
                Write-Warning "Really show all repos including $([AppRunner]::Apps[$App.Name].Name)?" -BackgroundColor Red
                # $Apps[$AppFolder.Name].ShowRepo()
            }
            'reset-apps' {
                [AppRunner]::Apps[$App.Name].Reset()
            }

            'uninstall-apps' {
                Write-Warning "Really uninstall all app including $([AppRunner]::Apps[$App.Name].Name)?" -BackgroundColor Red
                # To proceed, uncomment the line below
                # $Apps[$AppFolder.Name].Uninstall()
            }

            'update-apps' {
                [AppRunner]::Apps[$App.Name].Update()
            }

            default {
                Write-Error "Command `$Command` not recognized or not implemented." -BackgroundColor Red
            }
        }
    }
}

# $AppRunner = [AppRunner]::GetInstance()
