$filePath = "$PSScriptRoot\sysinfo.ini"

$os = Get-CimInstance Win32_OperatingSystem
$cs = Get-CimInstance Win32_ComputerSystem
$cpu = Get-CimInstance Win32_Processor
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

$iniContent = @"
[SystemInfo]
ComputerName=$($cs.Name)
OS_Caption=$($os.Caption)
OS_Version=$($os.Version)
Architecture=$($os.OSArchitecture)

[Hardware]
Processor=$($cpu.Name)
TotalPhysicalMemory_GB=$([Math]::Round($cs.TotalPhysicalMemory / 1GB, 2))
Disk_C_Total_GB=$([Math]::Round($disk.Size / 1GB, 2))
Disk_C_Free_GB=$([Math]::Round($disk.FreeSpace / 1GB, 2))

[Report]
Timestamp=$(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
"@

$iniContent
