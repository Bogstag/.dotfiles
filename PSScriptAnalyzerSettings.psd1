@{
    # Error
    Severity = @('Error', 'Warning')

    # Analyze **only** the following rules. Use IncludeRules when you want
    # to invoke only a small subset of the default rules.
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
    # ExcludeRules = @(
    #     "PSAvoidUsingWriteHost"
    # )
}
