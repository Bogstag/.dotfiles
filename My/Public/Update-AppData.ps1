function Update-AppData {
    [cmdletbinding()]
    [OutputType([App])]
    param(
        [Parameter(Mandatory = $true)]
        [hashtable] $AppInstance,

        [Parameter(Mandatory = $true)]
        [ValidateSet('Scoop')]
        [AppType] $AppType
    )
    New-Object -TypeName $($appFolder.Name)
    return [App]::new(
        $Props,
        $Type
    )
}

Export-ModuleMember -Function New-App
