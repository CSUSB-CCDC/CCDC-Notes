netsh advfirewall reset
netsh advfirewall set allprofile state on
netsh advfirewall firewall set rule name=all new enable=no
netsh interface teredo set state disable
netsh interface ipv6 6to4 set state state=disabled undoonstop=disabled
netsh interface ipv6 isatap set state state=disabled