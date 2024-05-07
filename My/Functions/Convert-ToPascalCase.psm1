function ConvertTo-PascalCase {
    [OutputType('System.String')]
    param(
        [Parameter(Position = 0)]
        [string] $Value
    )

    return $Value -replace '(?:^|_)(\p{L})', { $_.Groups[1].Value.ToUpper() }
}

function ConvertTo-SnakeCase {
    [OutputType('System.String')]
    param(
        [Parameter(Position = 0)]
        [string] $Value
    )

    return [regex]::replace($Value, '(?<=.)(?=[A-Z])', '_').ToLower()
}

function ConvertTo-camelCase {
    [OutputType('System.String')]
    param(
        [Parameter(Position = 0)]
        [string] $Value
    )

    return $Value -replace '-(\p{L})', { $_.Groups[1].Value.ToUpper() }
}

function ConvertTo-SafePascalCase {
    [OutputType('string')]
    param(
        [Parameter(Position = 0)]
        [string] $Value
    )

    $newName = $Value

    # Remove Characters
    $newName = $newName -replace '#', ' '

    # Remove Hyphen with _
    $newName = $newName -replace '-', '_'

    # Remove @ with at
    $newName = $newName -replace '@', 'at'

    # and some more replacements......

    $newName = ConvertTo-PascalCase($newName)

    if ($Value -ne $newName) {
        Write-Host "Renaming: $Value to $newName"
    }
    return $newName
}

Export-ModuleMember -Function ConvertTo-PascalCase, `
    ConvertTo-SnakeCase, `
    ConvertTo-SafePascalCase, `
    ConvertTo-camelCase
