function Get-ComputerInfo {
    param (
        [string]$HostName
    )

    $computerSystem = Get-WmiObject Win32_ComputerSystem
    $computerUser = Get-WmiObject -Class Win32_ComputerSystem | Select-Object UserName
    $computerBIOS = Get-WmiObject Win32_BIOS
    $computerOS = Get-WmiObject Win32_OperatingSystem
    $computerOSB = Get-WmiObject Win32_OperatingSystem
    $computerBLD = Get-WmiObject Win32_OperatingSystem
    $computerCPU = Get-WmiObject Win32_Processor
    $computerHDD = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"

    Write-Host "System Information for: $($computerSystem.Name)"
    $Manu = $computerSystem.Manufacturer
    $Model = $computerSystem.Model 
    $Serial = $computerBIOS.SerialNumber
    $User = $computerUser.UserName
    $CPU = $ComputerSystem.NumberOfProcessors
    $Cores = $ComputerSystem.NumberOfLogicalProcessors
    $HDD = "{0:N2}" -f ($computerHDD.Size/1GB) + "GB"
    $RAM = "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1GB) + "GB"
    $OS = $computerOS.Caption 
    $OSB = $computerOSB.ConvertToDateTime(($computerOSB).InstallDate)
    $OSVersion = $computerOS.Version
    $Username = $computerSystem.UserName
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
        OSVersion = $OSVersion
        UserName = $User
        Uptime = "$($Uptime.Days) days, $($Uptime.Hours) hours, $($Uptime.Minutes) minutes"
    }

    return $Check
}

$ComputerInfo = Get-ComputerInfo

if ($ComputerInfo) {
    $ComputerInfo | Format-Table
}