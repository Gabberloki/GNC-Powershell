#way 1
function Get-Uptime([String]$Computer = '.') {
  <#
    .DESCRIPTION
        Gets system uptime with Win32_PerfRawData_PerfOS_System class instead
        Win32_OperatingSystem class. Why? See
        http://msdn.microsoft.com/en-us/library/aa394239(v=vs.85).aspx
        for details.
    .NOTES
        Author: greg zakharov
  #>
  try {
    '{0:D2}:{1:D2}:{2:D2} up {3} day(s)' -f ($u =
      [TimeSpan]::FromSeconds((($wmi = (New-Object Management.ManagementClass(
        [Management.ManagementPath](
          '\\' + $Computer + '\root\cimv2:Win32_PerfRawData_PerfOS_System'
        )
      )).PSBase.GetInstances() | select Frequency_Object, SystemUpTime, `
      TimeStamp_Object).TimeStamp_Object - $wmi.SystemUpTime) / $wmi.Frequency_Object)
    ).Hours, $u.Minutes, $u.Seconds, $u.Days
  }
  catch {
    $_.Exception.InnerException
  }
}
#way 2
function Get-Uptime([String]$Computer = '.') {
  <#
    .DESCRIPTION
        Windows records the data of the last state in the registry, so you can
        use next trick:
        [DataTime]::FromFileTime(
          [BitConverter]::ToInt64(
            (gp HKLM:\SYSTEM\CurrentControlSet\Control\Windows).ShutdownTime, 0
          )
        )
        But note that there are some deviations (in minutes or seconds, or both)
        in the output.
    .NOTES
        Author: greg zakharov
  #>
  try {
    '{0:D2}:{1:D2}:{2:D2} up {3} day(s)' -f ($u = 
      (date) - [DateTime]::FromFileTime(
        [BitConverter]::ToInt64(
          (New-Object Management.ManagementClass(
            [Management.ManagementPath]('\\' + $Computer + '\root\default:StdRegProv')
          )).GetBinaryValue(
            2147483650, 'SYSTEM\CurrentControlSet\Control\Windows', 'ShutdownTime'
          ).uValue, 0
        )
      )
    ).Hours, $u.Minutes, $u.Seconds, $u.Days
  }
  catch {
    $_.Exception.InnerException
  }
}
#way 3
function Get-Uptime([String]$Computer = '.') {
  <#
    .DESCRIPTION
        This function demonstrates how you can use performnce counters to get
        uptime instead using WMI classes.
    .NOTES
        Author: greg zakharov
  #>
  try {
    $pc = New-Object Diagnostics.PerformanceCounter('System', 'System Up Time', $true)
    $pc.MachineName = $Computer
    [void]$pc.NextValue()
    '{0:D2}:{1:D2}:{2:D2} up {3} day(s)' -f (
      $u = [TimeSpan]::FromSeconds($pc.NextValue())
    ).Hours, $u.Minutes, $u.Seconds, $u.Days
  }
  catch {
    $_.Exception.InnerException
  }
}
#way 4
function Get-Uptime {
  <#
    .DESCRIPTION
        Just yet another possible way to get uptime on local machine. Note
        that there are some deviations in minutes or seconds.
    .NOTES
        Author: greg zakharov
  #>
  gci function:[a-z]: -n | % {
    if (Test-Path ($i = $_ + '\pagefile.sys')) {
      '{0:D2}:{1:D2}:{2:D2} up {3} day(s)' -f (
        $u = (date) - (gi $i -fo).LastWriteTime
      ).Hours, $u.Minutes, $u.Seconds, $u.Days
      break
    }
  }
}
#way 5
function Get-Uptime {
  <#
    .DESCRIPTION
        This works well only ~24,9 days. See
        http://msdn.microsoft.com/en-us/library/system.environment.tickcount(v=vs.110).aspx
        for details.
        Try to escape from using this method.
    .NOTES
        Author: greg zakharov
  #>
  '{0:D2}:{1:D2}:{2:D2} up {3} day(s)' -f (
    $u = [TimeSpan]::FromMilliseconds([Environment]::TickCount)
  ).Hours, $u.Minutes, $u.Seconds, $u.Days
}