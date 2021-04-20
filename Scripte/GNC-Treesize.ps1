#region Clear-Host
Clear-Host
#endregion

#region Script Variablen
$ScriptName = "CTN-Treesize"
$ScriptVersion = "3.0.1"
$MinPathGröße = "50" # Minimal Größe in MB die gefunden werden soll
$profilePfadCTN = "\\Na0-FS-01\tsprofiles$" 
$profilePfadOrbis = "\\ah0-fs-02\tsprofiles$"
$profilePfadHome = "G:\Spiele"
$FileDatum = Get-date -Format "_dd.MM.yyyy_HH_mm"
$dtmToday = Get-Date -Format "dd.MM.yyyy_HH:mm"
#endregion

#region Script Pfad und Log Pfad
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$LogPath = "$ScriptDir\LOG\"
$LogFile = "$ScriptDir\LOG\$ScriptName$FileDatum.log"
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

#region Header
    Write-Host "====================================================================" -ForegroundColor Green
    Write-Host "=                                                                  =" -ForegroundColor Green
    Write-Host "=                         $ScriptName $ScriptVersion                       =" -ForegroundColor Green
    Write-Host "=                    Copyrights by Rainer Gärtner                  =" -ForegroundColor Green
    Write-Host "=                           (c) 2021 DLCIT                         =" -ForegroundColor Green
    Write-Host "=                                                                  =" -ForegroundColor Green
    Write-Host "====================================================================" -ForegroundColor Green
    Write-Host ""
#endregion

#region Profile Server Auswahl
    Write-Host "Auf welchem Profile-Server soll der Vorgang durchgeführt werden?:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1:  $profilePfadCTN"
    Write-Host "2:  $profilePfadOrbis"
    Write-Host ""
    Write-Host "Bitte den Profile Server auswählen (default: $profilePfadOrbis): " -ForegroundColor Magenta -NoNewline
    $Server_Eingabe = Read-Host 
    Write-Host ""
    switch ($Server_Eingabe)
    {
        '1' {$ProfilePfad = $profilePfadCTN}
        '2' {$ProfilePfad = $profilePfadOrbis}
        '3' {$ProfilePfad = $profilePfadHome}
        Default {$ProfilePfad = $profilePfadOrbis}
    }
    Write-Host "Server wurde auf $ProfilePfad gesetzt!" -ForegroundColor Red
    Write-Host ""
    Write-Host "#############################################################################################"-ForegroundColor DarkGreen
    Write-Host ""
#endregion

#region Profile Server Auswahl
$profile = Get-ChildItem -Path $ProfilePfad
#endregion

#region Profile Server Auswahl
foreach ($item in $profile)
{
    $path = $item.FullName
    $test = Get-ChildItem -Path $path -Recurse -File -Force | Measure-Object -Property length -min -max -average -sum
    $count = ([Math]::round($test.Sum / 1MB, 2))
    if ($count -gt $MinPathGröße)
    {
        
        Write-Host $path -NoNewline
        Write-Host " " -NoNewline
        Write-Host " " -NoNewline
        Write-Host $count " MB im Profil"  -ForegroundColor Red  -NoNewline
        Write-Host " in " $test.Count "Dateien!"

        $ProfileCheckUser = Get-ChildItem -Path $path -Recurse -File -Force | Sort-Object -Property Length -Descending | Select-Object -Property * -First 10
        
        foreach ($item2 in $ProfileCheckUser)
        {
            $LengthinMB = ([Math]::round($item2.Length / 1MB, 2))
            
            Write-host $LengthinMB -NoNewline -ForegroundColor Red
            Write-host " MB - " -NoNewline -ForegroundColor white
            Write-Host $item2.Name -NoNewline -ForegroundColor Green
            Write-Host " - " -NoNewline -ForegroundColor White
            Write-host $item2.DirectoryName -ForegroundColor Gray -NoNewline
            Write-Host " - "($item2.FullName).Length " Zeichen" -ForegroundColor Yellow
        }
    }
    else
    {
        Write-Host $path -NoNewline -ForegroundColor DarkYellow
        Write-Host " " -NoNewline
        Write-Host " " -NoNewline
        Write-Host $count " MB im Profil" -ForegroundColor Green -NoNewline
        Write-Host " in " -NoNewline
        Write-Host $test.Count -NoNewline -ForegroundColor Magenta
        Write-Host " Dateien!" 
    }
    
}
#endregion


#out-file -FilePath $LogFile -InputObject $path -NoNewline
#out-file -FilePath $LogFile -InputObject " - " -NoNewline
#out-file -FilePath $LogFile -InputObject $ProfileCheckUser.Length -Append -NoNewline
#out-file -FilePath $LogFile -InputObject " - " -NoNewline



#region Debug Einstellung zurücksetzten
$DebugPreference = $DebugPreferenceOld
#$VerbosePreference = $VerbosePreferenceOld
#endregion

#region Zeit neu laden für Script Ende
$dtmToday = ((Get-Date).dateTime).tostring()
Write-Host "`nBeende $ScriptName $dtmToday `n"
#endregion

#region Logging beenden
Stop-Transcript -ErrorAction SilentlyContinue
#endregion 