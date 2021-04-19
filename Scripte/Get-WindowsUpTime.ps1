
<#PSScriptInfo

.VERSION 1.3.5

.GUID ebc672ba-a2f9-48d1-85ff-aaf813d6d9cd

.AUTHOR saw-friendship

.COMPANYNAME 

.COPYRIGHT saw-friendship

.TAGS Windows WMI Remote UpTime StartTime Sytem

.LICENSEURI 

.PROJECTURI 

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


#>

<# 

.DESCRIPTION 
 Get Windows UpTime StartTime and LocalTime by Wmi on local and remote system

.LINK
 https://sawfriendship.wordpress.com/

.EXAMPLE
 Get-WindowsUpTime

.EXAMPLE
 Get-WindowsUpTime FileServer01 -Credential (Get-Credential)

.EXAMPLE
 Get-WindowsUpTime FileServer01,FileServer02
 
 .EXAMPLE
 Get-ClusterNode | Get-WindowsUpTime | ft
 

#> 

[CmdletBinding()]
	param(
		[Parameter(ValueFromPipelineByPropertyName=$true)][alias("DNSHostName","Name")]$ComputerName = '.',
		[PSCredential]$Credential
	)
	
	BEGIN {}
	
	PROCESS  {
		Foreach ($Comp in $ComputerName) {
			$param = @{
				'ComputerName' = $Comp
				'ErrorVariable' = 'WmiRequestError'
			}
			if($Credential -and ($Comp -notin @($env:COMPUTERNAME,'.'))){$param.Credential = $Credential}
				
			try{
				$OperatingSystem = Get-WmiObject -Class Win32_OperatingSystem @param
			} Catch {$WmiRequestError; break}
			
			if($OperatingSystem -and !$WmiRequestError){
				$LastBootUpTime = [System.Management.ManagementDateTimeconverter]::ToDateTime($OperatingSystem.LastBootUpTime)
				$LocalDateTime = [System.Management.ManagementDateTimeconverter]::ToDateTime($OperatingSystem.LocalDateTime)
				[pscustomobject][ordered]@{
					'ComputerName' = $OperatingSystem.CSName
					'UpTime' = $LocalDateTime - $LastBootUpTime
					'CurrentTimeZone' = $OperatingSystem.CurrentTimeZone/60
					'LastBootUpTime' = $LastBootUpTime
					'LocalDateTime' = $LocalDateTime
				}
			}
			$OperatingSystem = $Null
			$WmiRequestError = $Null
			$LastBootUpTime = $Null
			$LocalDateTime = $Null
			
		}
		
	}
	
	END {}

