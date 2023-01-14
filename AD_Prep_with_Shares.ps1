<#########################################################################

Skriptname:     AD_Prep.ps1
Funktion:       Anlegen der Basisstruktur in der AD
Erstellt am:    25.11.2014
Author:         N.Viragh
Version:        1.0

Aenderungen:
23.3.2020       Fehler korrigiert
14.1.2023       Umbau Script 

#>
##########################################################################

# OU Struktur Global deklarieren
$global = @("Laufwerke","Mitgliedserver","Gruppen","Benutzer","Gateway","Kontakte")

# Stuktur Global\Groups deklarieren
$globalgroups = @("Systemgruppen","Dateiberechtigungsgruppen","Druckerzuweisung","Softwaregruppen","Outlookberechtigungsgruppen","Verteilerliste")

# Struktur Global deklarieren
$sites = @("Global")

# Abfrage Domänenname

$domainname = Read-Host "Geben Sie den Domänennamen ein.(ohne TLD)"

# Abfrage TDL

$TLD = Read-Host "Geben Sie die TLD ein."

# Abfrage Name erste OU

$firstOU = Read-Host "Geben Sie den Namen der Ersten OU ein."


# Erstellung der OU's

New-ADOrganizationalUnit -Name $firstOU -Path "DC=$domainname,DC=$TLD"

# Abfrage Standorte

$arrayInput = @()
do {
$input = (Read-Host "Please enter the Array Value `n linie 2")
if ($input -ne '') {$arrayInput += $input}
}
#Loop will stop when user enter 'END' as input
until ($input -eq 'end')

$newarrayInput = @()
    foreach ($input in $arrayInput)
    {
        if ($input -ne "end")
        {
            $newarrayInput = $newarrayInput += $input
        }
    }
foreach ($location in $newarrayInput)
{
    New-ADOrganizationalUnit -Name $location -Path "OU=$firstOU,DC=$domainname,DC=$TLD"
} 
#$newarrayInput

# Struktur Global und Standort anlegen

foreach ($ou in $sites)
{
    New-ADOrganizationalUnit -Name $ou -Path "OU=$firstOU,DC=$domainname,DC=$TLD"
}

foreach ($ou in $globalfolders)
{
    New-ADOrganizationalUnit -Name $ou -Path "OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
}

# Unterstruktur Global\Gruppen erstellen

foreach ($ou in $globalgroups)
{
    New-ADOrganizationalUnit -Name $ou -Path "OU=Gruppen,OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
}

# Abfrage Standortname

$standort = Read-Host "Geben Sie den Standortnamen ein."

# Struktur Standort anlegen

New-ADOrganizationalUnit -Name $standort -Path "OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Benutzer" -Path "OU=$standort,OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Notebook" -Path "OU=$standort,OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Computer" -Path "OU=$standort,OU=$firstOU,DC=$domainname,DC=$TLD"

##################################################################################################

#Ordnerstruktur für Freigaben anlegen

#Abfrage Datenpfad

$Laufwerkspfad = Read-Host " Geben Sie den Laufwerksbuchstaben an auf dem die Struktur erstellt werden soll! z.B: D:\ "

# Abfrage Über-Ordner zb. DFS-Datenpool

$Ordnername = Read-Host " Geben Sie nun den ersten Ordnernamen an"

# Erstellung der Struktur

set-location -Path $Laufwerkspfad 

New-Item -Path $Laufwerkspfad -Name $Ordnername -ItemType directory
New-Item -Path $Laufwerkspfad$Ordnername -Name homes -ItemType directory
New-Item -Path $Laufwerkspfad$Ordnername -Name profiles -ItemType directory
New-Item -Path $Laufwerkspfad$Ordnername -Name SWInstall -ItemType directory
New-Item -Path $Laufwerkspfad$Ordnername -Name usersharedfolders -ItemType directory

# Erstellung der Freigaben der Ordner mit FullAccess Everyone

New-SmbShare $Laufwerkspfad$Ordnername\homes -Name homes$ -FullAccess jeder
New-SmbShare $Laufwerkspfad$Ordnername\profiles -Name profiles$ -FullAccess jeder
New-SmbShare $Laufwerkspfad$Ordnername\SWInstall -Name SWInstall$ -FullAccess jeder
New-SmbShare $Laufwerkspfad$Ordnername\usersharedfolders -Name usersharedfolders$ -FullAccess jeder
