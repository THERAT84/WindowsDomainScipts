$username = read-host "Username?"

foreach ($user in $username)
{
    #$profile = get-aduser -Identity $user -Properties ProfilePath | ft -HideTableHeaders profilepath
    #$userhome = get-aduser -Identity $user -Properties HomeDirectory | ft -HideTableHeaders HomeDirectory
    Get-ADUser -Identity $user -Properties ProfilePath |where {$_.ProfilePath -like '*'}
    #Get-ADUser -Identity $user -Properties HomeDirectory |where {$_.HomeDirectory -like '*'}
    #$hdir = $user.HomeDirectory
    $pdir = $user.ProfilePath
    $name = $user.Name
        foreach($hdir in $hdir)
        {
            $checkhdir = test-path $hdir
                if($checkhdir -eq '$true')
                {
                    Remove-Item -Path $hdir -Force -Recurse

                else 
                        {
                        Write-Host "$name Home Folder doesnt exist" -BackgroundColor Red
                        }
                }
        }
    Get-ADUser -Identity $user -Properties HomeDirectory |where {$_.HomeDirectory -like '*'}
    $hdir = $user.HomeDirectory
    #$pdir = $user.ProfilePath
    $name = $user.Name
        foreach($hdir in $hdir)
        {
            $checkhdir = test-path $hdir
                if($checkhdir -eq '$true')
                {
                    Remove-Item -Path $hdir -Force -Recurse

                else 
                        {
                        Write-Host "$name Home Folder doesnt exist" -BackgroundColor Red
                        }
                }
        }



        foreach($phdir in $pdir)
        {
            $checkpdir = test-path $pdir
                if($checkpdir -eq '$true')
                {
                    Remove-Item -Path $pdir -Force -Recurse

                else 
                        {
                        Write-Host "$name Profile Folder doesnt exist" -BackgroundColor Red
                        }
                }
        }
        
    Remove-ADUser -Identity $user 
    Write-Host "$name User deleted" -BackgroundColor Green

}