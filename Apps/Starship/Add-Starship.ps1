# 99% of all code here is from https://github.com/giggio/poshfiles

# function Invoke-Starship-PreCommand {
#     $loc = $executionContext.SessionState.Path.CurrentLocation
#     $prompt = "$([char]27)]9;12$([char]7)"
#     if ($loc.Provider.Name -eq "FileSystem") {
#         $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
#     }
#     $host.ui.Write($prompt)
# }

function Add-Starship {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingInvokeExpression', "", Scope = 'function', Justification = 'This is how you setup starship')]
    param()
    if (Get-Command starship -ErrorAction Ignore) {
        Invoke-Expression (&starship init powershell --print-full-init | Out-String)
    } else {
        Write-Output "Install Starship"
    }
}
Add-Starship
Remove-Item -Path Function:\Add-Starship

# if ($IsWindows -and (Get-Item Env:\WT_SESSION -ErrorAction SilentlyContinue) -and ($PSEdition -eq 'Core')) {
if ($IsWindows -and ($PSEdition -eq 'Core')) {
    # bellow script originally from these 2 places:
    # 1. https://learn.microsoft.com/windows/terminal/tutorials/shell-integration#powershell-pwshexe
    # 2. https://github.com/starship/starship/blob/885241114a933ae97820030cd28c97dc31670d3a/src/init/starship.ps1
    # more info: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_prompts

    function Initialize-Prompt {
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidGlobalVars', "", Scope = 'function', Justification = 'This is necessary for the prompt to work.')]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', "", Scope = 'function', Justification = 'This is a global var.')]
        param()
        Copy-Item Function:\prompt Function:\global:oldPrompt
        $Global:__LastHistoryId = -1
    }
    Initialize-Prompt
    Remove-Item -Path Function:\Initialize-Prompt

    function prompt {
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidGlobalVars', "", Scope = 'function', Justification = 'This is supposed to hide the function')]
        param()
        # First, emit a mark for the _end_ of the previous command.
        $originalDollarQuestion = $global:?
        $originalLastExitCode = $global:LASTEXITCODE
        $LastHistoryEntry = Get-History -Count 1
        # Skip finishing the command if the first command has not yet started
        if ($null -eq $LastHistoryEntry) {
            # Don't provide a command line or exit code if there is no history entry
            $out += "`e]133;D`a"
        } else {
            if ($LastHistoryEntry.Id -eq $Global:__LastHistoryId) {
                # Don't provide a command line or exit code if there was no history entry (eg. ctrl+c, enter on no command)
                $out += "`e]133;D`a"
            } else {
                $Global:__LastHistoryId = $LastHistoryEntry.Id
                $exitCode = $originalLastExitCode
                if ($exitCode -ne 0 -and $originalDollarQuestion) {
                    $exitCode = 0
                }
                $out += "`e]133;D;$exitCode`a"
            }
        }

        $loc = $($executionContext.SessionState.Path.CurrentLocation)

        # Prompt started
        $out += "`e]133;A$([char]07)"

        # CWD
        $out += "`e]9;9;`"$loc`"$([char]07)"

        # your prompt here:
        $global:LASTEXITCODE = $originalLastExitCode
        if ($global:? -ne $originalDollarQuestion) {
            if ($originalDollarQuestion) {
                # Simple command which will execute successfully and set $? = True without any other side affects.
                1 + 1
            } else {
                # Write-Error will set $? to False.
                # ErrorAction Ignore will prevent the error from being added to the $Error collection.
                Write-Error '' -ErrorAction 'Ignore'
            }
        }
        $out += oldPrompt

        # Prompt ended, Command started
        $out += "`e]133;B$([char]07)"

        return $out
    }
}

