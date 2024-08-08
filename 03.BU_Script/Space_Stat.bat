@Echo off
Setlocal enabledelayedexpansion

dir "D:\" > nul 2>&1
if %errorlevel% equ 1 (
	Goto  :Not_D
) else (
	Goto :Script_Run
)

:Script_Run
For /D %%i in ("C:\Users\*") do (
	Set folder_name=%%~ni
	Echo �û����� !folder_name!)
	Echo.
:End

Set /P "UserNa=�������û�����"

Dir /D /-C D:\ | Find "Ŀ¼" > D_DirInfo.AeBak
Dir /S /-C "C:\Users\%UserNa%\Desktop\" | Find "�ļ�">C_Desktop.AeBak
Dir /S /-C "C:\Users\%UserNa%\Documents\" | Find "�ļ�">C_Documents.AeBak
Dir /S /-C "C:\Users\%UserNa%\Downloads\" | Find "�ļ�">C_Downloads.AeBak

Echo.
Echo �� ͳ���ļ����� ��
Set "filePath=C_Desktop.AeBak" 
For /f "tokens=*" %%A in ('type "%filePath%" ^| findstr /r /c:"[0-9]* ���ļ� *[0-9]* �ֽ�"') do Set "ADesktop=%%A"
Echo - ���棺%ADesktop%
Echo %ADesktop%>C_Desktop.AeBak

Set "filePath=C_Downloads.AeBak" 
For /f "tokens=*" %%A in ('type "%filePath%" ^| findstr /r /c:"[0-9]* ���ļ� *[0-9]* �ֽ�"') do Set "ADownloads=%%A"
Echo - ���أ�%ADownloads%
Echo %ADownloads%>C_Downloads.AeBak

Set "filePath=C_Documents.AeBak" 
For /f "tokens=*" %%A in ('type "%filePath%" ^| findstr /r /c:"[0-9]* ���ļ� *[0-9]* �ֽ�"') do Set "ADocuments=%%A"
Echo - �ĵ���%ADocuments%
Echo %ADocuments%>C_Documents.AeBak

Set "filePath=D_DirInfo.AeBak" 
For /f "tokens=*" %%A in ('type "%filePath%" ^| findstr /r /c:"[0-9]* ��Ŀ¼ *[0-9]* �����ֽ�"') do Set "ADirInfo=%%A"
Echo - �ռ䣺%ADirInfo%
Echo %ADirInfo%>D_DirInfo.AeBak

Echo.
Echo �� ͳ���������� ��
Set input_file02=C_Desktop.AeBak
For /f "tokens=3" %%a in (%input_file02%) do (
	Set Desktop01=%%a
	Echo - ���棺!Desktop01!

)
	Del /q /a C_Desktop.AeBak
Set input_file03=C_Downloads.AeBak
For /f "tokens=3" %%a in (%input_file03%) do (
	Set Downloads01=%%a
	Echo - ���أ�!Downloads01!

)
	Del /q /a C_Downloads.AeBak
Set input_file04=C_Documents.AeBak
For /f "tokens=3" %%a in (%input_file04%) do (
	Set Documents01=%%a
	Echo - �ĵ���!Documents01!

)
	Del /q /a C_Documents.AeBak
Set input_file01=D_DirInfo.AeBak
For /f "tokens=3" %%a in (%input_file01%) do (
	Set DirInfo01=%%a
	Echo - �ռ䣺!DirInfo01!

)
	Del /q /a D_DirInfo.AeBak
Echo.

Set /a All_File = Desktop01 + Downloads01 + Documents01

If !DirInfo01! LSS !All_File! (
	Echo - �ռ䲻�� -
	Echo. 
	Echo - �ļ����ݣ�!All_File! 
	Echo - ���ݿռ䣺!DirInfo01! 
	Goto Space_DNo

) else (
	Echo - �ռ��㹻 -
	Echo. 
	Echo - �ļ����ݣ�!All_File!  
	Echo - ���ݿռ䣺!DirInfo01! 
	Goto Bkup
)

Endlocal
:Bkup
	Echo.
	Echo ++++++++++++++++++++ѡ�񱸷�+++++++++++++++++++
	Echo +	- 1.���������ļ���[��]
	Echo +	- 2.���������ļ���[��]
	Echo +	- 3.�����ĵ��ļ���[��]
	Echo +	- 4.�������桢�����ļ���[��]
	Echo +	- 5.�������桢���ء��ĵ��ļ���[����]
	Echo +	- 6.�˳�
	Echo ++++++++++++++++++++++++++++++++++++++++++++++
	Echo.
	@Set /p c=��������ź��� Enter ������
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
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Desktop" "D:\AJQ_BackupData\Desktop"
Echo ��������˳�...
Pause > Nul
Exit

:Bkup_Download
Cls
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Downloads" "D:\AJQ_BackupData\Downloads"
Echo ��������˳�...
Pause > Nul
Exit

:Bkup_Document
Cls
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Documents" "D:\AJQ_BackupData\Documents"
Echo ��������˳�...
Pause > Nul
Exit

:Bkup_DekDoc
Cls
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Desktop" "D:\AJQ_BackupData\Desktop"
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Downloads" "D:\AJQ_BackupData\Downloads"
Echo ��������˳�...
Pause > Nul
Exit

:Bkup_All
Cls
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Desktop" "D:\AJQ_BackupData\Desktop"
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Downloads" "D:\AJQ_BackupData\Downloads"
ROBOCOPY /E /B /NC /ETA /NDL /NFL /COPYALL "C:\Users\%UserNa%\Documents" "D:\AJQ_BackupData\Documents"
Echo ��������˳�...
Pause > Nul
Exit

:Bkup_Error
Exit

:Not_D
Cls
Echo ERROR��δ�ҵ����ݴ��� D���������...
Echo ��������˳�...
Pause > Nul
Exit

:Space_DNo
Cls
Echo ERROR����������ռ䲻��...
Echo �����밴�������ȡ����� X �رմ˳���...
Pause > Nul
Goto Bkup