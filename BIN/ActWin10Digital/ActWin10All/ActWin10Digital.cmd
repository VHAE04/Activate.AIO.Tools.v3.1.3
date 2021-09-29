CHCP 1258 >nul 2>&1
CHCP 65001 >nul 2>&1
@echo off

::===========================================================================
fsutil dirty query %systemdrive%  >nul 2>&1 || (
echo.
echo ================================================================
echo                          ==== LỖI ====
echo Script này yêu cầu quyền Quản trị hệ thống. Để Script hoạt động.
echo Hãy nhấp chuột phải vào file .cmd và chọn 'Run as administrator'
echo ================================================================
echo.
echo Nhấn phím bất kỳ để thoát...
pause >nul
exit
)
::===========================================================================

color f0
mode con cols=98 lines=30
title Script Kích Hoạt Bản Quyền Số Windows 10 Vĩnh Viễn - Copyright (C) All rights reserved.
setlocal EnableExtensions EnableDelayedExpansion
pushd "%~dp0"
cd /d "%~dp0"

:======================================================================================================================================================
:MAINMENU
cls
mode con cols=98 lines=30
FOR /F "TOKENS=2 DELIMS==" %%A IN ('"WMIC PATH SoftwareLicensingProduct WHERE (Name LIKE 'Windows%%' AND PartialProductKey is not NULL) GET LicenseFamily /VALUE"') DO IF NOT ERRORLEVEL 1 SET "osedition=%%A"
IF NOT DEFINED osedition (
cls
FOR /F "TOKENS=3 DELIMS=: " %%A IN ('DISM /English /Online /Get-CurrentEdition 2^>nul ^| FIND /I "Current Edition :"') DO SET "osedition=%%A"
echo     ======================================================================================
echo     Không tìm thấy khóa sản phẩm, Có thể việc phát hiện Phiên bản Windows không chính xác,
echo                    Hãy sử dụng lựa chọn "[5] Thay đổi Phiên bản Windows 10".
echo     ======================================================================================
echo.
pause
)
for /f "tokens=2 delims==" %%a IN ('"wmic Path Win32_OperatingSystem Get Version /format:LIST"')do (set Version=%%a) >nul 2>&1
cls   
echo.                     _________________________________________________________
echo.
echo                         Windows 10 %osedition% %Version%                       
echo.                     _________________________________________________________
echo.                    ^|                                                         ^|
Echo.                    ^|   [1] Kích hoạt bản quyền số Windows 10 VĨNH VIỄN.      ^|
Echo.                    ^|                                                         ^|
Echo.                    ^|   [2] Kích hoạt Windows 10 và Windows Server tới 2038.  ^|
Echo.                    ^|                                                         ^|
Echo.                    ^|   [3] Kiểm tra trạng thái kích hoạt của Windows.        ^|
Echo.                    ^|                                                         ^|
Echo.                    ^|   [4] _Thông tin về Script Kích hoạt_                   ^|
Echo.                    ^|                   _______________                       ^|
echo.                    ^|                                                         ^| 
Echo.                    ^|   [5] Chèn Key mặc định.                                ^|
Echo.                    ^|                                                         ^|
Echo.                    ^|   [6] Thay đổi Phiên bản Windows 10.                    ^|
Echo.                    ^|                                                         ^|
Echo.                    ^|   [7] Trích xuất Thư mục $OEM$ ra Desktop.              ^|
Echo.                    ^|                   _______________                       ^|
echo.                    ^|                                                         ^|  
Echo.                    ^|   [8] Kiểm tra Cập nhật Script.                         ^|
Echo.                    ^|                                                         ^|
Echo.                    ^|   [9] Thoát.                                            ^|
Echo.                    ^|_________________________________________________________^|
ECHO.            
choice /C:123456789 /N /M ".                    Nhập lựa chọn của bạn [1,2,3,4,5,6,7,8,9] : "
if errorlevel 9 goto:Exit
if errorlevel 8 goto:CheckForUpdates
if errorlevel 7 goto:Extract
if errorlevel 6 goto:EditionChange
if errorlevel 5 goto:InsertProductKey
if errorlevel 4 goto:ReadMe
if errorlevel 3 goto:Check
if errorlevel 2 goto:temp2 2
if errorlevel 1 goto:temp 1

:======================================================================================================================================================
:ReadMe
cls
mode con cols=98 lines=135

call :create_file  %0 "%TEMP%\ReadMe.txt" "REM ReadMe Start" "REM ReadMe End"
goto :TempReadMe
REM ReadMe Start
 ===============================================================================================
 
 # Giới thiệu:                                                                                 
                                                                                               
 - Script kích hoạt bản quyền kỹ thuật số Windows 10.                                          
   Kích hoạt Windows 10 VĨNH VIỄN với giấy phép kỹ thuật số.                                   
   [Tất cả các file sạch 100% khi kiểm tra bằng Virus total]                                   
                                                                                               
 ===============================================================================================
 
 # Chú ý:                                                                                      
                                                                                               
 * Script này không cài đặt bất kỳ tệp nào trong hệ thống của bạn.                             
                                                                                               
 - Để kích hoạt thành công, thì dịch vụ Windows Update và Internet phải được bật.              
                                                                                               
 - Khi kích hoạt sử dụng VPN, các công cụ chống gián điệp, chỉnh sửa file hosts và tường lửa   
   có thể chặn máy chủ kích hoạt của Microsoft gây ra lỗi khi kích hoạt.                       
                                                                                               
 - Trong quá trình kích hoat bạn có thể thấy lỗi 'Blocked key' hoặc một số mã lỗi khác.        
   Nguyên nhân gây ra những lỗi này có thể do trước đó bạn sử dụng phần mềm để Crack Win,      
   tool để tối ưu Win, sử dụng KMS, bản Ghost Win đã tinh chỉnh....                            
   Hoặc lỗi do 1 trong 2 mục đã đề cập ở trên. Tip Fix Lỗi bên dưới có thể giúp bạn khắc phục. 
                                                                                               
 - Sau khi kích hoạt, Trên cung phần cứng, nếu bạn cài đặt lại Windows 10 đúng phiên bản đó,   
   hệ thống sẽ tự động kích hoạt nhưng điều này chỉ áp dụng cho bộ cài Retail của Windows 10   
   (tức file iso Consumer: S/SL/Home/Pro/Edu).                                                 
   Nếu bạn đang sử dụng bộ cài Volume(VL) của Windows 10 (tức file iso Business: Pro/Enter/Edu)
   Khi cài lại hoặc update Win bị mất bản quyền thì bạn sẽ phải sử dụng lựa chọn               
   "[4] Chèn Key mặc định" Sau đó Windows 10 của bạn sẽ tự động kích hoạt lại.                 
   (Bạn có thể chèn key theo cách thủ công hoặc sử dụng lựa chọn [4] tùy ý. Điều này giúp bạn  
   tiết kiệm thời gian tránh phải kích hoạt lại).                                              
                                                                                               
 ===============================================================================================
 
 # Tạo file iso Windows 10 kích hoạt tự động:                                                  
                                                                                               
 - Để tạo file iso kích hoạt tự động hãy thực hiện thao tác sau:                               
   Sử dụng tùy chọn [6] của Script và trích xuất thư mục $OEM$ ra Desktop.                     
   Tiếp theo sao chép thư mục $OEM$ này vào thư mục "sources" trong file iso gốc.              
   Theo đường dẫn. iso/usb:\sources\$OEM$\                                                     
   Cuối cùng sử dụng iso/usb này để cài đặt Windows 10 và nó sẽ tự động kích hoạt khi          
   bạn có kết nối Internet.                                                                    
                                                                                               
 ===============================================================================================

 # Tip Fix Lỗi:                                                                                
                                                                                               
 * Nếu trong quá trình kích hoạt gặp lỗi, Hãy thử reset lại file Tokens.dat bằng cách sau:     
 - Chạy CMD (command prompt) với quyền quản trị (run as admin...). Copy-paste lệnh dưới vào.
  
   net stop sppsvc
   ren %windir%\System32\spp\store\2.0\tokens.dat tokens.bar
   net start sppsvc
   cscript %windir%\system32\slmgr.vbs /rilc

 - Đợi quá trình trên hoàn tất, Reset máy lại 2 lần.
 - Sau đó hãy chạy Script để thử kích hoạt lại.
											       
 ===============================================================================================
 
 # Các phiên bản Windows 10 được hỗ trợ:                                                       
                                                                                               
 - Home(Core) - Home N                                                                         
 - CoreSingleLanguage - CoreSingleLanguage N                                                   
 - Professional - Professional N                                                               
 - ProfessionalEducation - ProfessionalEducation N                                             
 - ProfessionalWorkstation - ProfessionalWorkstation N                                         
 - Education - Education N                                                                     
 - Enterprise - Enterprise N                                                                   
 - EnterpriseS (LTSB 2016) - EnterpriseS (LTSB 2016) N                                         
                                                                                               
 (Trình kích hoạt này không kích hoạt Windows 10 version 1507)                                 
                                                                                               
 ===============================================================================================
 
 # Tác giả:                                                                                    
                                                                                               
 s1ave77       - Tác giả gốc Phương pháp kích hoạt giấy phép kỹ thuật số hwid mk3.             
                                                                                               
 mephistooo2   - Đóng gói lại phiên bản cmd của s1ave77.                                       
                                                                                               
 WindowsAddict   Tạo phiên bản sạch sẽ, cải tiến,                                              
 Savio         - Cung cấp hỗ trợ tuyệt vời trong chỉnh sửa, dịch                               
 rpo             và cải tiến trong script này.                                                 
                                                                                               
 ===============================================================================================
 
 # Link hữu ích:                                                                               
	                                                                                       
 - Script kích hoạt Windows 10 bản quyền Vĩnh Viễn: https://bit.ly/KichHoatBanQuyenVinhVien     
 - Script Kích hoạt Win và Office Online 6 tháng: https://bit.ly/KichHoatWindowsVaOfficeOnline  
 - Kích hoạt Bản Quyền Số Win10 Pro bằng Key Win 7-8-8.1: https://bit.ly/KichHoatW10BangKeyW7W8 
 - Sao lưu bản quyền Windows và Office: https://bit.ly/SaoLuuBanQuyen                           
 - Link tải Windows và Office nguyên gốc Microsoft: https://bit.ly/LinkTaiISO                   
 - Link tải các bản Win10 tự kích hoạt bản quyền Vĩnh Viễn: https://bit.ly/ActivateDigitalISO   
 - Key Windows 10 và Windows Server - Mặc Định của Microsoft: https://bit.ly/KeyGeneric         
 - Link tải Win10 Enterprise LTSB 2016 x64 nguyên gốc: https://bit.ly/enterpriseLTSB2016x64     
 - Link tải Win10 Enterprise LTSB 2016 x32 nguyên gốc: https://bit.ly/enterpriseLTSB2016x32     
 - Link tải Win10 Enterprise LTSC 2019 x64 nguyên gốc: https://bit.ly/LTSC2019x64               
 - Link tải Win10 Enterprise LTSC 2019 x32 nguyên gốc: https://bit.ly/LTSC2019x32               
 - Trang GetLink Fshare của J2team: https://bit.ly/GetLinkFshare                                
 - Hướng dẫn tối ưu, Fix lỗi Full Disk 100%: https://bit.ly/FullDisk                            
 - Phần mềm VPN, Fake IP: https://bit.ly/VPNGateClient                                          
 - Phần mềm hỗ trợ duyệt tab trong Office như trên trình duyệt Web: https://bit.ly/OfficeTabver13
 - Key Activate các phần mềm Adobe CS6 cho Windows và MAC: https://bit.ly/KeyCS6                
 - Key Eset bản quyền: https://bit.ly/KeyEset                                                   
 - Key Kaspersky Internet Security 2019 hạn đến 2020: http://bit.ly/KIS2019                     
 - Thủ thuật cài Win - Fix Lỗi - Tối Ưu... : http://bit.ly/ThuThuatWin                          
                                                                                                
 ===============================================================================================
 
REM ReadMe End

:TempReadMe
type "%temp%\ReadMe.txt"
echo.
echo Nhấn phím bất kỳ để tiếp tục...
pause >nul
del /f /q "%temp%\ReadMe.txt"
goto:MAINMENU

::===========================================================
:temp
start temp.cmd
EXIT
)

:temp2
start temp2.cmd
EXIT
)

:======================================================================================================================================================
:HWIDActivate
cls
echo    ==========================================================================================
echo    +++ Lưu ý - Để kích hoạt thành công, Dịch vụ Windows Update và Internet phải được BẬT +++
echo    ==========================================================================================
echo.
echo    Kích hoạt Bản quyền Kỹ thuật số Windows 10 %osedition% %Version%
echo.
choice /C:QT /N /M "[T] Tiếp tục Kích hoạt [Q] Quay lại : "
        if %errorlevel%==1 Goto:MainMenu
		cls
::===========================================================
CLS
wmic path SoftwareLicensingProduct where (LicenseStatus='1' and GracePeriodRemaining='0' and PartialProductKey is not NULL) get Name 2>nul | findstr /i "Windows" 1>nul && (
echo.
echo ==================================================================
echo Kiểm tra: Windows 10 %osedition% được Kích hoạt VĨNH VIỄN.
echo Bạn không cần phải Kích hoạt lại.
echo ==================================================================
echo.
echo.
choice /C:KQ /N /M "[K] Tôi vẫn muốn Kích hoạt [Q] Quat lại : "
if errorlevel 2 goto:MainMenu
if errorlevel 1 Goto:continue
)
::===========================================================
:continue
cls
call:key
for /f "tokens=1-4 usebackq" %%a in ("%temp%\editions") do (if ^[%%a^]==^[%osedition%^] (
    set edition=%%a
    set key=%%b
    set sku=%%c
    set editionId=%%d
    goto:parseAndPatch))
echo:
echo %osedition% Không được Hỗ trợ Kích hoạt Bản quyền Kỹ thuật Số.
echo:
echo Nhấn phím bất kỳ để tiếp tục...
del /f "%temp%\editions"
pause >nul
goto:MainMenu
::===========================================================
:parseAndPatch
echo      =======================================================================================
echo             Kích hoạt Bản quyền Kỹ thuật số Windows 10 %osedition% %Version%
echo      =======================================================================================
echo.

cd /d "%~dp0"
set "gatherosstate=bin\gatherosstate.exe"

echo Đang cài đặt khóa sản phẩm mặc định cho Windows 10 %osedition% ...
cscript /nologo %windir%\system32\slmgr.vbs -ipk %key%

echo Đang tạo registry để Kích hoạt...
reg add "HKLM\SYSTEM\Tokens" /v "Channel" /t REG_SZ /d "Retail" /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Kernel-ProductInfo" /t REG_DWORD /d %sku% /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Security-SPP-GenuineLocalStatus" /t REG_DWORD /d 1 /f

echo Đang tạo tệp GenuineTicket.XML cho Windows 10 %osedition% ...
start /wait "" "%gatherosstate%"
timeout /t 3 >nul 2>&1

echo Tệp GenuineTicket.XML đang được cài đặt cho Windows 10 %osedition% ...
clipup -v -o -altto bin\
cscript /nologo %windir%\system32\slmgr.vbs -ato

echo Đang xóa các registry đã tạo...
reg delete "HKLM\SYSTEM\Tokens" /f
del /f "%temp%\editions"

echo:
echo Nhấn phím bất kỳ để tiếp tục...
pause >nul
goto:MainMenu

:======================================================================================================================================================
:Check
CLS
echo ======================================================================
echo.
cscript //nologo %systemroot%\System32\slmgr.vbs /dli
cscript //nologo %systemroot%\System32\slmgr.vbs /xpr
echo.
echo ======================================================================
echo.
echo Nhấn phím bất kỳ để tiếp tục...
pause >nul
goto:MainMenu

:======================================================================================================================================================
:InsertProductKey
CLS
echo:
call:key
for /f "tokens=1-4 usebackq" %%a in ("%temp%\editions") do (if ^[%%a^]==^[%osedition%^] (
    set edition=%%a
    set key=%%b
    set sku=%%c
    set editionId=%%d
    goto :Insertkey))
echo %osedition% Không được Hỗ trợ Kích hoạt Bản quyền Kỹ thuật Số.
echo Nhấn phím bất kỳ để tiếp tục...
del /f "%temp%\editions"
pause >nul
goto:MainMenu
:Insertkey
CLS
echo:
echo =============================================================
echo Đang cài đặt khóa sản phẩm cho Windows 10 %osedition%
echo =============================================================
echo:
cscript /nologo %windir%\system32\slmgr.vbs -ipk %key%
echo:
echo Nhấn phím bất kỳ để tiếp tục...
del /f "%temp%\editions"
pause >nul
goto:MAINMENU

:======================================================================================================================================================
:EditionChange
cls
echo ========================================================================================
echo Lưu ý: Script này không thể thay đổi phiên bản Home(Core) mặc định thành phiên bản khác
echo  Để làm điều này, hãy Copy Key mặc định của phiên bản Pro VK7JG-NPHTM-C97JM-9MPGT-3V66T
echo     Rồi vào Setting - Updated and Secure - Activation: chèn Key vào Change Product.
echo.
echo ========================================================================================
echo Bạn có thể thay đổi Phiên bản Hiện tại của mình thành một trong những Phiên bản sau:
echo ========================================================================================
echo.
for /f "tokens=4" %%a in ('dism /online /english /Get-TargetEditions ^| findstr /i /c:"Target Edition : "') do echo %%a
echo.
choice /C:QT /N /M "[T] Tiếp tục [Q] Quay lại : "
        if %errorlevel%==1 Goto:MainMenu
Echo.
for /f "tokens=4" %%a in ('dism /online /english /Get-TargetEditions ^| findstr /i /c:"Target Edition : "') do (
    set osedition=%%a
    choice /C:KC /N /M "Bạn có muốn thay đổi sang phiên bản %%a không? [C,K] : "
    if errorlevel 2 (
	call:key
        for /f "tokens=1-4 usebackq" %%a in ("%temp%\editions") do (if ^[%%a^]==^[!osedition!^] (
        set edition=%%a
        set key=%%b
		cls
		echo.
		echo.
		echo =====================================================================
        echo Thay đổi Key !key! cho Windows 10 phiên bản !osedition!
        cscript /nologo %windir%\system32\slmgr.vbs -ipk !key!
		echo =====================================================================
		echo. 
		echo Nhấn phím bất kỳ để tiếp tục...
		del /f "%temp%\editions"
        pause >nul
        goto :MainMenu))
    echo Không được Hox trợ.
    echo Nhấn phím bất kỳ để tiếp tục...
	del /f "%temp%\editions"
    pause >nul
    goto:MainMenu))
	goto:MainMenu
	
:======================================================================================================================================================
:Extract
cls
mode con cols=98 lines=30
echo     ==================================================================================
echo      Lưu ý: Tùy chọn này sẽ tạo thư mục $OEM$ của Script kích hoạt này trên Desktop,   
echo             Bạn có thể sử dụng để tạo file cài đặt Windows tự động kích hoạt.
echo             Để biết thêm thông tin, hãy sử dụng [3] _Thông tin về Script Kích hoạt_
echo     ==================================================================================
echo.
choice /C:QT /N /M "[T] Tạo thư mục $OEM$ [Q] Quay lại : "
        if %errorlevel%==1 Goto:MainMenu
		cls
echo WScript.Echo WScript.CreateObject^("WScript.Shell"^).SpecialFolders^("Desktop"^) >"%temp%\desktop.vbs"
for /f "tokens=* delims=" %%a in ('cscript //nologo "%temp%\desktop.vbs"') do (set DESKTOPDIR=%%a&del "%temp%\desktop.vbs">nul)
cd /d "%desktopdir%"
IF EXIST $OEM$ (
echo.
echo.
echo               ================================================
echo                    Lỗi - Thư mục $OEM$ không được tạo vì 
echo                  Một thư mục $OEM$ đã tồn tại trên Desktop.
echo               ================================================
echo. 
echo Nhấn phím bất kỳ để tiếp tục...
pause >nul
goto:MAINMENU

) ELSE (
md $OEM$\$$\Setup\Scripts\BIN
cd /d "%~dp0"
copy BIN\gatherosstate.exe "%desktopdir%\$OEM$\$$\Setup\Scripts\BIN"
copy BIN\slc.dll "%desktopdir%\$OEM$\$$\Setup\Scripts\BIN"
)
cd /d "%desktopdir%\$OEM$\$$\Setup\Scripts\"

call :create_file  %0 "%desktopdir%\$OEM$\$$\Setup\Scripts\SetupComplete.cmd" "REM SetupComplete Start" "REM SetupComplete End"
goto :SetupCompleteCreated

REM SetupComplete Start
@Echo off 
pushd "%~dp0"
cd /d "%~dp0"
::===========================================================================
call:key
FOR /F "TOKENS=2 DELIMS==" %%A IN ('"WMIC PATH SoftwareLicensingProduct WHERE (Name LIKE 'Windows%%' AND PartialProductKey is not NULL) GET LicenseFamily /VALUE"') DO IF NOT ERRORLEVEL 1 SET "osedition=%%A"
for /f "tokens=1-4 usebackq" %%a in ("%temp%\editions") do (if ^[%%a^]==^[%osedition%^] (
    set edition=%%a
    set key=%%b
    set sku=%%c
    set editionId=%%d
    goto :parseAndPatch))
echo %osedition% Khong duoc Ho tro Kich hoat Ban quyen Ky thuat So.
del /f "%temp%\editions"
exit
::===========================================================================
:parseAndPatch
cd /d "%~dp0"
set "gatherosstate=bin\gatherosstate.exe"
cscript /nologo %windir%\system32\slmgr.vbs -ipk %key%
reg add "HKLM\SYSTEM\Tokens" /v "Channel" /t REG_SZ /d "Retail" /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Kernel-ProductInfo" /t REG_DWORD /d %sku% /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Security-SPP-GenuineLocalStatus" /t REG_DWORD /d 1 /f
start /wait "" "%gatherosstate%"
timeout /t 3 >nul 2>&1
clipup -v -o -altto bin\
cscript /nologo %windir%\system32\slmgr.vbs -ato
reg delete "HKLM\SYSTEM\Tokens" /f
del /f "%temp%\editions"
cd %~dp0
rmdir /s /q "%windir%\setup\scripts" >nul 2>&1
exit
::===========================================================================
:key
rem              Edition                          Key              SKU EditionId
(
echo Cloud                          V3WVW-N2PV2-CGWC3-34QGF-VMJ2C 178 X21-32983
echo CloudN                         NH9J3-68WK7-6FB93-4K3DF-DJ4F6 179 X21-32987
echo Core                           YTMG3-N6DKC-DKB77-7M9GH-8HVX7 101 X19-98868
echo CoreCountrySpecific            N2434-X9D7W-8PF6X-8DV9T-8TYMD  99 X19-99652
echo CoreN                          4CPRK-NM3K3-X6XXQ-RXX86-WXCHW  98 X19-98877
echo CoreSingleLanguage             BT79Q-G7N6G-PGBYW-4YWX6-6F4BT 100 X19-99661
echo Education                      YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY 121 X19-98886
echo EducationN                     84NGF-MHBT6-FXBX8-QWJK7-DRR8H 122 X19-98892
echo Enterprise                     XGVPP-NMH47-7TTHJ-W3FW7-8HV2C   4 X19-99683
echo EnterpriseN                    3V6Q6-NQXCX-V8YXR-9QCYV-QPFCT  27 X19-98746
echo EnterpriseS                    NK96Y-D9CD8-W44CQ-R8YTK-DYJWX 125 X21-05035
echo EnterpriseSN                   2DBW3-N2PJG-MVHW3-G7TDK-9HKR4 126 X21-04921
echo Professional                   VK7JG-NPHTM-C97JM-9MPGT-3V66T  48 X19-98841
echo ProfessionalEducation          8PTT6-RNW4C-6V7J2-C2D3X-MHBPB 164 X21-04955
echo ProfessionalEducationN         GJTYN-HDMQY-FRR76-HVGC7-QPF8P 165 X21-04956
echo ProfessionalN                  2B87N-8KFHP-DKV6R-Y2C8J-PKCKT  49 X19-98859
echo ProfessionalWorkstation        DXG7C-N36C4-C4HTG-X4T3X-2YV77 161 X21-43626
echo ProfessionalWorkstationN       WYPNQ-8C467-V2W6J-TX4WX-WT2RQ 162 X21-43644
echo ServerRdsh                     NJCF7-PW8QT-3324D-688JX-2YV66 175 X21-41295
) > "%temp%\editions" &exit /b
::===========================================================================
REM SetupComplete End
:SetupCompleteCreated
cls
echo.
echo.
echo ====================================================
echo   Thư mục $OEM$ được tạo thành công trên Desktop.
echo ====================================================
echo Nhấn phím bất kỳ để tiếp tục...
pause >nul
goto:MAINMENU

:======================================================================================================================================================
:CheckForUpdates
start https://www.facebook.com/HoiQuanCongNgheTinHoc/posts/971960172972652
goto:MAINMENU

:======================================================================================================================================================
:Exit
cls
echo.
echo.
echo.
echo.               =============================================================
echo.                                                                   
echo.               Thanks to s1ave77, mephistooo2, WindowsAddict, Savio and rpo.
echo.                                                                    
echo.               =============================================================
echo.
echo.
echo Nhấn phím bất kỳ để Thoát.
pause > nul
exit

:======================================================================================================================================================
:create_file
(
echo Set objFso = CreateObject^("Scripting.FileSystemObject"^)
echo Set InputFile = objFso.OpenTextFile^("%~1"^)
echo Set OutputFile = objFso.CreateTextFile^("%~2", True^)
echo trigger = False
echo Do Until InputFile.AtEndOfStream
echo line=InputFile.ReadLine
echo If trigger=True Then If line="%~4" Then Exit Do Else OutputFile.WriteLine line
echo If line="%~3" Then trigger=True
echo Loop
echo InputFile.Close
echo OutputFile.close
)>"%temp%\create_file.txt"&cmd /u /c type "%temp%\create_file.txt">"%temp%\create_file.vbs"
"%temp%\create_file.vbs"&del /q "%temp%\create_file.*"&exit /b
:======================================================================================================================================================