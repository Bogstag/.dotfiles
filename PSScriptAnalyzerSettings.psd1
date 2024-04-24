@{
    # Error
    Severity     = @('Error', 'Warning')

    # Analyze **only** the following rules. Use IncludeRules when you want
    # to invoke only a small subset of the default rules.
    # IncludeRules = @(
    #     'PSUseConsistentWhitespace',
    #     'PSUseConsistentIndentation',
    #     'PSAlignAssignmentStatement',
    #     'PSUseCorrectCasing',
    #     'PSAvoidTrailingWhitespace'
    # )
    # IncludeRules = @("PSAvoidDefaultValueSwitchParameter",
    #                  "PSMisleadingBacktick",
    #                  "PSMissingModuleManifestField",
    #                  "PSReservedCmdletChar",
    #                  "PSReservedParams",
    #                  "PSShouldProcess",
    #                  "PSUseApprovedVerbs",
    #                  "PSAvoidUsingCmdletAliases",
    #                  "PSUseDeclaredVarsMoreThanAssignments")

    # Do not analyze the following rules. Use ExcludeRules when you have
    # commented out the IncludeRules settings above and want to include all
    # the default rules except for those you exclude below.
    # Note: if a rule is in both IncludeRules and ExcludeRules, the rule
    # will be excluded.
    ExcludeRules = @(
        # 'PSAvoidUsingCmdletAliases',
        'PSAvoidUsingWriteHost',
        'PSUseBOMForUnicodeEncodedFile',
        'PSUseShouldProcessForStateChangingFunctions'
    )

    Rules        = @{
        PSUseConsistentWhitespace  = @{
            Enable         = $true
            CheckOpenBrace = $true
            CheckOpenParen = $true
            CheckOperator  = $false
            CheckSeparator = $true
        }

        PSUseConsistentIndentation = @{
            Enable          = $true
            Kind            = 'space' # or 'tab'
            IndentationSize = 4
        }

        PSAlignAssignmentStatement = @{
            Enable         = $true
            CheckHashtable = $true
        }

        PSAvoidTrailingWhitespace  = @{
            Enable = $true
        }

        PSUseCorrectCasing         = @{
            Enable = $true
        }
    }
}
