chcp 65001 >nul
@echo off
Title SCRIPT CONVERT OFFICE - Copyright (C) Dominic Savio. All rights reserved.
mode con: cols=123 lines=35
chcp 65001 >nul
color f0
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
	
:main
cls
type Text\ConverterOffice.txt
@echo.
:begin
@echo ===========================
Choice /N /C 123456 /M "* Nhap lua chon cua ban : 
if ERRORLEVEL 6 goto:exit 6
if ERRORLEVEL 5 goto:3 5
if ERRORLEVEL 4 goto:3 4
if ERRORLEVEL 3 goto:2 3
if ERRORLEVEL 2 goto:1 2
if ERRORLEVEL 1 goto:0 1

:0
start Office2010.cmd
exit
)

:1
start Office2013.cmd
exit
)

:2
start Office2016.cmd
exit
)

:3
start Office2019.cmd
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