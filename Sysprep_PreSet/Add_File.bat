@Echo Off

Set Dir=%~dp0

Echo �����ļ��� -------- [1/7]
::ɾ���ļ���
RD /S /Q "%Userprofile%\Documents\WeChat Files"
RD /S /Q "%Userprofile%\Documents\WXWork"
RD /S /Q "%Userprofile%\Documents\Tencent Files"
RD /S /Q "%Userprofile%\Documents\WPSDrive"
RD /S /Q "%Userprofile%\Documents\Sunlogin Files"
::�½��ļ���
MD "%Userprofile%\Documents\WeChat Files"
MD "%Userprofile%\Documents\WXWork"
MD "%Userprofile%\Documents\Tencent Files"
MD "%Userprofile%\Documents\WPSDrive"
MD "%Userprofile%\Documents\Sunlogin Files"
::�½������ļ���
MD "D:\User Data\WeChat Files"
MD "D:\User Data\WXWork"
MD "D:\User Data\Tencent Files"
MD "D:\User Data\WPSDrive"
MD "D:\User Data\Sunlogin Files"
Cls

Echo �����ļ������� ------ [2/7]
MKLINK /D "%Userprofile%\Documents\WeChat Files" "D:\User Data\WeChat Files"
MKLINK /D "%Userprofile%\Documents\WXWork" "D:\User Data\WXWork"
MKLINK /D "%Userprofile%\Documents\Tencent Files" "D:\User Data\Tencent Files"
MKLINK /D "%Userprofile%\Documents\WPSDrive" "D:\User Data\WPSDrive"
MKLINK /D "%Userprofile%\Documents\Sunlogin Files" "D:\User Data\Sunlogin Files"
Echo - �ĵ����ӣ�����ɾ������ֹ��΢�š���΢��QQ��WPS���ݣ����� C �̿ռ䲻�㡣>"D:\User_Data�ļ���˵��.txt"
Cls

Echo ����ע�����Ϣ ------ [3/7]
::�ر� ���̿����Լ�
regedit /s "%~dp0Ban_TestDisk.reg"
::��ͣ ϵͳ������ 2099 ��
regedit /s "%~dp0Ban_Update.reg"
Cls

Echo ע���ɾ��������ͼ�� --- [4/7]
::�ر� ��Ȥ����ѯ���
Reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /f /d 2
Cls

Echo ������Դ������ ------ [5/7]
Taskkill /f /im Explorer.exe
Start Explorer.exe
Cls

Echo ����������ʱ�� ------ [6/7]
BcdEdit /TimeOut 0
Cls

Echo ����ϵͳ --------- [7/7]
Call %~dp0Win_AIO.bat

Exit