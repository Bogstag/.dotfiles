using module DotfilesModule

class Ruff : App {

    Ruff() : base(@{
            Logo            = @"
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
            Name            = "Ruff"
            Store           = "main"
            VerifyFile      = "$Env:SCOOP\apps\Ruff\current\ruff.exe"
            GithubOwnerRepo = "astral-sh/ruff"
            Docs            = "https://docs.astral.sh/ruff/configuration" # Replace DocsUrl with your specific docs URL
            CacheFolder     = "$Env:XDG_CACHE_HOME\Ruff"
            AppFolder       = "$PSScriptRoot"
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

    [void] UpdateSystemState([SystemState] $systemState) {
        $systemState.UpdateAppData($this.Name, $this)
    }
}
