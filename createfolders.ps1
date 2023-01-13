<#########################################################################
Skriptname:     createfolders.ps1
Funktion:       Erstellung Ordnerstruktur mit Textdatei
Erstellt am:    13.1.2023
Author:         N.Viragh
Version:        1.0
Aenderungen:
#>
##########################################################################
#Einlesen txt Datei
#Ordner in TXT müssen mit \ getrennt werden

$folders = Get-Content "C:\bla\bla\tmp\create_folders.txt"
foreach ($folder in $folders) {
    
    New-Item -ItemType Directory -Path "D:\DFS\Kundenname\$folder" 
}
