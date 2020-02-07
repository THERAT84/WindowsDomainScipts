<#########################################################################
Skriptname:     Serverprep.ps1
Funktion:       Script zur Basiskonfiguration eines Servers
                Änderung Hostname und Netzwerkeinstellungen
Erstellt am:    7.2.2020
Author:         N.Viragh
Version:        1.0
Aenderungen:
#>
##########################################################################

$hostname = Read-Host "Geben Sie den Hostnamen an."

$IP = Read-Host "Geben Sie die IP an."

$SNM = Read-Host "Geben Sie die Subnetzmaske ein in Bit ein z.B: 24"

$Gateway = Read-Host "Geben Sie die Gatewayadresse ein"

$DNS1 = Read-Host "Geben Sie den ersten DNS an."

$DNS2 = Read-Host "Geben Sie den zweiten DNS an."

Rename-Computer -NewName $hostname

New-NetIPAddress -IPAddress $IP -DefaultGateway $Gateway -PrefixLength $SNM -InterfaceIndex (Get-NetAdapter).InterfaceIndex

Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).InterfaceIndex -ServerAddresses $DNS1,$DNS2

Restart-Computer
