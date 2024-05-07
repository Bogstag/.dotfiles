function New-State {
    [cmdletbinding()]
    [OutputType([State])]
    param()
    return [State]::new()
}

Export-ModuleMember -Function New-State
