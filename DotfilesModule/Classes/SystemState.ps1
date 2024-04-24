# class SystemState {
#     [string] $SystemStateJsonFile = "$Env:dotfiles\SystemState-$Env:COMPUTERNAME.json"
#     [Hashtable] $AppData
#     [string] $LastProfileRunDate

#     SystemState() {
#         $this.AppData = @{}  # Ensure AppData is initialized to an empty hashtable by default

#         if (Test-Path $this.SystemStateJsonFile) {
#             try {
#                 $jsonData = Get-Content -Path $this.SystemStateJsonFile | ConvertFrom-Json
#                 if ($null -eq $jsonData.AppData) {
#                     $this.AppData = @{}
#                 } else {
#                     $this.AppData = $jsonData.AppData
#                 }
#                 $this.LastProfileRunDate = $jsonData.LastProfileRunDate
#             } catch {
#                 Write-Warning "Failed to parse the system state JSON file."
#                 $this.InitializeDefaults()
#             }
#         } else {
#             Write-Warning "System state JSON file does not exist. Initializing with default values."
#             $this.InitializeDefaults()
#         }
#     }

#     [void] InitializeDefaults() {
#         $this.AppData = @{}
#         $this.LastProfileRunDate = '1900-01-01'
#     }

#     [void] SaveState() {
#         $json = $this | ConvertTo-Json -Depth 5
#         Set-Content -Path $this.SystemStateJsonFile -Value $json
#     }

#     [void] UpdateAppData([string] $appName, [object] $appInstance) {
#         $data = @{}
#         $appInstance.GetType().GetProperties() | ForEach-Object {
#             $data[$_.Name] = $_.GetValue($appInstance)
#         }

#         if ($null -eq $this.AppData) {
#             $this.AppData = @{}
#         }

#         $this.AppData[$appName] = $data
#         $this.SaveState()
#     }

#     [bool] HasRunToday() {
#         if ($this.LastProfileRunDate -and ([DateTime]::Parse($this.LastProfileRunDate).Date -eq [DateTime]::Now.Date)) {
#             return $true
#         } else {
#             return $false
#         }
#     }

#     [void] UpdateLastRunDate() {
#         $this.LastProfileRunDate = [DateTime]::Now.ToString("yyyy-MM-dd")
#     }
# }
