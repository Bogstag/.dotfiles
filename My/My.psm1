using module ".\MySystemState.psm1"
using module ".\MyApp.psm1"
using module ".\MyApps.psm1"
using module ".\MyScoopApps.psm1"
using module ".\MyNoneApps.psm1"
using module ".\MyAppRunner.psm1"

# Define module-wide variable
# $Script:SystemStateJsonFile = ""

# Get-ChildItem -Path "$PSScriptRoot/Classes/*.ps1" | ForEach-Object {
#     . $_.FullName
# }

Get-ChildItem -Path "$PSScriptRoot/Functions/*.ps1" | ForEach-Object {
    . $_.FullName
}

Get-ChildItem -Path "$PSScriptRoot/Public/*.ps1" | ForEach-Object {
    . $_.FullName
}

# Define the types to export with type accelerators.
$ExportableTypes = @(
    [MySystemState],
    [MyApp],
    [MyApps],
    [MyScoopApps],
    [MyNoneApps],
    [MyAppRunner]
)

# Get the internal TypeAccelerators class to use its static methods.
$TypeAcceleratorsClass = [psobject].Assembly.GetType(
    'System.Management.Automation.TypeAccelerators'
)

# Ensure none of the types would clobber an existing type accelerator.
# If a type accelerator with the same name exists, throw an exception.
$ExistingTypeAccelerators = $TypeAcceleratorsClass::Get
foreach ($Type in $ExportableTypes) {
    if ($Type.FullName -in $ExistingTypeAccelerators.Keys) {
        $Message = @(
            "Unable to register type accelerator '$($Type.FullName)'"
            'Accelerator already exists.'
        ) -join ' - '

        throw [System.Management.Automation.ErrorRecord]::new(
            [System.InvalidOperationException]::new($Message),
            'TypeAcceleratorAlreadyExists',
            [System.Management.Automation.ErrorCategory]::InvalidOperation,
            $Type.FullName
        )
    }
}

# Add type accelerators for every exportable type.
foreach ($Type in $ExportableTypes) {
    $TypeAcceleratorsClass::Add($Type.FullName, $Type)
}

# Remove type accelerators when the module is removed.
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    foreach ($Type in $ExportableTypes) {
        $TypeAcceleratorsClass::Remove($Type.FullName)
    }
}.GetNewClosure()

Export-ModuleMember -Cmdlet * -Function * -Alias * -Variable *
