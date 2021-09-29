chcp 65001 >nul
@echo off
Title ACTIVATE WINDOWS 10 LTSB/LTSC - Copyright (C) Dominic Savio. All rights reserved.
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
type ActLTSBLTSC.txt
@echo.
:begin
@echo ===========================
Choice /N /C 1234 /M "* Nhap lua chon cua ban : 
if ERRORLEVEL 4 goto:exit 4
if ERRORLEVEL 3 goto:2 3
if ERRORLEVEL 2 goto:1 2
if ERRORLEVEL 1 goto:0 1

:0
start ActLTSBLTSC\ActLTSB2015Digital\ActLTSB2015Digital.cmd
exit
)

:1
start ActLTSBLTSC\ActLTSB2016Digital\ActLTSB2016Digital.cmd
exit
)

:2
start ActLTSBLTSC\ActLTSC2019years38\ActLTSC2019years38.cmd
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