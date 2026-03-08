#Creating a file
#[System.Environment]::GetFolderPath("userprofile") gives the user profile path like C:\Users\username
#We append \Downloads\ to it to get the Downloads folder path like C:\Users\username\Downloads\
$path=[System.Environment]::GetFolderPath("userprofile") + "\Downloads\"
#Check if the directory exists, if not create it
if (!(Test-Path -Path $path)){
    New-Item -Path $path -ItemType Directory | Out-Null
}
#join the path with the filename to get the full file path like C:\Users\username\Downloads\SystemInsightReport.txt
$reportfile= Join-Path -Path $path "SystemInsightReport.txt"
#Check if the file exists, if not create it, else get the existing file
if(!(Test-Path -Path $reportfile)){
    $file= New-Item -Path $reportfile -ItemType File
}
else {
    $file= Get-Item -Path $reportfile
}
# $path="C:\Users\$env:UserName\Downloads\"
# try {
#     $file= New-Item -path $path -name "report.txt" -itemtype "file" -ErrorAction Stop
# }
# catch {
#     "Error: $($_.Exception.Message)"
#     $file= Get-Item -Path ($path + "report.txt")
#     # "File already exists."
# }
$reporttext=@()
$reporttext += "==========System Status Report============" + "`n"
$reporttext += "----Generated on----" + "`n" + (Get-Date) + "`n" 
#Disk usage
$reporttext += "----Disk Usage----" 
$reporttext += Get-PSDrive -PSProvider 'fileSystem' | Select-Object Name,
             @{Name= "used(GB)"; Expression= {"{0:N2}" -f ($_.Used / 1GB)}},
#-f is format operator, Eg: "{0} and {1}" -f "Apple", "Banana" outputs "Apple and Banana"
#{0:N2} means: 0 → the first value, N → number formatting, 2 → show 2 decimal places
#Eg: "{0:N2}" -f 5.6789 outputs 5.68
             @{Name= "free(GB)"; Expression= {"{0:N2}" -f ($_.Free / 1GB)}} | Out-String
#CPU usage
$reporttext += "----CPU Usage----"
$reporttext += Get-CimInstance -ClassName Win32_Processor | Select-Object DeviceId, Name, LoadPercentage| Out-String
#Memory usage
$reporttext += "----Memory Usage----"
$reporttext += "Total RAM Memory: " + [System.Math]::Round((Get-CimInstance -ClassName Win32_OperatingSystem).TotalVisibleMemorySize/ 1MB, 2)
$reporttext += "Free RAM Memory: " + [system.math]::Round((Get-CimInstance -ClassName Win32_OperatingSystem).FreePhysicalMemory/ 1MB, 2)
#Alternative way to get memory usage
            # Select-Object @{Name="TotalVisibleMemory(GB)";Expression={"{0:N2}" -f ($_.TotalVisibleMemorySize / 1MB)}},
            # @{Name="FreePhysicalMemory(GB)";Expression={"{0:N2}" -f ($_.FreePhysicalMemory / 1MB)}} | Out-String
#calculate used memory
$totalMem= (Get-CimInstance -ClassName Win32_OperatingSystem).TotalVisibleMemorySize
$freeMem= (Get-CimInstance -ClassName Win32_OperatingSystem).FreePhysicalMemory
$usedMem= [System.Math]::Round($($totalMem - $freeMem)/ 1MB, 2)
$reporttext += "Used Memory:" + $usedMem
#calculate used memory percentage
$usedMemPercent= [System.Math]::Round((($totalMem - $freeMem) / $totalMem) * 100, 2)
$reporttext += "Used RAM Memory Percentage: $usedMemPercent"
#calculate free memory percentage
$freeMemPercent= [System.Math]::Round(($freeMem / $totalMem) * 100, 2)
$reporttext += "Free RAM Memory Percentage: $freeMemPercent" + "`n"
#Running processes
$reporttext += "----Top 5 Running Processes by Memory Usage----"
$reporttext += Get-Process | Sort-Object -Property WS -Descending | Select-Object -First 5 Name, Id, @{Name="Memory(MB)";Expression={"{0:N2}" -f ($_.WS / 1MB)}} | Out-String
#Running services
$reporttext += "----Running Services----" + "`n"
$runningservice = Get-Service -ErrorAction SilentlyContinue| Where-Object {$_.Status -eq 'Running'} | Select-Object -ExpandProperty Name
$reporttext += $runningservice -join ", "
$reporttext += "`n" + "============End of Report============="
$reporttext | Set-Content -Path $file.FullName
"Report generated at $($file.FullName)"
# Open the report file
Invoke-Item -Path $file.FullName