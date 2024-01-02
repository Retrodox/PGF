@echo off
echo 1. Disabling prelaunch of edge on startup, idle, and each time Microsoft Edge is closed.
echo.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v AllowPrelaunch /t REG_DWORD /d 0 /f
echo.
echo 2. Disabling ability for edge to start and load the Start / New Tab page at windows startup or each time edge is closed
echo.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v AllowTabPreloading /t REG_DWORD /d 0 /f
echo.
echo 3. Enabling the prevention of the "First time" run page from opening on Edge since it seems to happen EVERYTIME you first log in...
echo.
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v PreventFirstRunPage /t REG_DWORD /d 1 /f
echo.
echo Registry updated successfully.
echo.
pause
