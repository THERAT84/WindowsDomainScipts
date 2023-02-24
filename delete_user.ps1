<#########################################################################
Scriptname:     delete_user.ps1
Function:       Delete user from AD, Exchange and remove 
                home, profile and usershared folders
Created at:     23.02.2023
Author:         THERAT84
Version:        1.0
Modifications:
#>
##########################################################################

$username = Read-Host "Enter loginname of the user to delete"

foreach($user in $username)
{
    $profilepath = Get-ADUser -Identity $user -Properties ProfilePath | Format-Table -Property ProfilePath -HideTableHeaders | Out-String 
    $homepath =  Get-ADUser -Identity $user -Properties HomeDirectory | Format-Table -Property HomeDirectory -HideTableHeaders | Out-String 
    #$usfpath =
    # Convert SMB Share Name to real path of the folders
    if ($profilepath -like '*profil*')
    {
       $DriveProfilePath = Get-SmbShare -Name "profil*" | Format-Table -Property Path -HideTableHeaders | Out-String -Stream
       $realUserProfilePath = Join-Path -Path $realProfilePath[1] -ChildPath \$user
    }
    if ($homepath -like '*home*')
    {
        $DriveHomePath = Get-SmbShare -name "home*" | Format-Table -Property Path -HideTableHeaders | Out-String -Stream
        $realUserHomePath = Join-Path -Path $realHomePath[1] -ChildPath \$user
    }
        foreach($pdir in $realUserProfilePath)
        {
            #$checkprofilepath = Test-Path $pdir
                if ($DriveProfilePath -contains $user)
                {
                    Set-Location -Path $DriveProfilePath
                    Remove-Item -Path $user -Force -Recurse 
                    Write-Host "User: $name Profilefolder at $pdir deleted" -BackgroundColor Green
                }
                else 
                {
                    Write-Host "User: $name Profile Folder doesnt exist" -BackgroundColor Red
                }
        }
        foreach($hdir in $realHomePath)
        {
            #$checkhomepath = Test-Path $hdir
                if ($checkhomepath -eq $true)
                {
                    Set-Location -Path $hdir
                    Remove-Item -Path $hdir -Force -Recurse
                    Write-Host "User: $name Homefolder at $hdir deleted" -BackgroundColor Green
                }
                else
                {
                    Write-Host "User: $name Home Folder doesnt exist" -BackgroundColor Red
                }
        }
    Remove-ADUser -Identity $user 
    Write-Host "User: $name deleted" -BackgroundColor Green
}
