

class Ruff : ScoopApps {

    Ruff() {
        $this.Logo = @"
            ^;:;;;;;;;;;;;;;::::
         .''","""""""""""""",:::
         ,;;^               .;;;
         ";;^            ."""``'
         ,::`            `;;,
      "::`            '::,
      :II`          ''";;,''.
   ``^"^^.         ^I;;;;;;;:
   :;I.            .`''''^;::
   ::;'                  '::,
:::;;;;::::::         ';::
^"""""""",;;:.      ''^,,^
         .:::      ^II,
         .;;:   '"""``.
      .,,,'..   ";;^
      .II:   ":;^
    ''^,"^.''"",'
   `;;,   :II'
   `;::"""`''
   `;::;;;
An extremely fast Python linter.
"@
        $this.Name = "Ruff"
        $this.Id = "ruff"
        $this.MyPM = "Scoop"
        $this.Store = "main"
        $this.VerifyFile = "$Env:SCOOP\apps\Ruff\current\ruff.exe"
        $this.GithubOwnerRepo = "astral-sh/ruff"
        $this.DocsUrl = "https://docs.astral.sh/ruff/configuration" # Replace DocsUrl with your specific docs URL
        # $this.ChangeLogUrl = "https://api.github.com/repos/" + $this.GithubOwnerRepo + "/releases/latest"
        $this.CacheFolder = "$Env:XDG_CACHE_HOME\Ruff"
        $this.AppFolder = "$PSScriptRoot"
        $this.AppStatePath = "$($Env:dotfiles)\Apps\$($this.GetType())\$($this.GetType()).json"
    }

    # [void] Clear() {}

    # [void] Enable() {}

    # [uri] GetRepoUri([string]$Switch) {}

    # [void] Install() {}

    # [void] Invoke() {}



    # [void] Reset() {}

    [void] SetEnvironmentVariables() {
        # Logic to set app env variables
        $Value = $this.CacheFolder
        if (($null -eq $Env:RUFF_CACHE_DIR) -or ($Value -ne $Env:RUFF_CACHE_DIR)) {
            [Environment]::SetEnvironmentVariable("RUFF_CACHE_DIR", "$Value", [EnvironmentVariableTarget]::User)
        }
    }

    # [void] ShowDocs() {}

    # [void] ShowLogo() {}

    # [void] ShowReleases() {}

    # [void] ShowRepo() {}

    # [void] Uninstall() {}

    # [void] Update() {}

    # [void] UpdateSystemState() {
    #     [State].UpdateAppData($this.GetType(), $this)
    # }
}
[AppRunner]::InitApp("Ruff")
