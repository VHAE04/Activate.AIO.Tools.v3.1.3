chcp 65001 >nul
@echo off
Title CONVERT OFFICE 2016 - Copyright (C) Dominic Savio. All rights reserved.
mode con: cols=122 lines=35
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

cls
color f0
type Text\Office2016.txt
if exist "C:\Program Files (x86)\Microsoft Office\Office16\ospp.vbs" set folder="C:\Program Files (x86)\Microsoft Office\Office16"
if exist "C:\Program Files\Microsoft Office\Office16\ospp.vbs" set folder="C:\Program Files\Microsoft Office\Office16"
set "ver= 2016"
cd /d %~dp0\"License Files\License16\"
@echo.
@echo ===========================
Choice /N /C 1234567 /M "* Nhap lua chon cua ban :
IF %errorlevel% == 1 SET "EDITION=ProjectPro" & GOTO 2Volume2016
IF %errorlevel% == 2 SET "EDITION=ProPlus" & GOTO :2Volume2016
IF %errorlevel% == 3 SET "EDITION=VisioProVL" & GOTO 2Volume2016
IF %errorlevel% == 4 SET "EDITION=ProjectPro" & GOTO 2Retai2016
IF %errorlevel% == 5 SET "EDITION=ProPlus" & GOTO 2Retai2016
IF %errorlevel% == 6 SET "EDITION=VisioPro" & GOTO 2Retai2016
IF %errorlevel% == 7 GOTO:Exit

:exit
@echo.
@echo ================================================
@echo [  Cam on ban da su dung Activate AIO Tools!   ]
@echo [     Thanks for using Activate AIO Tools!     ]
@echo ================================================
timeout 3
start https://www.facebook.com/HoiQuanCongNgheTinHoc
exit

:2Volume2016
cls
@echo.
@echo   DANG CONVERT OFFICE%ver% %EDITION% RETAIL SANG VL....
@echo.
cleanospp.exe
FOR %%G IN (client*.xrm-ms) DO (cscript //Nologo %folder%\ospp.vbs /inslic:%%G)
FOR %%G IN (pkeyconfig*.xrm-ms) DO (cscript //Nologo %folder%\ospp.vbs /inslic:%%G)
cd /d %~dp0\"License Files\License16\Volume"
FOR %%G IN (%EDITION%*.xrm-ms) DO (cscript //Nologo %folder%\ospp.vbs /inslic:%%G)
echo.&echo COMPLETED !
echo.
pause
goto:exit

:2Retai2016
CLS
@echo.
@echo    DANG CONVERT OFFICE %ver% %EDITION% VL SANG RETAIL....
@echo.
cleanospp.exe
FOR %%G IN (client*.xrm-ms) DO (cscript //Nologo %folder%\ospp.vbs /inslic:%%G)
FOR %%G IN (pkeyconfig*.xrm-ms) DO (cscript //Nologo %folder%\ospp.vbs /inslic:%%G)
cd /d %~dp0\"License Files\License16\Retail"
FOR %%G IN (%EDITION%*.xrm-ms) DO (cscript //Nologo %folder%\ospp.vbs /inslic:%%G)
echo.&echo COMPLETED !
echo.
pause
goto:exit
