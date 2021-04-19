#region Clear-Host
Clear-Host
#endregion

#region _Blank

#endregion

#region Ausf�hrungsPfad ermitteln
$Scriptpath = Split-Path $script:MyInvocation.MyCommand.Path
#endregion

#region Start Variablen
$SystemName = "GNC-System_�berpr�fung"
$SystemAuthor = "Rainer G�rtner"
$SystemCopyright = "(c)2021 by Gabberloki GNC"
$SystemDate =  Get-Date -Format "dddd dd.MM.yyyy" 
$SystemTime =  Get-Date -Format "HH:mm:ss"
[int]$TimeToWait = "5"
#endregion

#region Pr�fen auf Admin Rechte
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
Write-Host "#                 $SystemDate $SystemTime               #"    -ForegroundColor Green
Write-Host "#                                                          #" -ForegroundColor Green
Write-Host "############################################################" -ForegroundColor Green
Write-Host " "
#endregion

#region _Blank
#$ComputerInfo = Get-ComputerInfo
Write-Host "Folgendes System wurde erkannt:"
Write-Host " "

Write-Host "Betriebssystem Architektur:......... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.OsArchitecture -ForegroundColor Green

Write-Host "Betriebtssystemn:................... " -ForegroundColor Cyan -NoNewline
Write-Host $ComputerInfo.WindowsProductName -ForegroundColor Green

Write-Host " "

#endregion
