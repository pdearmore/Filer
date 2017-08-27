
# Split-Folders
<#.Synopsis
Breaks large folders down into bite-sized sub folders.
.DESCRIPTION
Breaks large folders full of many files down into small subfolders named by the letters of the files
that have been broken down into them alphabetically.
.EXAMPLE
Split-Folders
Works on all files in the current directory.  Splits them out into their own subfolders. 
#>
function Split-Folders
{
    [CmdletBinding(PositionalBinding=$true,SupportsShouldProcess=$True)]
    Param
    (
        # Path to create the files in.
        [Parameter(Mandatory=$false,
                   Position=0)]
        $Path = '.'

        # Amount of files to try to put in each folder.
        , [Parameter(Mandatory=$false)]
        $Amount = 50
    )

    Begin
    {
        if (-not (Test-Path $path)) {
            Throw "Path $Path not found!"
        }
        
        $folderList = [System.Collections.ArrayList]@()
    }

    Process
    {
        $folderList = New-Object System.Collections.ArrayList
        $fileNameCharIndex = 0
        $testFileCount = 0
        $fileList = Get-ChildItem -Path $Path -File

        for ($i = 0; $i -lt $fileList.Lenth; $i++) {
            for ($j = 0; $j -lt $Amount; $j++) {
                # Bad logic -- rewrite this!!
            } 
        }

        if ($pscmdlet.ShouldProcess($computername))
        {
            Write-Debug "Should Process"
            $folderList | ForEach-Object {
                #$fileName = Join-Path -Path $Path -ChildPath $_.Filename
                #Write-Debug "Processing File: $fileName"
                #New-Item $fileName -type file -force | Out-Null
            } | Out-Null
        }
        else {
            Write-Debug "Shouldn't process"
        }
    }

    End
    {

    }
}