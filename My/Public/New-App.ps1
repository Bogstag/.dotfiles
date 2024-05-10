# function New-App {
#     [cmdletbinding()]
#     [OutputType([App])]
#     param(
#         [Parameter(Mandatory = $true)]
#         [hashtable] $Props,

#         [Parameter(Mandatory = $true)]
#         [ValidateSet('Scoop')]
#         [AppType] $Type
#     )

#     return [App]::new(
#         $Props,
#         $Type
#     )
# }

# Export-ModuleMember -Function New-App
