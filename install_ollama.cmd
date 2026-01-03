@echo off
SETLOCAL

echo ==========================
echo Installing Ollama...
echo ==========================

:: Check if winget exists
where winget >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Winget is not installed. Please install App Installer from Microsoft Store first.
    pause
    exit /b 1
)

:: Install Ollama
winget install --id=Ollama.Ollama -e --silent
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to install Ollama.
    pause
    exit /b 1
)

:: Wait a bit for PATH update
timeout /t 5 >nul

:: Verify Ollama installation
ollama --version
IF %ERRORLEVEL% NEQ 0 (
    echo Ollama installation failed or command not found.
    pause
    exit /b 1
)

echo ==========================
echo Pulling model qwen3:14b...
echo ==========================
ollama pull qwen3:14b
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to pull model qwen3:14b
    pause
    exit /b 1
)

echo ==========================
echo Installing PyCharm...
echo ==========================
winget install --id=JetBrains.PyCharm.Community -e --silent
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to install PyCharm.
    pause
    exit /b 1
)

echo ==========================
echo All installations completed!
echo ==========================
pause
ENDLOCAL
