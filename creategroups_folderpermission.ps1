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
# Mögliche Gruppenpfade -> Letzte OU
# Systemgruppen","Dateiberechtigungsgruppen","Druckerzuweisung","Softwaregruppen","Outlookberechtigungsgruppen","Verteilerliste
$grouppath = "OU=Dateiberechtigungen,OU=,OU=Rebstein,OU='Elektro Kleiner AG',DC=elektrokleiner,DC=local"

$groups = Get-Content "C:\scripts\files\create_groups.txt"
$prefix = "GG_"
$sufix_R = "_R"
$sufix_RW = "_RW"

foreach ($group in $groups) 
{ 
    New-ADGroup -Name $prefix+$group+$sufix_R -SamAccountName $group -GroupCategory Security -GroupScope Global -DisplayName $group -Path $grouppath
    New-ADGroup -Name $prefix+$group+$sufix_RW -SamAccountName $group -GroupCategory Security -GroupScope Global -DisplayName $group -Path $grouppath  
}