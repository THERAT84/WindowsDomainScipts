<#########################################################################

Skriptname:     AD_Prep.ps1
Funktion:       Anlegen der Basisstruktur in der AD
Erstellt am:    25.11.2014
Author:         N.Viragh
Version:        1.0

Aenderungen:
23.3.2020       Fehler korrigiert

#>
##########################################################################

# Variabeln deklarieren



# Abfrage Domänenname

$domainname = Read-Host "Geben Sie den Domänennamen ein.(ohne TLD)"

# Abfrage TDL

$TLD = Read-Host "Geben Sie die TLD ein."

# Abfrage Name erste OU

$firstOU = Read-Host "Geben Sie den Namen der Ersten OU ein."

# Erstellung der OU's

New-ADOrganizationalUnit -Name $firstOU -Path "DC=$domainname,DC=$TLD"

# Struktur Global 

New-ADOrganizationalUnit -Name "Global" -Path "OU=$firstOU,DC=$domainname,DC=$TLD"

New-ADOrganizationalUnit -Name "Laufwerke" -Path "OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Mitgliedserver" -Path "OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Gruppen" -Path "OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Benutzer" -Path "OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Gateway" -Path "OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Kontakte" -Path "OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"

# Unterstruktur Global\Gruppen erstellen

New-ADOrganizationalUnit -Name "Systemgruppen" -Path "OU=Gruppen,OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Dateiberechtigungsgruppen" -Path "OU=Gruppen,OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Druckerzuweisung" -Path "OU=Gruppen,OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Softwaregruppen" -Path "OU=Gruppen,OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Outlookberechtigungsgruppen" -Path "OU=Gruppen,OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"
New-ADOrganizationalUnit -Name "Verteilerliste" -Path "OU=Gruppen,OU=Global,OU=$firstOU,DC=$domainname,DC=$TLD"

# Abfrage Standortname

$standort = Read-Host "Geben Sie den Standortnamen ein."

# Struktur Standort anlegen

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
