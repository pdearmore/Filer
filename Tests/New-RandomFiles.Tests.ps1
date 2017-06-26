$projectRoot = Resolve-Path "$PSScriptRoot\.."
. $projectRoot\Imp.ps1
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psm1")
$moduleName = Split-Path $moduleRoot -Leaf

Describe "New-RandomFiles" {
    BeforeEach { 
        Get-ChildItem -Path '.\temp' -Include *.* -File -Recurse | foreach { $_.Delete()}
    }

    AfterEach { 
        Get-ChildItem -Path '.\temp' -Include *.* -File -Recurse | foreach { $_.Delete()}
    }

    It "Should throw an exception if the folder doesn't exist" {
        { New-RandomFiles -Path "ThisPathDoesNotExist" } | Should Throw
    }

    It "Should return a collection of two filenames" {
        $output = New-RandomFiles '.\temp' -Amount 2 
        $output.length | Should Be 2
    }

    It "Should return a collection of 20 filenames" {
        $output = New-RandomFiles '.\temp' -Amount 20 
        $output.length | Should Be 20
    }

    It "Should leave 20 files in the temp folder" {
        New-RandomFiles '.\temp' -Amount 20 
        ( Get-ChildItem '.\temp' | Measure-Object ).Count | Should Be 20
    }
    
}