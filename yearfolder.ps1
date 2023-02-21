$years = @(2002..2023)
$LW = "D:\"
$Basepath = "DFS-Datenpool\Kundenname"
$path = @("021_Personalwesen\Taggelder")
$Quartal = @("1.Quartal","2.Quartal","3.Quartal","4.Quartal")
$TG = @("EO","Unfall","Krankheit","MSE")

foreach ($year in $years)
{
    foreach ($quart in $quartal)
    {
     remove-item -Path "$LW$basepath\$path\$year\$TG" 
    }
}

