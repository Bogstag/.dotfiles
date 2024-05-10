# function New-AppFromConfig {
#     [CmdletBinding()]
#     param (
#         [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
#         [string] $AppName,

#         [Parameter(ValueFromPipelineByPropertyName = $true)]
#         [string] $SystemStateJsonFile = $Script:SystemStateJsonFile
#     )

#     process {
#         $config = Get-AppConfig -SystemStateJsonFile $SystemStateJsonFile

#         return New-App(
#             $config.AppData.$AppName.Name,
#             $null,
#             $config.AppData.$AppName.Store,
#             $config.AppData.$AppName.VerifyFile,
#             $config.AppData.$AppName.Repo,
#             $config.AppData.$AppName.Docs,
#             $config.AppData.$AppName.Dotfiles
#         )
#     }
# }

# Export-ModuleMember -Function New-AppFromConfig
