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

curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/uninstall.ps1 > "uninstall.ps1" && cmd /c "uninstall.ps1"
powershell -ExecutionPolicy Bypass -File uninstall.ps1
