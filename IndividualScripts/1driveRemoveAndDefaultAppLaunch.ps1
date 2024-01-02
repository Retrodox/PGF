# PowerShell script to remove Microsoft Edge and Microsoft OneDrive

# Ensure the script is running with administrative privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    Write-Warning "Please run this script as an Administrator!"
    break
}

# Open Default Apps Settings
function Open-DefaultAppsSettings {
    Start-Process "ms-settings:defaultapps"
}

# Execute the function
Open-DefaultAppsSettings

# Function to uninstall Microsoft OneDrive
function Uninstall-OneDrive {
    Write-Host "Uninstalling Microsoft OneDrive..."

    # Stop OneDrive processes
    Get-Process 'OneDrive' -ErrorAction SilentlyContinue | Stop-Process -Force

    # Uninstall OneDrive
    if (Test-Path "$env:SystemRoot\SysWOW64\OneDriveSetup.exe") {
        & "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" /uninstall
    }
    elseif (Test-Path "$env:SystemRoot\System32\OneDriveSetup.exe") {
        & "$env:SystemRoot\System32\OneDriveSetup.exe" /uninstall
    }
    else {
        Write-Warning "Microsoft OneDrive is not installed."
    }
}

# Execute uninstall functions
Uninstall-Edge
Uninstall-OneDrive

# Output completion message
Write-Host "Uninstallation process completed."
pause
