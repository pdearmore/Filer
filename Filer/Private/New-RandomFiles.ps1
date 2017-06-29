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
    [CmdletBinding(PositionalBinding=$true,SupportsShouldProcess=$True)]
    Param
    (
        # Path to create the files in.
        [Parameter(Mandatory=$false,
                   Position=0)]
        $Path = '.'

        # Amount of files to create.
        , [Parameter(Mandatory=$false)]
        $Amount = 2

        , [Parameter(Mandatory=$false)]
        $FileNameLength = 8
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
        For ($i=0; $i -lt $Amount; $i++) {
            $newFileName = ""
            1..$FileNameLength | ForEach-Object { $newFileName = $newFileName + [char]((Get-Random -Minimum 65 -Maximum 91) + (Get-Random -Maximum 2)*32) }; 
            $newFile = [PSCustomObject]@{ Filename = "$newFileName.txt"}

            # Send "add" results to Out-Null so as not to add !@#% to the pipeline
            $FileList.Add($newFile) | Out-Null
        }

        if ($pscmdlet.ShouldProcess($computername))
        {
            Write-Debug "Should Process"
            $FileList | ForEach-Object {
                $fileName = Join-Path -Path $Path -ChildPath $_.Filename
                Write-Debug "Processing File: $fileName"
                New-Item $fileName -type file -force | Out-Null
            } | Out-Null
        }
        else {
            Write-Debug "Shouldn't process"
        }
    }
    End
    {
        # Return the list
        $rtn = $FileList
        return $rtn
    }
}