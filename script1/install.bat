@echo off
setlocal ENABLEDELAYEDEXPANSION

REM Verify if python is installed
echo [*] Checking if Python is installed...
where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [!] Python is not installed.
    echo [*] Downloading Python automatically...
    powershell -Command "Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.12.2/python-3.12.2-amd64.exe -OutFile python_installer.exe"
    echo [*] Installing Python...
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1
    echo [*] Cleaning up installer...
    del python_installer.exe
    echo [*] Checking Python again...
    where python >nul 2>nul
    if %ERRORLEVEL% NEQ 0 (
        echo [!!] Python installation failed. Please install manually from https://www.python.org/
        pause
        exit /b
    )
)

echo [✓] Python is installed!

REM ==========================
REM Verify if pip installed
REM ==========================
where pip >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [*] Pip is not installed. Installing it...
    python -m ensurepip --upgrade
)

REM ==========================
REM Install necesary python libraries
REM ==========================
pip show boto3 >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [*] Installing boto3 package with pip...
    pip install boto3
)

pip show python-dotenv >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [*] Installing python-dotenv package with pip...
    pip install python-dotenv
)

REM 'os' este un modul nativ Python și nu trebuie instalat

echo [✓] All required Python libraries are installed!
