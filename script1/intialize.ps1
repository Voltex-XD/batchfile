# Disabling "DisableRestrictedAdmin"
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "DisableRestrictedAdmin" -Value 0

# Stop the firewall
Set-NetFirewallProfile -Enabled False

# Activate RDP (Remote Desktop Protocol)
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

# Add user to RDP "Remote Desktop Users"
Add-LocalGroupMember -Group "Remote Desktop Users" -Member $env:USERNAME
