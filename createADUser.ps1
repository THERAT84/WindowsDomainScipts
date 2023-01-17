<#########################################################################
Scriptname:     createADUser.ps1
Function:       Bulk create AD Users
Created at:     14.1.2023
Author:         THERAT84
Version:        1.0
Modifications:
#>
##########################################################################
# Declare Variables
$profilepath = Read-host "Enter Profile path like \\server\share: "
$homeletter = Read-host "Enter Driveletter for Homedrive like H:"
$userHome = Read-host "Enter UserHome path like \\server\share: "
$domain = Read-host "Enter Domainname contoso.local: "
#Enter a path to your import CSV file
$ADUsers = Import-csv C:\scripts\files\create_users.csv

foreach ($User in $ADUsers)
{

       $Username    = $User.username
       $Password    = $User.password
       $Firstname   = $User.firstname
       $Lastname    = $User.lastname
       $Department  = $User.department
       $OU          = $User.ou

       #Check if the user account already exists in AD
       if (Get-ADUser -F {SamAccountName -eq $Username})
       {
               #If user does exist, output a warning message
               Write-Warning "A user account $Username has already exist in Active Directory."
       }
       else
       {
              #If a user does not exist then create a new user account
          
        #Account will be created in the OU listed in the $OU variable in the CSV file; don’t forget to change the domain name in the"-UserPrincipalName" variable
              New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@$domain" `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -ChangePasswordAtLogon $false `
            -DisplayName "$Firstname $Lastname" `
            -Department $Department `
            -Path $OU `
            -HomeDrive $homeletter `
            -HomeDirectory "$userhome\$username" `
            -ProfilePath "$profilepath\$username" `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force)

       }
}