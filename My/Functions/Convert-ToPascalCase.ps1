function Convert-ToPascalCase {
    param (
        [string]$inputString
    )
    $culture = [System.Globalization.CultureInfo]::InvariantCulture
    $textInfo = $culture.TextInfo

    $titleCaseString = $textInfo.ToTitleCase($inputString.ToLower())
    $pascalCaseString = $titleCaseString -replace '-', ''
    return $pascalCaseString
}

Export-ModuleMember -Function Convert-ToPascalCase
