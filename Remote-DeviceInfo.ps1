function Get-ComputerInfo {
    param (
        [string]$HostName
    )

    if (Test-Connection -ComputerName $HostName -Count 1 -Quiet) {
        $computerSystem = Get-WmiObject Win32_ComputerSystem -ComputerName $HostName
        $computerUser = Get-WmiObject -ComputerName $HostName -Class Win32_ComputerSystem | Select-Object UserName
        $computerBIOS = Get-WmiObject Win32_BIOS -ComputerName $HostName
        $computerOS = Get-WmiObject Win32_OperatingSystem -ComputerName $HostName
        $computerOSB = Get-WmiObject Win32_OperatingSystem -ComputerName $HostName
        $computerBLD = Get-WmiObject Win32_OperatingSystem -ComputerName $HostName
        $computerCPU = Get-WmiObject Win32_Processor -ComputerName $HostName
        $computerHDD = Get-WmiObject Win32_LogicalDisk -ComputerName $HostName -Filter "DeviceID='C:'"

        Write-Host "System Information for: $($computerSystem.Name)"
        $Manu = $computerSystem.Manufacturer
        $Model = $computerSystem.Model 
        $Serial = $computerBIOS.SerialNumber
        $User = $computerUser.UserName
        $CPU = $ComputerSystem.NumberOfProcessors
        $Cores = $ComputerSystem.NumberOfLogicalProcessors
        $HDD = "{0:N2}" -f ($computerHDD.Size/1GB) + "GB"
        $RAM = "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1GB) + "GB"
        $OS = $computerOS.caption 
        $OSB = $computerOSB.ConvertToDateTime(($computerOSB).InstallDate)
        $Username = $computerSystem.UserName

        # Additional details
        $computerBLD = Get-WmiObject Win32_OperatingSystem -ComputerName $HostName
        $OSBuild = $computerBLD.BuildNumber

        $LastBootUpTime = [System.Management.ManagementDateTimeConverter]::ToDateTime($computerOS.LastBootUpTime)
        $Uptime = (Get-Date) - $LastBootUpTime

        $Check = @{
            Manufacturer = $Manu
            Model = $Model
            SerialNumber = $Serial
            CPUs = $CPU
            Cores = $Cores
            HDD = $HDD
            RAM = $RAM
            OS = $OS
            InstallDate = $OSB
            UserName = $User
            OSBuild = $OSBuild
            Uptime = "$($Uptime.Days) days, $($Uptime.Hours) hours, $($Uptime.Minutes) minutes"
        }

        return $Check
    } else {
        Write-Host "Computer is offline."
        return $null
    }
}
$DeviceName = "Remote Device"  
$ComputerInfo = Get-ComputerInfo -HostName $DeviceName

if ($ComputerInfo) {
    $ComputerInfo | Format-Table
}