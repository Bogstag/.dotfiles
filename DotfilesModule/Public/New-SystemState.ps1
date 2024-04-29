function New-SystemState {
    [cmdletbinding()]
    [OutputType([SystemState])]
    param()
    return [SystemState]::new()
}
