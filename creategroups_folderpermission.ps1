<#########################################################################
Scriptname:     creategroups.ps1
Function:       create AD groups for folderpermissions
Created at:     14.1.2023
Author:         THERAT84
Version:        1.0
Modifications:
#>
##########################################################################

#Variablen deklarieren
# Mögliche Gruppenpfade -> Letzte OU
# Systemgruppen","Dateiberechtigungsgruppen","Druckerzuweisung","Softwaregruppen","Outlookberechtigungsgruppen","Verteilerliste
$grouppath = "OU=Dateiberechtigungsgruppen,OU=Gruppen,OU=Global,OU=Customer,DC=contoso,DC=local"

$groups = Get-Content "C:\scripts\files\create_groups.txt"
$prefix = "GG_"
$sufix_R = "_R"
$sufix_RW = "_RW"

foreach ($group in $groups) 
{ 
    New-ADGroup -Name $prefix$group$sufix_R -SamAccountName $prefix$group$sufix_R -GroupCategory Security -GroupScope Global -DisplayName $prefix$group$sufix_R -Path $grouppath
    New-ADGroup -Name $prefix$group$sufix_RW -SamAccountName $prefix$group$sufix_RW -GroupCategory Security -GroupScope Global -DisplayName $prefix$group$sufix_RW -Path $grouppath  
}