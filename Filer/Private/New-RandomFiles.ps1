<#
.Synopsis
   Adds a bunch of random files to a folder.
.DESCRIPTION
   Adds a bunch of random files to a folder.  These files can then be moved around and used
   to test the folder split function.
.EXAMPLE
   New-RandomFiles
   Creates the default number of random files with random names in the current folder.
.EXAMPLE
   New-RandomFiles -Path '..\Folder'
   Creates random files in the Folder folder off of the parent path.
.EXAMPLE
   New-RandomFiles -Amount 20
   Creates 20 random files in the current path.	   
.NOTES
#>
function New-RandomFiles
{
    [CmdletBinding(PositionalBinding=$true)]
    Param
    (
        # Path to create the files in.
        [Parameter(Mandatory=$false,
                   Position=0)]
        $Path = '.',

        # Amount of files to create.
        [Parameter(Mandatory=$false)]
        $Amount = 2
    )

    Begin
    {
        if (-not (Test-Path $path)) {
            Throw "Path $Path not found!"
        }
        
        $FileList = [System.Collections.ArrayList]@()
    }
    Process
    {
        # Come up with a list
        $newFileName = ""
        1..10 | ForEach { $newFileName = $newFileName + [char]((Get-Random -Minimum 65 -Maximum 91) + (Get-Random -Maximum 2)*32) }; 
        $newFile = [PSCustomObject]@{ Filename = "$newFileName.txt"}
        $FileList.Add($newFile) > NULL

		try {
		}
		catch {
		}
    }
    End
    {
        # Return the list
        $rtn = $FileList
        return $rtn
    }
}