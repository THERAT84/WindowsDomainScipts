<#########################################################################
Scriptname:     yearfolders_incl_subfolders.ps1
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
$path = @("021_Personalwesen\Taggelder")
$Quartal = @("1.Quartal","2.Quartal","3.Quartal","4.Quartal")
$subFolder = @("EO","Unfall","Krankheit","MSE")

foreach ($year in $years)
{
    foreach ($quart in $quartal)
    {
        foreach ($sub in $subFolder)
        {
            New-Item -ItemType Directory -Path "$LW$basepath\$path\$year\$sub"       
        }
    }
}

