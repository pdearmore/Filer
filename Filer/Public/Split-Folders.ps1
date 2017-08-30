
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

        $filesInFolder = $null
        for ($i = 0; $i -lt $fileList.Length; $i++) {
            if ($filesInFolder -eq $null)
            {
                $filesInFolder = New-Object -TypeName PSObject
                $filesInFolder | Add-Member -MemberType NoteProperty -Name FileList -Value (New-Object System.Collections.Arraylist)
                $filesInFolder | Add-Member -MemberType NoteProperty -Name FolderName -Value ""
                $folderList.Add($filesInFolder)
            }
            $filesInFolder.FileList.Add($fileList[$i])
            if (($i+1) % $Amount -eq 0) {
                $filesInFolder = $null
            }
        }
        if ($filesInFolder -ne $null) {
            $folderList.Add($filesInFolder)
        }

        foreach ($folder in $folderList)
        {
            $folder.FolderName = $folder.FileList[0].Name + " - " + $folder.FileList[1].Name
            Write-Verbose $folder.FolderName
            foreach ($file in $folder)
            {
                #Write-Verbose "  $file"
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