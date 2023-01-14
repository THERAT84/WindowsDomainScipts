<#########################################################################
Scriptname:     creategroups.ps1
Function:       create AD groups for folderpermissions
Created at:     14.1.2023
Author:         N.Viragh
Version:        1.0
Modifications:
#>
##########################################################################

#Variablen deklarieren
$grouppath = "OU=Dateiberechtigungen,OU=Gruppen,OU=Global,OU=ElektroKleiner,DC=elektrokleiner,DC=local"

$groups = Get-Content "C:\scripts\files\create_groups.txt"
foreach ($group in $groups) {
    
    New-ADGroup -Name $group -SamAccountName $group -GroupCategory Security -GroupScope Global -DisplayName $group -Path $grouppath 
}