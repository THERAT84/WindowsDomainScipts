<#########################################################################
Scriptname:     customerstructure.ps1
Function:       creates a skeletionstructure for each customerfolder
                from a template file 
Created at:     12.03.2025
Author:         THERAT84
Version:        1.0
Modifications:
#>
##########################################################################

$path = Read-host "Enter Folderpath like D:\DFS-Datenpool\Kundenname : "
#Einlesen txt Datei
#Ordner in TXT müssen mit \ getrennt werden
$folders = Get-Content "C:\scripts\files\customerskeleton.txt" -Encoding UTF8
foreach ($folder in $folders) {
    
    New-Item -ItemType Directory -Path "$path\$folder" 
}
