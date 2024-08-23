
@Echo Off

If Exist O:\Recovery\ImageReWim\Install.wim (

    Goto Install_Exit

) ELSE (

    Goto Error_Exit

)

:Install_Exit
Cls
Format /Q /Y /V:Windows_OS C:
ImageX.exe /Apply "O:\Recovery\ImageReWim\Install.wim" 1 C:\ /Verify
DiskPart /S "X:\Windows\System32\Mount_ESP.txt"
Bcdboot C:\Windows /S Z: /F UEFI
DiskPart /S "X:\Windows\System32\Uninstall_ESP.txt"
Echo.
Echo Install End!
Echo Press any Key to exit . . .
Pause > nul
Exit

:Error_Exit
Cls
Echo The restore file does not exist!(Wim)
Echo Press any Key to exit . . .
Pause > nul
Exit