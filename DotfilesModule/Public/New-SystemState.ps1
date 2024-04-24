function New-SystemState {
    [cmdletbinding()]
    param()
    return [SystemState]::new($Script:SystemStateJsonFile)
}
