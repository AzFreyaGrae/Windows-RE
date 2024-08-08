@Echo Off

Format /Q /Y C:

ImageX.exe /Apply O:\RE_Image\xxxxx.wim 1 C:\ /Verify

DiskPart /S Mount_ESP.txt

Bcdboot C:\Windows /S Z: /F UEFI

DiskPart /S Uninstall_ESP.txt

Echo.

Echo Press any Key to exit . . .
Pause > nul