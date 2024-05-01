$PSNativeCommandUseErrorActionPreference = $true
# $PSNativeCommandArgumentPassing = "Windows"
# $PSNativeWindowsTildeExpansion = $true
$ErrorActionPreference = 'Stop'

Function Log {
    param(
        [Parameter(Mandatory = $true)][String]$msg,
        [Parameter(Mandatory = $false)][bool]$error = $false
    )
    $logFile = Join-Path -Path $env:USERPROFILE -ChildPath '.OneCommander.log'

    if ($error) {
        Add-Content $logFile $msg
        Write-Error $msg
    } else {
        Add-Content $logFile $msg
    }
}

Function SelectedFiles {
    if ([string]::IsNullOrEmpty($env:SELECTED_FILES)) {
        Log "   Error: Missing selected files" $true
    } else {
        return $env:SELECTED_FILES -split '\r?\n'  # Split non-empty strings into an array
    }
}

Function CurrentDir {
    if ([string]::IsNullOrEmpty($env:CURRENT_DIR)) {
        Log "   Error: Missing current directory" $true
    } else {
        return $env:CURRENT_DIR
    }
}
Function SelectedFilesInactive {
    if ([string]::IsNullOrEmpty($env:SELECTED_FILES_INACTIVE)) {
        Log "   Error: Missing selected files inactive" $true
    } else {
        return $env:SELECTED_FILES_INACTIVE -split '\r?\n'  # Split non-empty strings into an array
    }
}
Function CurrentDirInactive {
    if ([string]::IsNullOrEmpty($env:CURRENT_DIR_INACTIVE)) {
        Log "   Error: Missing current directory inactive" $true
    } else {
        return $env:CURRENT_DIR_INACTIVE
    }
}
