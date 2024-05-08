@{
    # Error
    Severity     = @('Error', 'Warning')

    ExcludeRules = @(
        # 'PSAvoidUsingCmdletAliases',
        'PSAvoidUsingWriteHost',
        'PSUseBOMForUnicodeEncodedFile',
        'PSUseShouldProcessForStateChangingFunctions'
    )

    Rules        = @{
        s = @{
            PSPlaceOpenBrace           = @{
                Enable             = $true
                OnSameLine         = $true
                NewLineAfter       = $true
                IgnoreOneLineBlock = $true
            }

            PSPlaceCloseBrace          = @{
                Enable             = $true
                NewLineAfter       = $false
                IgnoreOneLineBlock = $true
                NoEmptyLineBefore  = $false
            }

            PSUseConsistentWhitespace  = @{
                Enable                                  = $true
                CheckInnerBrace                         = $true
                CheckOpenBrace                          = $true
                CheckOpenParen                          = $true
                CheckOperator                           = $true # $false
                CheckPipe                               = $true
                CheckPipeForRedundantWhitespace         = $false
                CheckSeparator                          = $true
                CheckParameter                          = $false
                IgnoreAssignmentOperatorInsideHashTable = $true
            }

            PSUseConsistentIndentation = @{
                Enable              = $true
                Kind                = 'space'
                PipelineIndentation = 'IncreaseIndentationForFirstPipeline'
                IndentationSize     = 4
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
}
