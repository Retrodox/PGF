@echo off
cls

set "hpiaPath=C:\SWSetup\SP151464\HPImageAssistant.exe"
powershell -Command "& {if (Test-Path '%hpiaPath%') {(Get-Item '%hpiaPath%').VersionInfo.ProductVersion} else {echo 'Not Installed'}}" > temp.txt
set /p hpiaVersion=<temp.txt
del temp.txt

if "%hpiaVersion%"=="Not Installed" (
	echo.
    echo HP Image Assistant is not installed.
) else (
	echo.
    echo HP Image Assistant is already installed. Version: %hpiaVersion%
)

:question1
echo.
echo Do you want to install HP Image Assistant Version 5.2.1? (Y/N)?
echo.
set /p hpiaInput=
if /I "%hpiaInput%"=="y" goto installHPImageAssistant
if /I "%hpiaInput%"=="yes" goto installHPImageAssistant
goto skipHPImageAssistant

:installHPImageAssistant
echo.
echo Starting the HP Image Assistant installer...
:: Use a relative path for the HP Image Assistant installer
start "" ".\DownloadStuff\hp-hpia-5.2.1.exe"
goto question2

:skipHPImageAssistant
echo.
echo Skipping HP Image Assistant installation.
goto question2

:question2
echo.
echo Checking current version of Google Chrome...

:: Initialize chromeVersion variable
set "chromeVersion="

:: Check in Program Files
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    PowerShell -Command "(Get-Item 'C:\Program Files\Google\Chrome\Application\chrome.exe').VersionInfo.ProductVersion" > "%temp%\chromeVersion.txt"
    set /p chromeVersion=<"%temp%\chromeVersion.txt"
    del "%temp%\chromeVersion.txt"
)

:: Check in Program Files (x86) if not found in Program Files
if not defined chromeVersion (
    if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" (
        PowerShell -Command "(Get-Item 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe').VersionInfo.ProductVersion" > "%temp%\chromeVersion.txt"
        set /p chromeVersion=<"%temp%\chromeVersion.txt"
        del "%temp%\chromeVersion.txt"
    )
)

:: Display version or error message
if defined chromeVersion (
    echo.
    echo Current version of Google Chrome: %chromeVersion%
) else (
    echo.
    echo Unable to determine the current version of Google Chrome.
)
:: Ask to update Chrome
echo. 
echo Your district's current version of Chrome is Version 119.0.6045.200 (Official Build) (64-bit)
echo.
echo Would you like to update or install Google Chrome? (Y/N)?
echo (Tested it and if you run this it will not remove prexisting bookmarks)
echo.
set /p chromeinput=
if /I "%chromeinput%"=="y" goto updateChrome
if /I "%chromeinput%"=="yes" goto updateChrome
goto question4

:updateChrome
echo.
echo Updating Google Chrome...
:: Use a relative path for the Google Chrome installer
msiexec /i "%USERPROFILE%\Desktop\TROUBLESHOOT_SLOW_PC\DownloadStuff\GoogleChromeStandaloneEnterprise64.msi" /passive
echo.
echo Google Chrome has been updated.
goto question4


:question4
echo.
echo Would you like to launch the Please Go Faster default combo? (Y/N)?
echo.
echo (Combo includes: chkdsk /f, sfc /scannow, Disk Cleanup, Defragment and Optimize Drives, gpupdate /force, and open Default Apps)
set /p userinput=
if /I "%userinput%"=="y" goto launchAdminCmd
if /I "%userinput%"=="yes" goto launchAdminCmd
goto mandatoryInstructions

:launchAdminCmd
C:
start cmd /k chkdsk /f
start cmd /k sfc /scannow
start cmd /k gpupdate /force
start cleanmgr
start dfrgui
PowerShell -Command "Start-Process Taskmgr -ArgumentList '/0 /startup'"
pause
exit
goto mandatoryInstructions

:mandatoryInstructions
echo.
echo *****Optional Things You Can Do*****
echo.
echo 1. While the user is logged in, check the task manager startup programs to see if you can disable any pointless or resource intensive programs from starting up with Windows
echo.
echo 2. Check Program and Features for junk software that may be potentially slowing down the user's computer
echo.
echo 3. Check for any extensions that could be slowing down the user's computer on chrome
echo.
echo 4. Check internet speed to see if speeds are correct. If laptop, check the wireless speeds 
echo.
echo 5. Clean out the PC of any dust particles using canned air
echo.
echo 6. If all else fails, go ahead and run an extensive hardware diagnostics test to try and pinpoint the issue.
echo.
pause
exit
