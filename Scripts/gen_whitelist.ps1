#Only For Clean Environments!
$file = "C:\Users\$env:username\Desktop\wl.txt"
gps | % {$_.processname} | Out-File $file -en ascii -fo
Get-Content $file | sort -u | % {$_.TrimEnd()} | Set-Content $file -fo