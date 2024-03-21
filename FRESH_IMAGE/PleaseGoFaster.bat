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
echo Current version of installer in script for chrome: 124.0.6367.8
echo.
echo Would you like to update or install Google Chrome? (Y/N)?
echo.
set /p chromeinput=
if /I "%chromeinput%"=="y" goto updateChrome
if /I "%chromeinput%"=="yes" goto updateChrome
goto question4

:updateChrome
echo.
echo Updating Google Chrome...
:: Use a relative path for the Google Chrome installer
start "" ".\DownloadStuff\ChromeSetup.exe"
echo.
echo Google Chrome has been updated.
goto question4


:question4
echo.
echo Would you like to launch the Please Go Faster FAST combo? (Y/N)?
echo.
echo (Combo includes: gpupdate /force, and Task Manager)
set /p userinput=
if /I "%userinput%"=="y" goto launchAdminCmd
if /I "%userinput%"=="yes" goto launchAdminCmd
goto mandatoryInstructions

:launchAdminCmd
C:
start cmd /k gpupdate /force
PowerShell -Command "Start-Process Taskmgr -ArgumentList '/0 /startup'"
exit
