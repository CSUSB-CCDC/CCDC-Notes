gps cmd | Stop-Process
Start-Process cmd.exe -ArgumentList "/k title DoNotClose"
$truecmd = (gps cmd).StartTime
while ($true){
    if (gps cmd | ? {$_.StartTime -gt $truecmd}){
        gps cmd | ? {$_.StartTime -gt $truecmd} | Stop-Process | Out-Null
        write-host "Killed cmd.exe @" (Get-Date -f "HH:mm.ss") -f red
    }
}