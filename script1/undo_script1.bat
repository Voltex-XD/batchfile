@echo off
setlocal ENABLEDELAYEDEXPANSION
:: Verifică dacă rulează ca admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Scriptul nu rulează ca Administrator. Relansare cu drepturi elevate...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /B
)

REM Get current location
set SCRIPT_DIR=%~dp0

REM Go to file location
cd /d "%SCRIPT_DIR%"

curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/uninstall.ps1 > "uninstall.ps1"
curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/undo_uninstall.bat > "undo_uninstall.bat"
REM Verify if initialize.ps1 is installed correctly
findstr /i "404" uninstall.ps1 >nul
if %errorlevel%==0 (
    echo [!] Eroare: uninstall.ps1 nu a fost găsit sau GitHub a returnat 404.
    pause
    exit /B
)

REM Run powershell script
powershell -ExecutionPolicy Bypass -File uninstall.ps1

call undo_uninstall.bat
