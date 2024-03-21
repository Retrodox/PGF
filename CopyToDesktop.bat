@echo off
echo 1. Fresh Image
echo 2. Troubleshoot Slow Computer
echo.
echo Please type in the number of the option you wish to select and then press enter:
set /p userchoice= 

if "%userchoice%"=="1" (
    xcopy ".\FRESH_IMAGE" "%UserProfile%\Desktop\FRESH_IMAGE" /E /I
    echo Once the folder is on your desktop please run the .bat file located within the folder copied to your desktop. Thanks and please enjoy! Jared Mingle made this.
) else if "%userchoice%"=="2" (
    xcopy ".\TROUBLESHOOT_SLOW_PC" "%UserProfile%\Desktop\TROUBLESHOOT_SLOW_PC" /E /I
    echo.
    echo Once the folder is on your desktop please run the .bat file located within the folder copied to your desktop. Thanks and please enjoy! Jared Mingle made this.
) else (
    echo Invalid choice. Please run the script again and choose 1 or 2.
)
