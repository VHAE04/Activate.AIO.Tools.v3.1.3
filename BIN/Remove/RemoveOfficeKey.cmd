chcp 65001 >nul
@echo off
Title SCRIPT REMOVE KEY OFFICE - Copyright (C) Dominic Savio. All rights reserved.
mode con: cols=115 lines=35
chcp 65001 >nul
@echo.
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
color f0
type RemoveOfficeKey.txt
@echo.
@echo ===========================
Choice /N /C 12345 /M "* Nhap lua chon cua ban :
if %errorlevel% == 5 goto exit 
if %errorlevel% == 4 ( set "xx=16" & goto vogia)
if %errorlevel% == 3 ( set "xx=16" & goto vogia)
if %errorlevel% == 2 ( set "xx=15" & goto vogia)
if %errorlevel% == 1 ( set "xx=14" & goto vogia)

:exit
@echo.
@echo ================================================
@echo [  Cam on ban da su dung Activate AIO Tools!   ]
@echo [     Thanks for using Activate AIO Tools!     ]
@echo ================================================
timeout 3
start https://www.facebook.com/HoiQuanCongNgheTinHoc
exit

:vogia
if exist "%ProgramFiles%\Microsoft Office\Office%xx%\ospp.vbs" cd /d "%ProgramFiles%\Microsoft Office\Office%xx%"
if exist "%ProgramFiles(x86)%\Microsoft Office\Office%xx%\ospp.vbs" cd /d "%ProgramFiles(x86)%\Microsoft Office\Office%xx%"
cscript ospp.vbs /dstatus >dstatus.txt
start dstatus.txt
goto dominicsavio
)

:dominicsavio
@echo.
set /p key= * NHAP 5 KY TU CUOI CUA KEY CAN XOA : 
@echo.
@echo 3. DANG XOA KEY...
cscript OSPP.VBS /unpkey:%key%
@echo.
@echo ==================================
@echo DA XOA KEY OFFICE KHONG CAN THIET!
@echo ==================================
@echo.
goto dominicsavio
)