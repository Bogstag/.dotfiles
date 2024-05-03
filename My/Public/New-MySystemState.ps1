function New-GenericState {
    [cmdletbinding()]
    [OutputType([GenericState])]
    param()
    return [GenericState]::new()
}
