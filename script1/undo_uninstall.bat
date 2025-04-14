@echo off
setlocal ENABLEDELAYEDEXPANSION

REM Get current location
set SCRIPT_DIR=%~dp0

REM Go to the file location
cd /d "%SCRIPT_DIR%"

del "undo_script1.bat"
del "uninstall.ps1"
REM Delete self after execution
del "%~f0"
