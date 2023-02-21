<#########################################################################
Scriptname:     yearfolders.ps1
Function:       creates folders in certain directorys
Created at:     21.2.2023
Author:         THERAT84
Version:        1.0
Modifications:
#>
##########################################################################

$years = @(2002..2023)
$LW = "D:\"
$Basepath = "DFS-Datenpool\Kundenname"
$path = @("021_Personalwesen\Taggelder","022_Test\Sub")

foreach ($year in $years)
{
    foreach ($folder in $path)
    {
        New-Item -ItemType Directory -Path "$LW$basepath\$folder\$year"    
    }   
}

