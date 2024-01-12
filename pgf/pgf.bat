@echo off
start cmd /k "Edge_Disable.bat"
cls
net session >nul 2>&1
if %errorlevel% == 0 (
    echo Success: Administrative privileges confirmed.
) else (
    echo Failure: Please run this script as an administrator.
    pause
    exit
)

set "hpiaPath=C:\SWSetup\SP149392\HPImageAssistant.exe"
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

:askInstall
echo.
echo Do you want to install HP Image Assistant Version 5.1.11? (Y/N)?
echo.
set /p hpiaInput=
if /I "%hpiaInput%"=="y" goto installHPImageAssistant
if /I "%hpiaInput%"=="yes" goto installHPImageAssistant
goto skipHPImageAssistant

:installHPImageAssistant
echo.
echo Starting the HP Image Assistant installer...
start "" "hp-hpia-5.1.11.exe"
goto question1

:skipHPImageAssistant
echo.
echo Skipping HP Image Assistant installation.
goto question1


:question1
echo.
echo Do you want to update Bitdefender? (Y/N)?
echo (Hint: type up arrow on the product console window to do the update again if needed)
echo.
set /p bitdefenderinput=
if /I "%bitdefenderinput%"=="y" goto updateBitdefender
if /I "%bitdefenderinput%"=="yes" goto updateBitdefender
goto question2

:updateBitdefender
echo.
echo Updating Bitdefender...
start powershell -ExecutionPolicy Bypass -File "bitdefend.ps1"
echo.
echo Launching Bitdefender Security Console...
start "" "C:\Program Files\Bitdefender\Endpoint Security\EPConsole.exe"
goto question2

:question2
echo.
echo Checking current version of Google Chrome...
PowerShell -Command "(Get-Item 'C:\Program Files\Google\Chrome\Application\chrome.exe').VersionInfo.ProductVersion" > "%temp%\chromeVersion.txt"
set /p chromeVersion=<"%temp%\chromeVersion.txt"
del "%temp%\chromeVersion.txt"

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
goto question3

:updateChrome
echo.
echo Updating Google Chrome...
start /wait msiexec /i "GoogleChromeStandaloneEnterprise64.msi" /norestart
echo.
echo Google Chrome has been updated.
goto question3


:question3
echo.
echo Would you like to launch the Please Go Faster default combo? (Y/N)?
echo.
echo (Combo includes: chkdsk /f, sfc /scannow, Disk Cleanup, Defragment and Optimize Drives, gpupdate /force, and open Default Apps)
echo.
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
PowerShell -Command "Start-Process 'ms-settings:defaultapps'"
goto mandatoryInstructions

:mandatoryInstructions
echo.
echo *****Mandatory Things You Should Do*****
echo.
echo 1. Update Bitdefender
echo.
echo 2. Update Chrome
echo.
echo 3. Run BIOS Update either through HP image assistant or please download directly from the HP website since it sometimes doesn't work
echo.
echo *****Optional Things You Can Do*****
echo.
echo 1. Check the task manager startup programs to see if you can disable any pointless or resourse intensive programs from starting up with Windows
echo.
echo 2. Check Program and Features for junk software that may be potentially slowing down the users computer
echo.
echo 3. Check for any extensions that could be slowing down the users computer on chrome
echo.
echo 4. Check internet speed to see if speeds are correct. If laptop, check the wireless speeds 
echo.
echo 5. Clean out the PC of any dust particles using canned air
echo.
echo 6. If all else fails, Run an extensive hardware diagnostics test to try and pinpoint the issue.
echo.
pause
exit
