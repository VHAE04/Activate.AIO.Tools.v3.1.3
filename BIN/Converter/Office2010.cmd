chcp 65001 >nul
@echo off
Title CONVERT OFFICE 2010 - Copyright (C) Dominic Savio. All rights reserved.
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
if exist "C:\Program Files (x86)\Microsoft Office\Office14\ospp.vbs" set folder="C:\Program Files (x86)\Microsoft Office\Office14"
if exist "C:\Program Files\Microsoft Office\Office14\ospp.vbs" set folder="C:\Program Files\Microsoft Office\Office14"
set "ver= 2010"
cd /d %~dp0\"Licenses\"
REM Variables
set OfficeArchType=
REM Check Office Architecture Type
if '%processor_architecture%'=='x86' Set OfficeArchType=32 && Goto:EndArchCheck
goto:WOWCheck
:WOWCheck
if exist "%~d0\Program Files (x86)\Common Files\Microsoft Shared\OfficeSoftwareProtectionPlatform" Set OfficeArchType=WOW && Goto:EndArchCheck
Set OfficeArchType=64
:EndArchCheck
REM Find Rearm Tool
if exist "%~d0\Program Files (x86)\Common Files\Microsoft Shared\OfficeSoftwareProtectionPlatform" (
set ospprearm="%~d0\Program Files (x86)\Common Files\Microsoft Shared\OfficeSoftwareProtectionPlatform\ospprearm.exe"
) ELSE (
set ospprearm="%~d0\Program Files\Common Files\Microsoft Shared\OfficeSoftwareProtectionPlatform\ospprearm.exe"
)

cls
type Text\Office2010.txt
@echo.
@echo ===========================
Choice /N /C 12345 /M "* Nhap lua chon cua ban :
IF %errorlevel% == 1 SET "EDITION=ProjectPro" & GOTO 2Volume2010
IF %errorlevel% == 2 SET "EDITION=ProPlus" & GOTO 2Volume2010
IF %errorlevel% == 3 SET "EDITION=VisioPro" & GOTO 2Volume2010 
REM IF %errorlevel% == 4 SET "EDITION=ProjectPro" & GOTO 2Retai2010
IF %errorlevel% == 4 SET "EDITION=ProPlus" & GOTO 2Retai2010
REM IF %errorlevel% == 6 SET "EDITION=VisioPro" & GOTO 2Retai2010
IF %errorlevel% == 5 GOTO:Exit

:exit
@echo.
@echo ================================================
@echo [  Cam on ban da su dung Activate AIO Tools!   ]
@echo [     Thanks for using Activate AIO Tools!     ]
@echo ================================================
timeout 3
start https://www.facebook.com/HoiQuanCongNgheTinHoc
exit

:2Volume2010
cls
@echo.
@echo   DANG CONVERT OFFICE%ver% %EDITION% RETAIL SANG VL....
@echo.
FOR %%G IN (pkeyconfig*.xrm-ms) DO (cscript //Nologo %folder%\ospp.vbs /inslic:%%G)
cd /d %~dp0\"License Files\License10\Volume"
FOR %%G IN (%EDITION%*.xrm-ms) DO (cscript //Nologo %folder%\ospp.vbs /inslic:%%G)
cd /d %~dp0\"License Files\License10\Volume\%EDITION%"
if %OfficeArchType%==32 regedit /s Registration32.reg
if %OfficeArchType%==64 regedit /s Registration64.reg
if %OfficeArchType%==WOW regedit /s RegistrationWOW.reg
echo.&echo COMPLETED !
echo.
pause
goto:exit

:2Retai2010
cls
@echo.
@echo    DANG CONVERT OFFICE%ver% %EDITION% VL SANG RETAIL....
@echo.
FOR %%G IN (pkeyconfig*.xrm-ms) DO (cscript //Nologo %folder%\ospp.vbs /inslic:%%G)
cd /d %~dp0\"License Files\License10\Retail"
FOR %%G IN (%EDITION%*.xrm-ms) DO (cscript //Nologo %folder%\ospp.vbs /inslic:%%G)
FOR %%G IN (OEM*.xrm-ms) DO (cscript //Nologo %folder%\ospp.vbs /inslic:%%G)
cd /d %~dp0\"License Files\License10\Retail\%EDITION%"
if %OfficeArchType%==32 regedit /s Registration32.reg
if %OfficeArchType%==64 regedit /s Registration64.reg
if %OfficeArchType%==WOW regedit /s RegistrationWOW.reg
echo.&echo COMPLETED !
echo.
pause
goto:exit