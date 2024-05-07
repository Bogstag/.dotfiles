function New-AppRunner {
    [cmdletbinding()]
    [OutputType([AppRunner])]
    param()
    return [AppRunner]::GetInstance()
}

Export-ModuleMember -Function New-AppRunner
