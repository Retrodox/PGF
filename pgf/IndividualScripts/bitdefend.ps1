Start-Process "C:\Program Files\Bitdefender\Endpoint Security\product.console"
Start-Sleep -Seconds 2  # Wait for the console to open
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait("StartUpdate -force{ENTER}")
