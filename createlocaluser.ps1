<#
.SYNOPSIS
  Create local admin account
.DESCRIPTION
  Creates a local administrator account on de computer. 
 .OUTPUTS 
  none
.NOTES
  Version:        1.0
  Author:         THERAT84 Copy from R.Mens at LazyAdmin.nl
  Creation Date:  10.03.2023
  Purpose/Change: Initial script development
#>
# Configuration
$username = "adminTest"   # Administrator is built-in name
$password = ConvertTo-SecureString "putyoursecurepasswordhereescape$" -AsPlainText -Force  # Super strong plane text password here (yes this isn't secure at all)
$logFile = "c:\log.txt"
Function Write-Log {
  param(
      [Parameter(Mandatory = $true)][string] $message,
      [Parameter(Mandatory = $false)]
      [ValidateSet("INFO","WARN","ERROR")]
      [string] $level = "INFO"
  )
  # Create timestamp
  $timestamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
  # Append content to log file
  Add-Content -Path $logFile -Value "$timestamp [$level] - $message"
}
Function Create-LocalAdmin {
    process {
      try {
        New-LocalUser "$username" -Password $password -FullName "$username" -Description "local admin" -ErrorAction stop
        Write-Log -message "$username local user created"
        # Add new user to administrator group
        Add-LocalGroupMember -Group "Administrators" -Member "$username" -ErrorAction stop
        Write-Log -message "$username added to the local administrator group"
      }catch{
        Write-log -message "Creating local account failed" -level "ERROR"
      }
    }    
}
Write-Log -message "#########"
Write-Log -message "$env:COMPUTERNAME - Create local admin account"
Create-LocalAdmin
Write-Log -message "#########"