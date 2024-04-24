function Get-App {
    [cmdletbinding()]
    param(
        [ValidateSet('Biome', 'Terminal-Icons')]
        [string]$Type = 'Earth'
    )

    switch ($Type) {
        'Biome' {
            [Biome]::new()
        }
        'Terminal-Icons' {
            [TerminalIcons]::new()
        }
    }
}
