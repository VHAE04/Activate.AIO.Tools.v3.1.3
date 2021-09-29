chcp 65001 >nul
@echo off
title ACTIVATE WINDOWS 7 8 8.1 10 Online - Copyright (C) Dominic Savio. All rights reserved.
mode con: cols=115 lines=35
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
type Text\Win\WinOnline.txt
color f0
ver
@echo.
@echo 1. Dang kiem tra ban quyen
cscript //nologo %windir%\system32\slmgr.vbs /xpr |findstr "permanently" >nul
if %errorlevel%==0  (
@echo                                 === WINDOWS DA KICH HOAT BAN QUYEN VINH VIEN ===
pause >nul
exit
) else (
@echo                              === WINDOWS CHUA DUOC KICH HOAT BAN QUYEN VINH VIEN ===
@echo.
@echo Nhan phim bat ky de tiep tuc kich hoat...
pause >nul
goto begin
)

:begin
@echo.
set /p key= 2. Nhap Key : 
@echo.

@echo 3. Dang go bo key cu ra khoi may
cscript //nologo %windir%\system32\slmgr.vbs /upk

@echo 4. Dang xoa may chu KMS neu co
cscript //nologo %windir%\system32\slmgr.vbs /ckms

@echo 5. Dang xoa key trong Registry
cscript //nologo %windir%\system32\slmgr.vbs /cpky

@echo 6. Dang cai dat Key
cscript //nologo %windir%\system32\slmgr.vbs /ipk %key%

@echo 7. Dang thuc hien lenh kich hoat
cscript //nologo %windir%\system32\slmgr.vbs /ato

@echo 8. Dang kiem tra ban quyen
cscript //nologo %windir%\system32\slmgr.vbs /xpr |findstr "permanently" >nul
if %errorlevel%==0  (
@echo    === Da kich hoat ban quyen VINH VIEN ===
@echo %key% >Key_Win.txt
pause >nul
exit
) else (
@echo         === Kich hoat khong thanh cong, vui long kiem tra lai Key! ===
@echo    === Hoac Key ban nhap da het luot Online, hay thu kich hoat By Phone ===
@echo.
@echo Nhan phim bat ky de thu kich hoat lai...
pause >nul
exit
)