<#########################################################################
Skriptname:     DHCPPrep.ps1
Funktion:       Installation der DHCP Rolle und Konfiguration
Erstellt am:    18.03.2020
Author:         N.Viragh
Version:        1.0
Aenderungen:
#>
##########################################################################

# Fixe Variablen deklarieren

$start1 = "1"
$ende50 = "50"
$start51 = "51"
$ende79 = "79"
$start80 = "80"
$ende100 = "100"
$start201 = "201"
$ende230 = "230"
$start231 = "231"
$ende254 = "254"




Install-WindowsFeature DHCP -IncludeManagementTools
netsh dhcp add securitygroups
Restart-Service dhcpserver


# Konfiguration des DHCP Scopes
$Hostname = Read-Host "Geben Sie den Namen des Servers ein."
$Scopename = Read-Host "Geben Sie den Namen für den Scopebereich ein."
$Scopestart = Read-Host "Start des DHCP Scopes angeben."
$Scopeende = Read-Host "Ende des DHCP Scopes angeben."
$ScopeSNM = Read-Host "Subnetzmaske des Scopes angeben. zb. 255.255.255.0"
$ScopeID = Read-Host "Geben Sie die Netz ID ein. zb. 192.168.1.0"
$DNS = Read-Host "Geben Sie die IP des DNS Servers ein."
$GW = Read-Host "Geben Sie die IP des Gateways ein."
$domain = Read-Host "Geben Sie den Domänennamen ein."
$scopetemp = $scopeid.Substring(0,$scopeid.length -1)

Add-Dhcpserverv4Scope -name $Scopename -StartRange $Scopestart -EndRange $Scopeende -SubnetMask $ScopeSNM -State Active
Add-Dhcpserverv4ExclusionRange -ScopeID $ScopeID -Startrange $scopetemp$start1 -EndRange $scopetemp$ende50
Add-Dhcpserverv4ExclusionRange -ScopeID $ScopeID -Startrange $scopetemp$start51 -EndRange $scopetemp$ende79
Add-Dhcpserverv4ExclusionRange -ScopeID $ScopeID -Startrange $scopetemp$start80 -EndRange $scopetemp$ende100
Add-Dhcpserverv4ExclusionRange -ScopeID $ScopeID -Startrange $scopetemp$start201 -EndRange $scopetemp$ende230
Add-Dhcpserverv4ExclusionRange -ScopeID $ScopeID -Startrange $scopetemp$start231 -EndRange $scopetemp$ende254
Set-Dhcpserverv4OptionValue -OptionID 3 -Value $GW -ScopeID $ScopeID -ComputerName $Hostname
Set-Dhcpserverv4OptionValue -DNSDomain $domain -DnsServer $DNS
