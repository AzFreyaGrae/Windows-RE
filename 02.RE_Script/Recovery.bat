@Echo Off

If Exist O:\RE_Image\xxxxx.wim (

    Format /Q /Y /V:Windows_OS C:
    ImageX.exe /Apply O:\RE_Image\xxxxx.wim 1 C:\ /Verify
    DiskPart /S Mount_ESP.txt
    Bcdboot C:\Windows /S Z: /F UEFI
    DiskPart /S Uninstall_ESP.txt
    Echo.
    Goto Install_Exit

) ELSE (

    Goto Error_Exit

)

:Install_Exit
Cls
Echo 安装结束！
Echo Press any Key to exit . . .
Pause > nul
Exit

:Error_Exit
Cls
Echo 还原映像不存在！
Echo Press any Key to exit . . .
Pause > nul
Exit
