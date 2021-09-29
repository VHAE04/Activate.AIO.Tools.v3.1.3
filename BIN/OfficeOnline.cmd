chcp 65001 >nul
@echo off
title ACTIVATE OFFICE 2010-2013-2016-2019 Online - Copyright (C) Dominic Savio. All rights reserved.
mode con: cols=122 lines=40
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
type Text\Office\OfficeOnline.txt
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
@echo 2. Dang cai dat Key moi
cscript OSPP.VBS /inpkey:%key%
@echo.
@echo 3. Dang kich hoat ban quyen
cscript OSPP.VBS /act
@echo.
@echo 4. Dang kiem tra ban quyen
cscript OSPP.VBS /dstatus |findstr "LICENSED" >nul
if %errorlevel%==0 (
@echo    === Da kich hoat ban quyen VINH VIEN ===
@echo %key% >Key_Office.txt
pause >nul
goto exit
) else (
@echo ---------------------------------------
@echo ERROR CODE = MO TA LOI TUONG UNG
@echo 0xC004C060 : Key cua ban da bi chan - Block
@echo 0xC004C020 : Key da het luot kich hoat Online. Co the chuyen sang kich hoat By Phone
@echo 0xC004C003 : Key hoac Office ban dung la khong chinh hang. Hoac Office da bi loi
@echo 0xC004C008 : Khong the su dung Key da chi dinh. Co the chuyen sang kich hoat By Phone
@echo 0xC004F069 : Khong tim thay SKU - Key va phien ban Office khong tuong thich
@echo ---------------------------------------
@echo === Xuat Hien ERROR CODE Khac. Vui Long Tham Khao ERROR DESCRIPTION Ben Tren! ===
pause >nul
exit
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
