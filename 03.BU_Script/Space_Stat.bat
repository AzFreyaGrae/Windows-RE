
@Echo off
Setlocal enabledelayedexpansion
rd /s /q D:\BackupData
MD D:\BackupData
if %errorlevel% == 0 (
	Goto :Script_Run
) else (
	Goto :Not_D 
)

:Script_Run
For /D %%i in ("C:\Users\*") do (
	Set folder_name=%%~ni
	Echo 用户名： !folder_name!)
	Echo.
:End

Set /P "UserNa=请输入用户名："

Dir /D /-C D:\ | Find "目录" > D_DirInfo.AeBak
Dir /S /-C "C:\Users\%UserNa%\Desktop\" | Find "文件">C_Desktop.AeBak
Dir /S /-C "C:\Users\%UserNa%\Documents\" | Find "文件">C_Documents.AeBak
Dir /S /-C "C:\Users\%UserNa%\Downloads\" | Find "文件">C_Downloads.AeBak

Echo.
Echo － 统计文件数据 －
Set "filePath=C_Desktop.AeBak" 
For /f "tokens=*" %%A in ('type "%filePath%" ^| findstr /r /c:"[0-9]* 个文件 *[0-9]* 字节"') do Set "ADesktop=%%A"
Echo - 桌面：%ADesktop%
Echo %ADesktop%>C_Desktop.AeBak

Set "filePath=C_Downloads.AeBak" 
For /f "tokens=*" %%A in ('type "%filePath%" ^| findstr /r /c:"[0-9]* 个文件 *[0-9]* 字节"') do Set "ADownloads=%%A"
Echo - 下载：%ADownloads%
Echo %ADownloads%>C_Downloads.AeBak

Set "filePath=C_Documents.AeBak" 
For /f "tokens=*" %%A in ('type "%filePath%" ^| findstr /r /c:"[0-9]* 个文件 *[0-9]* 字节"') do Set "ADocuments=%%A"
Echo - 文档：%ADocuments%
Echo %ADocuments%>C_Documents.AeBak

Set "filePath=D_DirInfo.AeBak" 
For /f "tokens=*" %%A in ('type "%filePath%" ^| findstr /r /c:"[0-9]* 个目录 *[0-9]* 可用字节"') do Set "ADirInfo=%%A"
Echo - 空间：%ADirInfo%
Echo %ADirInfo%>D_DirInfo.AeBak

Echo.
Echo － 统计数据总量 －
Set input_file02=C_Desktop.AeBak
For /f "tokens=3" %%a in (%input_file02%) do (
	Set Desktop01=%%a
	Echo - 桌面：!Desktop01!

)
	Del /q /a C_Desktop.AeBak
Set input_file03=C_Downloads.AeBak
For /f "tokens=3" %%a in (%input_file03%) do (
	Set Downloads01=%%a
	Echo - 下载：!Downloads01!

)
	Del /q /a C_Downloads.AeBak
Set input_file04=C_Documents.AeBak
For /f "tokens=3" %%a in (%input_file04%) do (
	Set Documents01=%%a
	Echo - 文档：!Documents01!

)
	Del /q /a C_Documents.AeBak
Set input_file01=D_DirInfo.AeBak
For /f "tokens=3" %%a in (%input_file01%) do (
	Set DirInfo01=%%a
	Echo - 空间：!DirInfo01!

)
	Del /q /a D_DirInfo.AeBak
Echo.

Set /a All_File = Desktop01 + Downloads01 + Documents01

If !DirInfo01! LSS !All_File! (
	Echo - 空间不足 -
	Echo. 
	Echo - 文件数据：!All_File! 
	Echo - 备份空间：!DirInfo01! 
	Goto Space_DNo

) else (
	Echo - 空间足够 -
	Echo. 
	Echo - 文件数据：!All_File!  
	Echo - 备份空间：!DirInfo01! 
	Goto Bkup
)

Endlocal
:Bkup
	Echo.
	Echo ++++++++++++++++++++选择备份+++++++++++++++++++
	Echo +	- 1.备份桌面文件夹[快]
	Echo +	- 2.备份下载文件夹[快]
	Echo +	- 3.备份文档文件夹[慢]
	Echo +	- 4.备份桌面、下载文件夹[快]
	Echo +	- 5.备份桌面、下载、文档文件夹[极慢]
	Echo +	- 6.退出
	Echo ++++++++++++++++++++++++++++++++++++++++++++++
	Echo.
	@Set /p c=请输入序号后按下 Enter 继续：
If %c%==1 (
Goto Bkup_Desktop
	) Else (
If %c%==2 (
Goto Bkup_Download
	) Else (
If %c%==3 (
Goto Bkup_Document
	) Else (
If %c%==4 (
Goto Bkup_DekDoc
	) Else (
If %c%==5 (
Goto Bkup_All
	) Else (
Goto Bkup_Error
)
)
)
)
)

:Bkup_Desktop
Cls
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Desktop" "D:\BackupData\Desktop"
Echo 按任意键退出...
Pause > Nul
Exit

:Bkup_Download
Cls
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Downloads" "D:\BackupData\Downloads"
Echo 按任意键退出...
Pause > Nul
Exit

:Bkup_Document
Cls
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Documents" "D:\BackupData\Documents"
Echo 按任意键退出...
Pause > Nul
Exit

:Bkup_DekDoc
Cls
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Desktop" "D:\BackupData\Desktop"
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Downloads" "D:\BackupData\Downloads"
Echo 按任意键退出...
Pause > Nul
Exit

:Bkup_All
Cls
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Desktop" "D:\BackupData\Desktop"
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Downloads" "D:\BackupData\Downloads"
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Documents" "D:\BackupData\Documents"
Echo 按任意键退出...
Pause > Nul
Exit

:Bkup_Error
Exit

:Not_D
Cls
Echo ERROR：未找到备份磁盘 D，请检查磁盘...
Echo 按任意键退出...
Pause > Nul
Exit

:Space_DNo
Cls
Echo ERROR：备份区域空间不足...
Echo 继续请按任意键，取消点击 X 关闭此程序...
Pause > Nul
Goto Bkup
