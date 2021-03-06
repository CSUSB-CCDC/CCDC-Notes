clear
while ($true){
    foreach ($i in gps){
        $pn = $i.ProcessName
        if ((Get-Content wl.txt) -notcontains $pn){
            write-host $pn "| " -f red -n
            write-host (((Get-WmiObject -cl Win32_Process -f "name LIKE '$pn%'").getowner() | Select User).User)  -f red -n
            write-host " |" (Get-Date -f "HH:mm.ss") -f red
            gps $pn | kill -f
            sleep -s 1
        }
    }
}