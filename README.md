# Windows-RE
这是一个关于自定义恢复模式的项目，0基础，从零开始的系统还原...

一、首先是分区规范

>磁盘分区表类型 GUID 「基本 GPT」

磁盘分区类型包括：
| 分区 ### | 类型            | 大小          |
| -------- | --------------- | ------------- |
| 分区 1   | 系统 ESP        | 500M          |
| 分区 2   | 系统 MSR        | 16M           |
| 分区 3   | OEM NTFS        | 10G           |
| 分区 4   | 主分区 NTFS C:\ | 自定义 ≥ 120G |
| 分区 5   | 主分区 NTFS D:\ | 自定义        |

二、创建恢复批处理
需要的软件及命令：

| 软件/命令  | 作用                                           |
| ---------- | ---------------------------------------------- |
| ImageX.exe | 将 WIM 文件恢复到指定分区中。                  |
| DiskPart   | 用于挂载分区，指定盘符。配合 /s 使用效果更佳。 |
| Bcdboot    | 用于修复系统引导。                             |

>Recovery.bat

```bash
@echo off
::格式化 C 盘
Format /Q /Y C:
::从 D盘 000.wim 还原到 C
ImageX.exe /Apply D:\000.wim 1 C:\ /Verify
::挂载 ESP 分区并分配盘符 Z
DiskPart /S Mount_ESP.txt
::修复 C 盘系统引导
Bcdboot C:\windows /S Z: /F UEFI
::卸载 ESP 分区并删除盘符 Z
DiskPart /S Uninstall_ESP.txt

Echo.

Echo Press any Key to exit . . .
Pause > nul
```

>Mount_ESP.txt

```
List Disk
Sel Disk 0
List Partition
Sel Partition 1
Assign Letter Z
Exit
```

>Uninstall_ESP.txt

```
List Disk
Sel Disk 0
List Partition
Sel Partition 1
Remove Letter Z
Exit
```

将上述文件转换为 exe 效果更佳。
