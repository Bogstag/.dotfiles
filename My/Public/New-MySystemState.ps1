function New-MySystemState {
    [cmdletbinding()]
    [OutputType([MySystemState])]
    param()
    return [MySystemState]::new()
}
