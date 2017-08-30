$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psm1")
$moduleName = Split-Path $moduleRoot -Leaf

Describe "Split-Folders" {

    It "Should create a bunch of folders" {
        $output = Split-Folders '..\Examples\HundredFiles' -Amount 2 
        #$output.length | Should Be 2
    }

}