<#########################################################################

Skriptname:     AD_Prep.ps1
Funktion:       Anlegen der Basisstruktur in der AD
Erstellt am:    25.11.2014
Author:         THERAT84
Version:        1.0

Aenderungen:
23.3.2020       Fehler korrigiert
14.1.2023       Umbau Script 

#>
##########################################################################

# Struktur Global deklarieren
$sites = @("Global")

# OU Struktur Global deklarieren
$global = @("Laufwerke","Mitgliedserver","Gruppen","Benutzer","Gateway","Kontakte")

# Stuktur Global\Groups deklarieren
$globalgroups = @("Systemgruppen","Dateiberechtigungsgruppen","Druckerzuweisung","Softwaregruppen","Outlookberechtigungsgruppen","Verteilerliste")

# Struktur Standorte deklarieren
$locationOU = @("Benutzer","Notebook","Computer")

# Abfrage Domaenenname

$domainname = Read-Host "Geben Sie den Domaenennamen ein.(ohne TLD)"

# Abfrage TDL

$TLD = Read-Host "Geben Sie die TLD ein."

# Abfrage Name erste OU

$firstOU = Read-Host "Geben Sie den Namen der Ersten OU ein."


# Erstellung der OU's

New-ADOrganizationalUnit -Name $firstOU -Path "DC=$domainname,DC=$TLD"

# Abfrage Standorte

$arrayInput = @()
do {
$input = (Read-Host "Bitte geben Sie einen oder mehrere Standorte ein `num die eingabe zu beenden geben sie 'end' ein: ")
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

foreach ($ou in $global)
{
    New-ADOrganizationalUnit -Name $ou -Path "OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
}
# Unterstruktur Global\Gruppen erstellen

foreach ($ou in $globalgroups)
{
    New-ADOrganizationalUnit -Name $ou -Path "OU=Gruppen,OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
}
foreach ($location in $newarrayInput)
{
    
    foreach ($folder in $locationOU)
    {
        New-ADOrganizationalUnit -Name $folder -Path "OU=$location,OU=$firstOU,DC=$domainname,DC=$TLD"
    }
}
##################################################################################################

#Ordnerstruktur fuer Freigaben anlegen

#Abfrage Datenpfad

$Laufwerkspfad = Read-Host " Geben Sie den Laufwerksbuchstaben an auf dem die Struktur erstellt werden soll! z.B: D:\ "

# Abfrage Ueber-Ordner zb. DFS-Datenpool

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
