#region Clear-Host
Clear-Host
#endregion

#region _Blank

#endregion

#region AusführungsPfad ermitteln
$Scriptpath = Split-Path $script:MyInvocation.MyCommand.Path
#endregion

#region Start Variablen
$SystemName = "GNC-System_Überprüfung"
$SystemAuthor = "Rainer Gärtner"
$SystemCopyright = "(c)2021 by Gabberloki GNC"
$SystemDate =  Get-Date -Format "dddd dd.MM.yyyy" 
$SystemTime =  Get-Date -Format "HH:mm:ss"
[int]$TimeToWait = "5"
$Count = 0
#endregion

#region Prüfen auf Admin Rechte
$SystemRights = [Security.Principal.WindowsIdentity]::GetCurrent();
$UserIsAdmin = (New-Object Security.Principal.WindowsPrincipal $SystemRights).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
if ($UserIsAdmin -eq $false)
{
    Write-Host " "
    Write-Host " "
    Write-Host " "
    Write-Host " "
    Write-Host " "
    Write-Host " "
    Write-Host " "
    Write-Host "Das Scripte wurde ohne Administrative Privilegien gestartet." -ForegroundColor Red
    Write-Host "Die meisten Funktionen, haben somit kein Zugriff!" -ForegroundColor Red
    Write-Host "Bitte starten Sie das Script mit administrativen Privilegien!" -ForegroundColor Red
    Write-Host "Das Script wird in $TimeToWait Sekunden beendet!" -ForegroundColor Red
    
    for($i=0;$i -le $TimeToWait; $i++){

       $perzentcomplete = ($i / $TimeToWait) * 100
       Write-Progress -Activity "Script Ende in $i von $TimeToWait Sekunden!" -Status "noch $i Sekunden" -PercentComplete $perzentcomplete
       Start-Sleep -Seconds 1
    }
    Break Script
}
#endregion

#region IniDatei einlesen

#endregion

#region Header Ausgabe
Write-Host "############################################################" -ForegroundColor Green
Write-Host "#                                                          #" -ForegroundColor Green
Write-Host "#                   $SystemName                 #"            -ForegroundColor Green
Write-Host "#                       $SystemAuthor                     #"  -ForegroundColor Green
Write-Host "#                 $SystemCopyright                #"          -ForegroundColor Green
Write-Host "#                 $SystemDate $SystemTime              #"    -ForegroundColor Green
Write-Host "#                                                          #" -ForegroundColor Green
Write-Host "############################################################" -ForegroundColor Green
Write-Host " "
#endregion

#region _Blank
$ComputerInfo = Get-ComputerInfo
Write-Host "Folgendes System wurde erkannt:"
Write-Host " "

Write-Host "Hostanme:.......................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsDNSHostName -ForegroundColor Green

Write-Host "Registrierter Benutzer:............ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsRegisteredUser -ForegroundColor Green

Write-Host "Betriebssystem Architektur:........ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsArchitecture -ForegroundColor Green

Write-Host "Betriebtssystem:................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsName -ForegroundColor Green

Write-Host "Betriebssystem Version:............ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsVersion  -ForegroundColor Green

Write-Host "Betriebssystem Version:............ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsBuildNumber  -ForegroundColor Green

Write-Host "Installations Datum:............... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.WindowsInstallDateFromRegistry -ForegroundColor Green

Write-Host "Type der Machine:.................. " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.WindowsInstallationType -ForegroundColor Green

Write-Host "Bios Version:...................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.BiosSMBIOSBIOSVersion -ForegroundColor Green

Write-Host "Bios Datum:........................ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.BiosReleaseDate -ForegroundColor Green

Write-Host "Bios Build:........................ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.BiosFirmwareType -ForegroundColor Green

Write-Host "Boot Status:....................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsBootupState -ForegroundColor Green

Write-Host "CPU Daten:......................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsProcessors.Name -ForegroundColor Green

Write-Host "CPU Description:................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsProcessors.Description -ForegroundColor Green

Write-Host "CPU Socket:........................ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsProcessors.SocketDesignation -ForegroundColor Green

Write-Host "CPU Speed:......................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsProcessors.MaxClockSpeed  MHz"" -ForegroundColor Green

Write-Host "CPU Eco:........................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsProcessors.Availability -ForegroundColor Green

Write-Host "CPU Eco Mode:...................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.PowerPlatformRole -ForegroundColor Green

Write-Host "RAM Speicher:...................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsTotalPhysicalMemory -ForegroundColor Green

Write-Host "System läuft seid:................. " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsUptime -ForegroundColor Green

Write-Host "Boot Datum:........................ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsLastBootUpTime -ForegroundColor Green

Write-Host "System Role:....................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsDomainRole -ForegroundColor Green

Write-Host "System Sprache:.................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsLocale -ForegroundColor Green

Write-Host "Boot Partition:.................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsBootDevice -ForegroundColor Green

Write-Host "System Partition:.................. " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsSystemDevice -ForegroundColor Green

Write-Host "System Ordner:..................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsSystemDirectory -ForegroundColor Green

Write-Host "System Laufwerk:................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsSystemDrive -ForegroundColor Green

Write-Host "Windows Ordner:.................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsWindowsDirectory -ForegroundColor Green

Write-Host ""
Write-Host "##########################################################################################################################" -ForegroundColor DarkYellow
Write-Host ""

foreach ($item in $ComputerInfo.CsNetworkAdapters)
{
    $Count++
    Write-Host "Netzwerk Karte " $Count ": "
    Write-Host "Netzwerkkarten ID: " -ForegroundColor Green -NoNewline
    Write-Host $item.ConnectionID 
    Write-Host "Beschreibung " -ForegroundColor Green -NoNewline
    Write-Host $item.Description
    Write-Host "DHCP eingeschaltet? " -ForegroundColor Green -NoNewline
    Write-Host $item.DHCPEnabled
    Write-Host "Verbindungs Status " -ForegroundColor Green -NoNewline
    Write-Host $item.ConnectionStatus
    Write-Host "IP Adressen " -ForegroundColor Green -NoNewline
    Write-Host $item.IPAddresses 
    Write-Host ""
}
#endregion
