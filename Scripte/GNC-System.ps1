#region Clear-Host
Clear-Host
#endregion

#region _Blank

#endregion

#region Start Variablen
$ScriptName = "GNC-System_Überpruefung"
$SystemName = "GNC-System_Überpruefung"
$ScriptVersion = "V1.1"
$SystemAuthor = "Rainer Gärtner"
$SystemCopyright = "(c)2021 by Gabberloki GNC"
$SystemDate =  Get-Date -Format "dddd dd.MM.yyyy" 
$SystemTime =  Get-Date -Format "HH:mm:ss"
$dtmToday = Get-Date -Format "dd.MM.yyyy_HH_mm_ss"
[int]$TimeToWait = "5"
$Count = 0
#endregion

#region Script Pfad und Log Pfad
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$LogPath = "$ScriptDir\LOG\"
$LogFile = "$ScriptDir\LOG\$ScriptName-$dtmToday.log"
#endregion


#region Ausgabe Einstellungen für dieses Script
$DebugPreferenceOld = $DebugPreference
$VerbosePreferenceOld = $VerbosePreference
$DebugPreference = "Continue" # Continue zeigt Debugmeldungen mit Write-Debug an - SilentlyContinue zeigt diese nicht an
$VerbosePreference = "Continue" # Continue zeigt Verbosemeldungen mit Write-Verbose n - SilentlyContinue zeigt diese nicht an
#endregion

#region Transcript Starten zum Aufzeichen des Scripts
Try { Start-Transcript -Path $Logfile -Append -ErrorAction Stop }
Catch { 
    "Fehler beim Versuch in Logdatei zu schreiben - versuche es noch mal..."
    Stop-Transcript -ErrorAction SilentlyContinue
    Try { Start-Transcript -Path $Logfile -Append -ErrorAction Stop}
    Catch {
        “Fehler beim Versuch in Logdatei $Logfile zu schreiben ($($Error[0])) - Das Programm wird beendet!`nVielleicht ist die Logdatei noch geöffnet. Oder der letzte Scriptlauf ist noch nicht beendet. Oft hilft hier ein Neustart der Powershell Administrator Sitzung.`nOder Ausführen von Stop-Transcript."
        Stop-Transcript -ErrorAction SilentlyContinue
        Exit
    } # Catch #2
} # Catch #1
Write-Host "`nStarte $dtmToday - Script $ScriptName $ScriptVersion`n"
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
Write-Host "#                   $SystemName                #"            -ForegroundColor Green
Write-Host "#                       $SystemAuthor                     #"  -ForegroundColor Green
Write-Host "#                 $SystemCopyright                #"          -ForegroundColor Green
Write-Host "#                 $SystemDate $SystemTime             #"    -ForegroundColor Green
Write-Host "#                                                          #" -ForegroundColor Green
Write-Host "############################################################" -ForegroundColor Green
Write-Host " "
#endregion

#region _Blank
$ComputerInfo = Get-ComputerInfo
Write-Host "Folgendes System wurde erkannt:"
Write-Host " "

Write-Host "Hostanme:.......................... " -ForegroundColor Cyan -NoNewline
Write-Host $env:COMPUTERNAME -ForegroundColor Green

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

Write-Host "Hersteller:........................ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsManufacturer -ForegroundColor Green

Write-Host "Modell:............................ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsModel -ForegroundColor Green

Write-Host "Systemname:........................ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsSystemFamily -ForegroundColor Green

Write-Host "Bios Version:...................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.BiosSMBIOSBIOSVersion -ForegroundColor Green

Write-Host "Bios Datum:........................ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.BiosReleaseDate -ForegroundColor Green

Write-Host "Bios Build:........................ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.BiosFirmwareType -ForegroundColor Green

Write-Host "Bios Status:....................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.BiosStatus -ForegroundColor Green

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

Write-Host "CPU HyperThreads:.................. " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsNumberOfLogicalProcessors -ForegroundColor Green

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

Write-Host "Thermal Status:.................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.CsThermalState -ForegroundColor Green

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

Write-Host "Vorhandene UserProfile:............ " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsNumberOfUsers -ForegroundColor Green

Write-Host "Anzahl der laufenden Prozesse:..... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsNumberOfProcesses -ForegroundColor Green

Write-Host "Verschlüsselungslevel:............. " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsEncryptionLevel -ForegroundColor Green

Write-Host "Fordergrund Application Boost:..... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsForegroundApplicationBoost -ForegroundColor Green

Write-Host "Zeitzone:.......................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.TimeZone -ForegroundColor Green

Write-Host "Logon Server:...................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.LogonServer -ForegroundColor Green

Write-Host ""
Write-Host "##########################################################################################################################" -ForegroundColor DarkYellow
Write-Host ""

foreach ($item in $ComputerInfo.CsNetworkAdapters)
{
    $Count++
    Write-Host "Netzwerk Karte " $Count ": " -ForegroundColor Yellow
    Write-Host "Netzwerkkarten ID: " -ForegroundColor Cyan -NoNewline
    Write-Host $item.ConnectionID -ForegroundColor Green
    Write-Host "Beschreibung " -ForegroundColor Cyan -NoNewline
    Write-Host $item.Description -ForegroundColor Green
    Write-Host "DHCP eingeschaltet? " -ForegroundColor Cyan -NoNewline
    Write-Host $item.DHCPEnabled -ForegroundColor Green
    Write-Host "Verbindungs Status " -ForegroundColor Cyan -NoNewline
    Write-Host $item.ConnectionStatus -ForegroundColor Green
    Write-Host "IP Adressen " -ForegroundColor Cyan -NoNewline
    Write-Host $item.IPAddresses -ForegroundColor Green
    Write-Host ""
}
#endregion

#region Debug Einstellung zurücksetzten
$DebugPreference = $DebugPreferenceOld
#$VerbosePreference = $VerbosePreferenceOld
#endregion

#region Zeit neu laden für Script Ende
$dtmToday = ((Get-Date).dateTime).tostring()
Write-Host "`nBeende $SystemName $dtmToday `n"
#endregion

#region Logging beenden
Stop-Transcript 
#endregion 