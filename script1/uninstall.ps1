# Activează din nou "DisableRestrictedAdmin"
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "DisableRestrictedAdmin" -Value 1

# Activează firewall-ul Windows
Set-NetFirewallProfile -Enabled True

# Dezactivează RDP (Remote Desktop Protocol)
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 1

# Scoate utilizatorul curent din grupul "Remote Desktop Users"
try {
    Remove-LocalGroupMember -Group "Remote Desktop Users" -Member $env:USERNAME -ErrorAction Stop
    Write-Host "Utilizatorul $env:USERNAME a fost eliminat din grupul 'Remote Desktop Users'."
} catch {
    Write-Warning "Nu s-a putut elimina utilizatorul $env:USERNAME din grup. Poate că nu era deja membru."
}
