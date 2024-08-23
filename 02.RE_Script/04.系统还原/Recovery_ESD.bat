
@Echo Off

If Exist O:\Recovery\ImageReEsd\Install.esd (

    Goto Install_Exit

) ELSE (

    Goto Error_Exit

)

:Install_Exit
Cls
Format /Q /Y /V:Windows_OS C:
Dism /Apply-Image /ImageFile:"O:\Recovery\ImageReEsd\Install.esd" /Index:1 /ApplyDir:C:\
DiskPart /S "%SystemRoot%\System32\Mount_ESP.txt"
Bcdboot C:\Windows /S Z: /F UEFI
DiskPart /S "%SystemRoot%\system32\Uninstall_ESP.txt"
Echo.
Echo Install End!
Echo Press any Key to exit . . .
Pause > nul
Exit

:Error_Exit
Cls
Echo The restore file does not exist!(Esd)
Echo Press any Key to exit . . .
Pause > nul
Exit