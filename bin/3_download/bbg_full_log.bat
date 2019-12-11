@echo off

:START_MENU
ECHO.

REM =======================================================
REM version : 2.4a
ECHO ^>^> version : 2.4 (2014.12.31) ^<^<

REM =======================================================
REM modified by : jamiemin.kim
REM 2014.12.31 : change /data/mtslog
REM modified by hankyu.ji for MTK
REM 2014.04.18 : add /storage/external_SD/mtklog
REM 2014.02.20 : add /sdcard/logs/
REM 2014.02.20 : add /sdcard/mtslog
REM 2014.01.02 : add Quick dump and bugreport
REM 2014.01.02 : add Media DB Files 
REM 2013.03.22 : add to debug level change in Enable/Disable all logs menu. (persist.mtk.aee.mode changes 3 or 4)
REM =======================================================
REM modified by hyukmin7.kwon for MTK
REM 2012.11.19 : add /data/data/com.lge.art/files/Report/*.*, data/data/com.lge.art/files/Play/*.*, /data/data/com.lge.art/files/IMG/*.*
REM 2012.11.12 : remove enable and disable MTK feature (2.0B)
REM 2012.11.08 : pull /data/aee_exp/, /data/*.txt (2.0A)
REM 2012.11.01 : bug fix
REM 2012.10.25 : add menu for MTK log. modify menu. (1.91M)
REM =======================================================
REM made by yeunbok.ryu
REM 2012.09.25 : add menus(various way to pull log)
REM 2012.09.09 : add /data/dump folder
REM 2012.08.01 : chnage last dumpreport txt folder
REM 2012.07.19 : fix bug that can't make folder in USA
REM 2012.07.16 : fix bug that hprof_dump is not receiving
REM 2012.07.06 : add /mpt folder 
REM 2012.06.25 : add /data/hprof_dump file (usecase:JNI API overflow)
REM            : add /mnt/sdcard/log for Smart Log Service           
REM 2012.06.07 : add /tombstones log and dumpreport
REM 2012.05.18 : add %INFO_FILE_NAME%(swversion, hw revision, etc)
REM =======================================================

COLOR 0F
set DUMPSTATE=0
set TRUE=1
set FALSE=0

:: Get Directory name =================================================
For /f "tokens=1-3 delims=1234567890 " %%a in ("%time%") Do set "delims=%%a%%b%%c"
For /f "tokens=1-4 delims=%delims%" %%G in ("%time%") Do (
	Set _hh=%%G
	Set _min=%%H
	Set _ss=%%I
	Set _ms=%%J
)

:: Strip any leading spaces
Set _hh=%_hh: =%

:: Ensure the hours have a leading zero
if 1%_hh% LSS 20 Set _hh=0%_hh%
::Echo The time is:   %_hh%:%_min%:%_ss%
:: --------------------------------------------------------------------

:: Set Directory name =================================================
if "%1" == "" (
	set DIR_NAME=%date:~5,10%_%_hh%h_%_min%m_%_ss%s
) else (
	if /i "%1"=="/d" (
		set REMOVE_LOG=1
		set DIR_NAME=%date:~5,10%_%_hh%h_%_min%m_%_ss%s
	) else (
		set DIR_NAME=%1
	)
	if /i "%2"=="/d" (
		set DUMPSTATE=1
		set REMOVE_LOG=1
		goto START_PULLING
	)
)

echo.
echo ================================================================
echo  Choose the number that you want
echo ----------------------------------------------------------------
echo [ For LG Logs ]
echo   1 - Pull all logs except dumpstate 
echo   2 - Pull all logs 
echo   3 - Remove all logs
echo   4 - Enable all logs
echo   5 - Disable all logs
echo ----------------------------------------------------------------
echo [ For MTK Logs ]
echo   6 - Pull MTK logs
echo   7 - Remove MTK logs
echo ----------------------------------------------------------------
echo   H - Help
echo   Q - Quit
echo ================================================================

if "%1" == "/h" goto HELP

set NUM=
set /p NUM=number = ?

if /i "%NUM%" == "" (
	set DUMPSTATE=1
	set REMOVE_LOG=0
	goto START_PULLING
)
if /i "%NUM%" == "1" (
	set DUMPSTATE=0
	set REMOVE_LOG=0
	goto START_PULLING
)
if /i "%NUM%" == "2" (
	set DUMPSTATE=1
	set REMOVE_LOG=0
	goto START_PULLING
)

if /i "%NUM%" == "3" (
ping -n 2 127.0.0.1 >NUL
ECHO -----------------------------------------------
ECHO ^>^> Wait and Checking the Device Connections ^<^<
ECHO ^> Please connect USB to the phone....
ECHO -----------------------------------------------
adb.exe wait-for-device devices
ECHO ^> Checking Done..
ECHO.
adb.exe root
	goto DELETE_LOG
)

if /i "%NUM%" == "4" (
ping -n 2 127.0.0.1 >NUL
ECHO -----------------------------------------------
ECHO ^>^> Wait and Checking the Device Connections ^<^<
ECHO ^> Please connect USB to the phone....
ECHO -----------------------------------------------
adb.exe wait-for-device devices
ECHO ^> Checking Done..
ECHO.
	goto START_LOG
)

if /i "%NUM%" == "5" (
ping -n 2 127.0.0.1 >NUL
ECHO -----------------------------------------------
ECHO ^>^> Wait and Checking the Device Connections ^<^<
ECHO ^> Please connect USB to the phone....
ECHO -----------------------------------------------
adb.exe wait-for-device devices
ECHO ^> Checking Done..
ECHO.
	goto STOP_LOG
)

if /i "%NUM%" == "6" (
	set PULL_MTK=1
	goto START_PULLING
)

if /i "%NUM%" == "7" (
ping -n 2 127.0.0.1 >NUL
ECHO -----------------------------------------------
ECHO ^>^> Wait and Checking the Device Connections ^<^<
ECHO ^> Please connect USB to the phone....
ECHO -----------------------------------------------
adb.exe wait-for-device devices
ECHO ^> Checking Done..
ECHO.
	goto DELETE_MTK_LOG
)

if /i "%NUM%" == "H" goto HELP
if /i "%NUM%" == "Q" goto EXIT

goto EXIT

:START_PULLING
:: set root (it needs for user mode image)
adb.exe root

timeout /t 5

:: check adb status (wait until 'adb root' is done)
ping -n 2 127.0.0.1 >NUL
ECHO -----------------------------------------------
ECHO ^>^> Wait and Checking the Device Connections ^<^<
ECHO ^> Please connect USB to the phone....
ECHO -----------------------------------------------
adb.exe wait-for-device devices
ECHO ^> Checking Done..
ECHO.

:CHECK_DIRNAME
if not exist %DIR_NAME% goto PULL_LOG
ECHO -----------------------------------------------
echo %DIR_NAME% 디렉토리가 존재합니다
set DIR_NAME+=
set /p DUPLICATE=덮어 쓸까요? (y/N)

if /i not "%DUPLICATE%" == "y" goto EXIT

:: ========= PULL_LOG ===========
:PULL_LOG

if /i "%PULL_MTK%" == "1" (
	set DIR_NAME=[MTK]%DIR_NAME%
	
) else (
	set DIR_NAME=[LG]%DIR_NAME%
)

mkdir %DIR_NAME%

:: make %DIR_NAME%/%INFO_FILE_NAME%
FOR /F "delims=" %%a IN ('adb shell date ^| FINDSTR /V "dummy"') DO SET PHONE_DATE=%%a
FOR /F "delims=" %%a IN ('adb shell getprop ro.product.name ^| FINDSTR /V "dummy"') DO SET PRODUCT_NAME=%%a
FOR /F "delims=" %%a IN ('adb shell getprop ro.build.fingerprint ^| FINDSTR /V "dummy"') DO SET PHONE_FINGER=%%a
FOR /F "delims=" %%a IN ('adb shell getprop ro.lge.swversion ^| FINDSTR /V "dummy"') DO SET PHONE_SWV=%%a
FOR /F "delims=" %%a IN ('adb shell getprop ro.lge.factoryversion ^| FINDSTR /V "dummy"') DO SET PHONE_FACTORYV=%%a
FOR /F "delims=" %%a IN ('adb shell getprop ro.lge.hw.revision ^| FINDSTR /V "dummy"') DO SET PHONE_HWVER=%%a
FOR /F "tokens=2 delims=: " %%a IN ('adb shell cat /sys/devices/platform/msm_adc/pcb_revision ^| FINDSTR /V "dummy"') DO SET PHONE_PCB=%%a
FOR /F "delims=" %%a IN ('adb shell getprop ro.build.type ^| FINDSTR /V "dummy"') DO SET PHONE_BUILD_TYPE=%%a

set INFO_FILE_NAME=%PRODUCT_NAME%_%PHONE_BUILD_TYPE%.txt

ECHO ^> Profile of phone....
ECHO [ Device Date ^& TIME at pulling logs] > %DIR_NAME%/%INFO_FILE_NAME%
ECHO ==^> %PHONE_DATE% >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO. >> %DIR_NAME%/%INFO_FILE_NAME%

ECHO [ PRODUCT_NAME ] >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO ==^> %PRODUCT_NAME% >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO. >> %DIR_NAME%/%INFO_FILE_NAME%

ECHO [ PHONE_BUILD_TYPE ] >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO ==^> %PHONE_BUILD_TYPE% >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO. >> %DIR_NAME%/%INFO_FILE_NAME%

ECHO [ Factory Version ] >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO ==^> %PHONE_FACTORYV% >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO. >> %DIR_NAME%/%INFO_FILE_NAME%

ECHO [ SW Version ] >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO ==^> %PHONE_SWV% >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO. >> %DIR_NAME%/%INFO_FILE_NAME%

ECHO [ HW Version ] >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO ==^> %PHONE_HWVER%  (%PHONE_PCB%) >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO. >> %DIR_NAME%/%INFO_FILE_NAME%

ECHO [ Fingerprint ] >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO ==^> %PHONE_FINGER% >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO. >> %DIR_NAME%/%INFO_FILE_NAME%

if /i "%PULL_MTK%" == "1" (
	goto PULL_MTK_LOG
)

echo -------------------------------------------
echo ^>^> extract log files to %DIR_NAME% ^<^<
echo -------------------------------------------


:: ART
ECHO ^> Retrieving ART files

adb.exe pull /data/data/com.lge.art/files/IMG %DIR_NAME%/art/IMG 2> null
adb.exe pull /data/data/com.lge.art/files/Play %DIR_NAME%/art/Play 2> null
adb.exe pull /data/data/com.lge.art/files/Report %DIR_NAME%/art/Report 2> null

:: MTK AEE_EXP

ECHO ^> Retrieving MTK AEE_EXP files (/data/aee_exp, /data/*.txt)...
adb.exe pull /data/aee_exp/ %DIR_NAME%/aee_exp 2> null
adb.exe pull /sdcard/mtklog/aee_exp %DIR_NAME%/mtk/aee_exp/ 2> null

echo @echo off >> pull_temp_7213123.bat
echo mkdir %DIR_NAME%\mtk >> pull_temp_7213123.bat
FOR /F %%i IN ('adb shell ls /data/*.txt') do echo   adb.exe pull %%i %DIR_NAME%/mtk >> pull_temp_7213123.bat
cmd /c pull_temp_7213123.bat
del pull_temp_7213123.bat


:: Android Log
ECHO ^> Retrieving Android Log files(/data/logger, /data/log)...
adb.exe pull /data/logger/ %DIR_NAME%/logger 2> null
adb.exe pull /mnt/sdcard/log/ %DIR_NAME%/smartlog 2> null
adb.exe pull /sdcard/logs/ %DIR_NAME%/logs 2> null

:: ANR
ECHO ^> Retrieving ANR Logs(/data/anr)...
adb.exe pull /data/anr/ %DIR_NAME%/anr 2> null

::Dontpanic
ECHO ^> Retrieving Dontpanic Logs(/data/dontpanic)...
adb.exe pull /data/dontpanic/ %DIR_NAME%/dontpanic 2> null

:: TOMBSTONES
ECHO ^> Retrieving Tombstones Log(/data/tombstones, /tombstones)...
adb.exe pull /data/tombstones/ %DIR_NAME%/tombstones 2> null

:: CHECKERROR REPORTER
ECHO ^> Retrieving ckerror Log(/data/system/ckerror)..
adb.exe pull /data/system/ckerror %DIR_NAME%/ckerror 2> null

:: MLT
ECHO ^> Retrieving mlt db files(/mpt/)..
adb.exe pull /mpt %DIR_NAME%/mlt 2> null

:: MTS Log
ECHO ^> Retrieving MTS Log (/data/mtslog)...
adb.exe pull /data/mtslog/ %DIR_NAME%/mtslog 2> null

:: Multimedia database
ECHO ^> Retrieving MediaDB files(/data/data/com.android.providers.media/databases/)..
adb pull /data/data/com.android.providers.media/databases/ %DIR_NAME%/MediaDB 2> null

::for QuickDump
ECHO ^> Retrieving dumpreports(ckerror handler, QuickDump)
adb.exe pull /storage/sdcard0/dumpreports %DIR_NAME%/dumpreports

:: Bugreport created when cliking Power + Volume Up + Volume down. 
ECHO ^> Retrieving bugreport in case of reference device(HH, astock) (/data/data/com.android.shell/files/bugreports/)..
adb.exe pull /data/data/com.android.shell/files/bugreports/ %DIR_NAME%/dumpreports_native

:: DROPBOX
ECHO ^> Retrieving DROPBOX Log(/data/system/dropbox)..
MKDIR %DIR_NAME%\dropbox
adb shell dumpsys dropbox --print > %DIR_NAME%\dropbox\dropbox_print.txt
adb shell dumpsys dropbox --file > %DIR_NAME%\dropbox\dropbox_files.txt
adb.exe pull /data/system/dropbox %DIR_NAME%/dropbox 2> null
::adb.exe pull /proc/last_kmsg %DIR_NAME%/last_kmsg.log

:: Hprof_dump => ex : JNI 2000 overflow
ECHO ^> Retrieving hprof_dump (/data/hprof_dump)..
adb.exe pull /data/hprof_dump_1701.hprof %DIR_NAME% 2> null
adb.exe pull /data/hprof_dump_1801.hprof %DIR_NAME% 2> null
adb.exe pull /data/hprof_dump_1901.hprof %DIR_NAME% 2> null
adb.exe pull /data/hprof_dump_final.hprof %DIR_NAME% 2> null

:: dump file (Vol up + down + power key Long Click) 
ECHO ^> Retrieving dump files(/data/dump)..
adb.exe pull /data/dump %DIR_NAME%/dump 2> null

:: DUMPSTATE
if /i "%DUMPSTATE%" == "1" (
	ECHO ^> Capturing dumpstate Logs[adb shell dumpstate]
	ECHO     =^>.. It takes 1~2 minutes
	adb shell dumpstate > %DIR_NAME%/last_dumpstate.txt
)
echo -------------------------------------------
ECHO ^>^> All Logs are saved into %DIR_NAME%
echo -------------------------------------------
set PRINT_DIRECTORY=1
::echo REMOVE_LOG = %REMOVE_LOG%
if /i "%REMOVE_LOG%" == "1" goto DELETE_LOG

pause

explorer %DIR_NAME%

goto START_MENU

:: ========= DELETE_LOG ===========
:DELETE_LOG
echo -------------------------------------------
echo ^>^> Deleting log files ^<^<
echo -------------------------------------------
::ECHO ^> Deleting /data/aee_exp/ ...
adb.exe shell rm -r /data/aee_exp/* 2> null
::ECHO ^> Deleting /data/logger/ ...
adb.exe shell rm -r /data/logger/* 2> null
::ECHO ^> Deleting /mnt/sdcard/log/ ...
adb.exe shell rm /mnt/sdcard/log/* 2> null
::ECHO ^> Deleting /data/anr/ ...
adb.exe shell rm /data/anr/* 2> null
::ECHO ^> Deleting /data/dontpanic/ ...
adb.exe shell rm /data/dontpanic/* 2> null
::ECHO ^> Deleting /data/system/dropbox/ ...
adb.exe shell rm -r /data/system/dropbox/* 2> null
::ECHO ^> Deleting /data/system/ckerror/ ...
adb.exe shell rm -r /data/system/ckerror/* 2> null
::ECHO ^> Deleting /data/tombstones/ ...
adb.exe shell rm /data/tombstones/* 2> null
::ECHO ^> Deleting /tombstones/ ...
adb.exe shell rm -r /tombstones/* 2> null
::ECHO ^> Deleting data/hprof files...
adb.exe shell rm /data/hprof_dump_1701.hprof 2> null
adb.exe shell rm /data/hprof_dump_1801.hprof 2> null
adb.exe shell rm /data/hprof_dump_1901.hprof 2> null
adb.exe shell rm /data/hprof_dump_final.hprof 2> null
adb.exe shell rm /data/data/com.lge.art/files/Report/*  2> null
adb.exe shell rm /data/data/com.lge.art/files/Report/*  2> null

ECHO ^>^> All Logs are deleted ^<^<
ECHO -----------------------------------------------

pause
goto START_MENU

:: Restart log service (stop & start)
:STOP_LOG
echo ^>^> Stop Log Service ^<^<
adb.exe shell setprop persist.service.main.enable 0 2> null
adb.exe shell setprop persist.service.system.enable 0 2> null
adb.exe shell setprop persist.service.radio.enable 0 2> null
adb.exe shell setprop persist.service.events.enable 0 2> null
adb.exe shell setprop persist.service.kernel.enable 0 2> null
adb.exe shell setprop persist.mtk.aee.mode 4 2> null
::adb.exe shell setprop ctl.stop clear-kernel-log 2> null
goto CHECK_LOG_SERVICE

:START_LOG
echo ^>^> Start Log Service ^<^<
adb.exe shell setprop persist.service.main.enable 1 2> null
adb.exe shell setprop persist.service.system.enable 1 2> null
adb.exe shell setprop persist.service.radio.enable 1 2> null
adb.exe shell setprop persist.service.events.enable 1 2> null
adb.exe shell setprop persist.service.kernel.enable 1 2> null
adb.exe shell setprop persist.mtk.aee.mode 3 2> null
::adb.exe shell setprop ctl.start clear-kernel-log 2> null
goto CHECK_LOG_SERVICE

:CHECK_LOG_SERVICE
echo ^>^> Checking Log Service ^<^<
echo Main Log Service 확인중..
adb.exe shell getprop persist.service.main.enable 2>null
echo System Log Service 확인중..
adb.exe shell getprop persist.service.system.enable 2>null
echo Radio Log Service 확인중..
adb.exe shell getprop persist.service.radio.enable 2>null
echo Event Log Service 확인중..
adb.exe shell getprop persist.service.events.enable 2>null
echo Kernel Log Service 확인중..
adb.exe shell getprop persist.service.kernel.enable 2>null
echo Debug Utils 확인중..
adb.exe shell getprop persist.mtk.aee.mode 2>null

pause
goto START_MENU

:: ========= MTK LOG ========= 
:PULL_MTK_LOG
echo.
echo ^> Retrieving MTK Log files...
echo.
adb.exe pull /storage/sdcard0/mtklog %DIR_NAME% 2> null
adb.exe pull /storage/external_SD/mtklog %DIR_NAME%/external_SD 2> null

pause
explorer %DIR_NAME%
goto START_MENU

:DELETE_MTK_LOG
echo -------------------------------------------
echo ^>^> Deleting log files ^<^<
echo -------------------------------------------
adb.exe shell rm -r /storage/sdcard0/mtklog/*  2> null
adb.exe shell rm -r /storage/external_SD/mtklog/*  2> null

pause
goto START_MENU

:ENABLE_MTK_LOG
echo.
echo ^> Enabling MTK Log...
echo.
adb.exe shell am broadcast -a com.mediatek.syslogger.action  --es Satan Angel --es From CommonUI --es To ModemLog --es Command Start 2>null
adb.exe shell am broadcast -a com.mediatek.syslogger.action  --es Satan Angel --es From CommonUI --es To MobileLog --es Command Start 2>null
adb.exe shell am broadcast -a com.mediatek.syslogger.action  --es Satan Angel --es From CommonUI --es To ActivityNetworkLog --es Command Start 2>null
adb.exe shell am broadcast -a com.mediatek.syslogger.action  --es Satan Angel --es From CommonUI --es To ExtModemLog --es Command Start 2>null

pause
goto START_MENU

:DISABLE_MTK_LOG
echo.
echo ^> Disabling MTK Log...
echo     =^>.. It takes about 20 seconds for fully disable.
echo.
adb.exe shell am broadcast -a com.mediatek.syslogger.action  --es Satan Angel --es From CommonUI --es To ModemLog --es Command Stop 2>null
adb.exe shell am broadcast -a com.mediatek.syslogger.action  --es Satan Angel --es From CommonUI --es To MobileLog --es Command Stop 2>null
adb.exe shell am broadcast -a com.mediatek.syslogger.action  --es Satan Angel --es From CommonUI --es To ActivityNetworkLog --es Command Stop 2>null
adb.exe shell am broadcast -a com.mediatek.syslogger.action  --es Satan Angel --es From CommonUI --es To ExtModemLog --es Command Stop 2>null
pause
goto START_MENU

:: ========= HELP ===========
:HELP
@echo off
echo Pull log files using ADB
echo.
echo Usage : %0 [directory_name] [/d]
echo.
echo   directory_name    Directory name where to save log.
echo   /d                Deleting all logs in the device.
echo.
echo see the wiki page : http://dev.lge.com/wiki/v5_tdr/pull_log_v5
echo.

:QUIT
if /i "%PRINT_DIRECTORY%"=="1" (
	ECHO -----------------------------------------------
	ECHO ^>^> Dir : %cd%\%DIR_NAME%
	ECHO -----------------------------------------------
)

:EXIT
COLOR
echo.
pause

