@echo off

Format /Q /Y C:

ImageX.exe /Apply D:\000.wim 1 C:\ /Verify

DiskPart /S Mount_ESP.txt

Bcdboot C:\windows /S Z: /F UEFI

DiskPart /S Uninstall_ESP.txt

Echo.

Echo Press any Key to exit . . .
Pause > nul