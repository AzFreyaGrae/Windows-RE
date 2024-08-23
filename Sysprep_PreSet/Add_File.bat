@Echo Off

Set Dir=%~dp0

Echo 创建文件夹 -------- [1/7]
::删除文件夹
RD /S /Q "%Userprofile%\Documents\WeChat Files"
RD /S /Q "%Userprofile%\Documents\WXWork"
RD /S /Q "%Userprofile%\Documents\Tencent Files"
RD /S /Q "%Userprofile%\Documents\WPSDrive"
RD /S /Q "%Userprofile%\Documents\Sunlogin Files"
::新建文件夹
MD "%Userprofile%\Documents\WeChat Files"
MD "%Userprofile%\Documents\WXWork"
MD "%Userprofile%\Documents\Tencent Files"
MD "%Userprofile%\Documents\WPSDrive"
MD "%Userprofile%\Documents\Sunlogin Files"
::新建连接文件夹
MD "D:\User Data\WeChat Files"
MD "D:\User Data\WXWork"
MD "D:\User Data\Tencent Files"
MD "D:\User Data\WPSDrive"
MD "D:\User Data\Sunlogin Files"
Cls

Echo 建立文件夹链接 ------ [2/7]
MKLINK /D "%Userprofile%\Documents\WeChat Files" "D:\User Data\WeChat Files"
MKLINK /D "%Userprofile%\Documents\WXWork" "D:\User Data\WXWork"
MKLINK /D "%Userprofile%\Documents\Tencent Files" "D:\User Data\Tencent Files"
MKLINK /D "%Userprofile%\Documents\WPSDrive" "D:\User Data\WPSDrive"
MKLINK /D "%Userprofile%\Documents\Sunlogin Files" "D:\User Data\Sunlogin Files"
Echo - 文档链接，请勿删除！防止因微信、企微、QQ、WPS数据，导致 C 盘空间不足。>"D:\User_Data文件夹说明.txt"
Cls

Echo 导入注册表信息 ------ [3/7]
::关闭 磁盘开机自检
regedit /s "%~dp0Ban_TestDisk.reg"
::暂停 系统更新至 2099 年
regedit /s "%~dp0Ban_Update.reg"
Cls

Echo 注册表删除任务栏图标 --- [4/7]
::关闭 兴趣与咨询广告
Reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /f /d 2
Cls

Echo 重启资源管理器 ------ [5/7]
Taskkill /f /im Explorer.exe
Start Explorer.exe
Cls

Echo 设置启动项时间 ------ [6/7]
BcdEdit /TimeOut 0
Cls

Echo 激活系统 --------- [7/7]
Call %~dp0Win_AIO.bat

Exit