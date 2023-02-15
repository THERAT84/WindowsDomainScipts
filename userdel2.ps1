$username = read-host "Username?"

foreach ($user in $username)
{
    #$profile = get-aduser -Identity $user -Properties ProfilePath | ft -HideTableHeaders profilepath
    #$userhome = get-aduser -Identity $user -Properties HomeDirectory | ft -HideTableHeaders HomeDirectory
    Get-ADUser -Identity $user -Properties ProfilePath |where {$user.ProfilePath -like '*'}
    Get-ADUser -Identity $user -Properties HomeDirectory |where {$user.HomeDirectory -like '*'}
    $hdir = $user.HomeDirectory
    $pdir = $user.ProfilePath
    $name = $user.Name
        foreach($dir in $hdir)
        {
            $checkhdir = test-path $dir
                if($checkhdir -eq '$true')
                {
                    Remove-Item -Path $dir -Force -Recurse

                else 
                        {
                        Write-Host "$name Home Folder doesnt exist" -BackgroundColor Red
                        }
                }
        }
        foreach($dir in $pdir)
        {
            $checkpdir = test-path $dir
                if($checkpdir -eq '$true')
                {
                    Remove-Item -Path $dir -Force -Recurse

                else 
                        {
                        Write-Host "$name Profile Folder doesnt exist" -BackgroundColor Red
                        }
                }
        }
        
    Remove-ADUser -Identity $user 
    Write-Host "$name User deleted" -BackgroundColor Green

}