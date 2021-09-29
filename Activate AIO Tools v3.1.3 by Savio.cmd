CHCP 1258 >nul 2>&1
CHCP 65001 >nul 2>&1
@echo off

::===========================================================================
fsutil dirty query %systemdrive%  >nul 2>&1 || (
echo.
echo ================================================================
echo                          ==== LỖI ====
echo Activate AIO Tools yêu cầu quyền Quản trị hệ thống. Để chạy AIO
echo Hãy nhấp chuột phải vào file .cmd và chọn 'Run as administrator'
echo ================================================================
echo.
echo Nhấn phím bất kỳ để thoát...
pause >nul
exit
)
::===========================================================================


title ACTIVATE AIO TOOLS V3.1.3 - Copyright (C) Dominic Savio. All rights reserved.
mode con: cols=123 lines=35
chcp 65001 >nul
color f0
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo  Chay CMD Voi Quyen Quan tri - Run as Administrator...
    goto goUAC 
) else (
 goto goADMIN )

:goUAC
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:goADMIN
    pushd "%CD%"
    CD /D "%~dp0"

:main
cls
type BIN\Text\Act.txt
@echo.
ver
cscript //nologo %windir%\system32\slmgr.vbs /ato >nul
cscript //nologo %windir%\system32\slmgr.vbs /xpr |findstr "permanently" >nul
if %errorlevel%==0  (
@echo                                         === WINDOWS DA KICH HOAT BAN QUYEN VINH VIEN ===
) else (
@echo                                      === WINDOWS CHUA DUOC KICH HOAT BAN QUYEN VINH VIEN ===
goto begin
)

:begin
@echo ===========================
Choice /N /C ABCDEFGHIJKLMNOPQRST /M "* Nhap Lua Chon Cua Ban : 
if ERRORLEVEL 20 goto :18 T
if ERRORLEVEL 19 goto :readme S
if ERRORLEVEL 18 goto :17 R
if ERRORLEVEL 17 goto :16 Q
if ERRORLEVEL 16 goto :15 P
if ERRORLEVEL 15 goto :14 O
if ERRORLEVEL 14 goto :13 N
if ERRORLEVEL 13 goto :12 M
if ERRORLEVEL 12 goto :11 L
if ERRORLEVEL 11 goto :10 K
if ERRORLEVEL 10 goto :9 J
if ERRORLEVEL 9 goto :8 I 
if ERRORLEVEL 8 goto :7 H
if ERRORLEVEL 7 goto :6 G
if ERRORLEVEL 6 goto :5 F
if ERRORLEVEL 5 goto :4 E
if ERRORLEVEL 4 goto :3 D
if ERRORLEVEL 3 goto :2 C
if ERRORLEVEL 2 goto :1 B
if ERRORLEVEL 1 goto :0 A

:0
start BIN\ActWin10Digital\ActWin10All\ActWin10Digital.cmd
goto main
)

:1
start BIN\WinOnline.cmd
goto main
)

:2
start BIN\WinByPhone.cmd
goto main
)

:3
cscript //nologo %windir%\system32\slmgr.vbs /dti >Iid_Win.txt
start Iid_Win.txt
goto main
)

:4
slui 4
@echo.
pause
cscript //nologo %windir%\system32\slmgr.vbs /xpr |findstr "permanently" >nul
if %errorlevel%==0  (
@echo     === Windows da duoc kich hoat ban quyen Vinh Vien ===
pause >nul
goto main
) else (
@echo   === Loi khong mong muon hoac Step 3 - CID khong chinh xac ===
@echo       === Kich hoat khong thanh cong. Vui Long thu lai! ===
pause >nul
goto main
)

:5
winver
goto main
)

:6
cscript //nologo %windir%\system32\slmgr.vbs /dlv >ThongTin_BanQuyen.txt
start ThongTin_BanQuyen.txt
goto main
)

:7
start BIN\OfficeOnline.cmd
goto main
)

:8
start BIN\OfficeByPhone.cmd
goto main
)

:9
cscript OSPP.VBS /dinstid >Iid_Office.txt
start Iid_Office.txt
goto main
)

:10
goto nhapcidoff
)

:11
start BIN\Converter\ConverterOffice.cmd
goto main
)

:12
start BIN\Remove\RemoveOfficeKey.cmd
goto main
)

:13
goto checkact
)

:14
start BIN\ActWinOfficeOnline\ActWinOfficeOnline.cmd
goto main
)

:15
start BIN\ActWin10Digital\ActLTSBLTSC.cmd
goto main
)

:16
start http://bit.ly/KeybyPhone
goto main
)

:17
start https://bit.ly/SaoLuuBanQuyen
goto main
)

:18
@echo.
@echo ================================================
@echo [  Cam on ban da su dung Activate AIO Tools!   ]
@echo [     Thanks for using Activate AIO Tools!     ]
@echo ================================================
timeout 3
start https://www.facebook.com/HoiQuanCongNgheTinHoc
exit

goto begin
:nhapcidoff
@echo.
@echo * Luu y khi nhap Confirmation ID : Dat cac nhom so lien nhau, khong co dau gach noi
@echo.
set /p cid= * Hay nhap Confirmation ID : 
@echo.
@echo * Dang kich hoat ban quyen
@echo.
cscript OSPP.VBS /actcid:%cid% >nul
cscript OSPP.VBS /act >nul
cscript OSPP.VBS /dstatus |findstr "LICENSED" >nul
if %errorlevel%==0  (
@echo   === Da kich hoat ban quyen VINH VIEN ===
@echo %key% >KEY_Office.txt
pause >nul
goto main
) else (
@echo   === Loi khong mong muon hoac Step 3 - CID khong chinh xac ===
@echo       === Kich hoat khong thanh cong. Vui Long thu lai! ===
@echo.
pause >nul
goto main
)

goto begin
:checkact
@echo.
@echo === DANG KIEM TRA TRANG THAI OFFICE ===
@echo.
cscript OSPP.VBS /dstatus
@echo.
cscript OSPP.VBS /dstatus |findstr "LICENSED" >nul
if %errorlevel%==0 (
@echo === OFFICE DA KICH HOAT BAN QUYEN ===
pause >nul
goto main
) else (
@echo === OFFICE CHUA DUOC KICH HOAT ===
@echo.
@echo === Xuat Hien ERROR CODE. Vui Long Tham Khao ERROR DESCRIPTION Ben Tren! ===
pause >nul
goto main
)

:readme
start BIN\Text\ActHDSD.txt
goto main

