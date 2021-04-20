

$AthleteData = [xml](Get-Content C:\Users\gabbe\Documents\GitHub\GNC-Powershell\Scripte\file.xml)

$AthleteData.Athlete1rmData.Athlete.BenchPress

$Roster = New-Object System.Collections.Arraylist
foreach ($Athlete in $AthleteData.Athlete1RMData.Athlete)
{
  #Creates a new object that represents an athlete
  $AthObject = New-Object System.Object    
 
  #Adds properties to the object
  $AthObject | Add-Member -type NoteProperty -name LastName -value $Athlete.LastName
  $AthObject | Add-Member -type NoteProperty -name 1RMBench -value $Athlete.BenchPress
  $AthObject | Add-Member -type NoteProperty -name 1RMMilitary -value $Athlete.MilitaryPress
  $AthObject | Add-Member -type NoteProperty -name 1RMSquat -value $Athlete.Squat
 
  #Adds the object to our list
  $Roster.Add($AthObject)
}
Clear-Host

$Roster
