# 关于PE设置密码，并加密PeCmd.ini文件。
>进入 PE 系统：

1.生成Base密码
- Win + R
```
pecmd.exe base [Password]
```
2.打开 PeCmd.ini文件，2 次机会，输错关机
```
SHEL %WinDir%\Explorer.exe,[生成的密码], 2
```
3.加密 PeCmd.ini文件[Key_PeCmd.ini]为加密后文件
```
pecmd.exe cmps PeCmd.ini Key_PeCmd.ini
```
