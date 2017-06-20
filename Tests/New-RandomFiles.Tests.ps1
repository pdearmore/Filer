$projectRoot = Resolve-Path "$PSScriptRoot\.."
. $projectRoot\Imp.ps1
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psm1")
$moduleName = Split-Path $moduleRoot -Leaf

Describe "New-RandomFiles" {
    It "Should throw an exception if the folder doesn't exist" {
        { New-RandomFiles -Path "ThisPathDoesNotExist" } | Should Throw
    }
}