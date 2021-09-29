chcp 65001 >nul
@echo off
title ACTIVATE OFFICE 2010-2013-2016-2019 By Phone - Copyright (C) Dominic Savio. All rights reserved.
mode con: cols=122 lines=38
chcp 65001 >nul
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo  Run CMD as Administrator...
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
cls
type Text\Office\OfficeByPhone.txt
color f0
@echo.
@echo ===========================
Choice /N /C 12345 /M "* Nhap lua chon cua ban : "
if %errorlevel% == 5 goto :exit
if %errorlevel% == 4 ( set "xx=16" & goto vogia)
if %errorlevel% == 3 ( set "xx=16" & goto vogia)
if %errorlevel% == 2 ( set "xx=15" & goto vogia)
if %errorlevel% == 1 ( set "xx=14" & goto vogia)

:vogia
if exist "%ProgramFiles%\Microsoft Office\Office%xx%\ospp.vbs" cd /d "%ProgramFiles%\Microsoft Office\Office%xx%"
if exist "%ProgramFiles(x86)%\Microsoft Office\Office%xx%\ospp.vbs" cd /d "%ProgramFiles(x86)%\Microsoft Office\Office%xx%"
goto begin

:begin
@echo.
set /p key= 1. Nhap Key : 
@echo.

@echo 2. Dang cai dat Key
cscript OSPP.VBS /inpkey:%key%
@echo.

@echo 3. Installation ID cua ban la : 
cscript OSPP.VBS /dinstid >Iid_Office.txt
start Iid_Office.txt
@echo * Copy day so Installation ID de Get Step 3 - Confirmation ID
@echo * Luu y khi nhap Confirmation ID : Dat cac nhom so lien nhau, khong co dau gach noi
@echo.

:nhapcid
set /p cid= 4. Nhap Confirmation ID : 
@echo.

@echo 5. Dang kich hoat ban quyen
cscript OSPP.VBS /actcid:%cid%
@echo.

@echo 6. Dang kiem tra ban quyen
cscript OSPP.VBS /act >nul
@echo.
cscript OSPP.VBS /dstatus |findstr "LICENSED" >nul
if %errorlevel%==0  (
@echo   === Da kich hoat ban quyen VINH VIEN ===
@echo %key% >Key_Office.txt
pause >nul
goto exit
) else (
@echo   === Loi khong mong muon hoac Step 3 - CID khong chinh xac ===
@echo       === Kich hoat khong thanh cong. Vui Long thu lai! ===
@echo.
pause >nul
goto nhapcid
)

:exit
@echo.
@echo ================================================
@echo [  Cam on ban da su dung Activate AIO Tools!   ]
@echo [     Thanks for using Activate AIO Tools!     ]
@echo ================================================
timeout 3
start https://www.facebook.com/HoiQuanCongNgheTinHoc
exit
