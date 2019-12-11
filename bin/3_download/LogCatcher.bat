@echo off

REM =======================================================
REM version : 2.35
REM made by yeunbok.ryu
REM 2015.01.19 : add recovery Logs
REM 2015.01.13 : append '/' to the end of directory name(ckerror) to fix the copy failure due to selinux 
REM 2014.05.12 : add f option to rm 
REM 2014.05.12 : change "adb.exe root" to "adb.exe wait-for-device root"
REM 2013.12.16 : change dumpstate to bugreport for selinux violation
REM 2013.10.27 : adb bugreport for aosp device
REM 2013.08.06 : mtklog minor change
REM 2013.05.28 : remove mlt log for security
REM 2013.03.28 : add Media DB Files 
REM 2013.03.25 : add MOCA log files for the modem, fuction that get directory name from user.
REM 2013.02.15 : add function that copy logs to /storage/sdcard0/ using PLT reporter 
REM 2013.01.28 : remove /tombstones log. It is same as /data/tombstones folder
REM 2012.12.11 : add art report files(/data/data/com.lge.art/files/Report/)
REM 2012.11.05 : add dropbox tag files using dumpsys dropbox (--print) options
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
set PRINT_DIRECTORY=0

echo =========================================================================================================
ECHO **************************
ECHO ***   LG Log Catcher   ***
ECHO ***   version : 2.35    ***
ECHO **************************

echo.
ECHO [ Refer to the following urls about android log information ]
ECHO   ==^> * How to get log : http://collab.lge.com/main/pages/viewpage.action?pageId=291788363  
ECHO   ==^> * Android log system : http://collab.lge.com/main/display/MCLAP/Android+Log+System  
ECHO   ==^> * Android log file anlaysis : http://collab.lge.com/main/pages/viewpage.action?pageId=101211784  
ECHO   ==^> * dumpreport anlaysis : http://collab.lge.com/main/pages/viewpage.action?pageId=132054931  
ECHO   ==^> * ANR debugging : http://collab.lge.com/main/pages/viewpage.action?pageId=142907866
ECHO   .                     http://collab.lge.com/main/pages/viewpage.action?pageId=142910677  


:: Get the default directory name ================================================================================
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
set DIR_NAME=

if "%1" == "" (
	goto SET_DIRECTORY	
) else (
	set DIR_NAME=%1
	goto MENU
)

:SET_DIRECTORY
echo =========================================================================================================
echo  Input directory name to save log files [default:MM-DD_HH_MM_SS].
set /p DIR_NAME= ^>  

if /i "%DIR_NAME%" == "" (
	set DIR_NAME=%date:~5,10%_%_hh%h_%_min%m_%_ss%s
)
echo ----------------------------------------------------------------
echo Directory name = %DIR_NAME%
echo ================================================================

:MENU
echo.
echo ================================================================
echo  Choose the number that you want [default:1]
echo ----------------------------------------------------------------
echo  1 - All logs + Dumpreport + Remove removable logs
echo  2 - All logs + Dumpreport
echo  3 - All logs + Remove removalble logs(need root permission)
echo  4 - All logs 
echo  5 - Remove removable logs(need root permission)
echo  6 - Help
echo  7 - Quit
echo ================================================================
echo notice : Logcatcher will stop when removing logs in L OS

if "%1" == "/h" goto HELP

set NUM=
set /p NUM= ^>

if /i "%NUM%" == "" (
	set DUMPSTATE=1
	set REMOVE_LOG=1
	goto START_PULLING
)
if /i "%NUM%" == "1" (
	set DUMPSTATE=1
	set REMOVE_LOG=1
	goto START_PULLING
)
if /i "%NUM%" == "2" (
	set DUMPSTATE=1
	set REMOVE_LOG=0
	goto START_PULLING
)
if /i "%NUM%" == "3" (
	set DUMPSTATE=0
	set REMOVE_LOG=1
	goto START_PULLING
)
if /i "%NUM%" == "4" (
	set DUMPSTATE=0
	set REMOVE_LOG=0
	goto START_PULLING
)

if /i "%NUM%" == "6" goto HELP
if /i "%NUM%" == "7" goto EXIT
if /i "%NUM%" == "5" (
	adb.exe wait-for-device root
	goto DELETE_LOG
)
goto EXIT

:START_PULLING
:: set root (it needs for user mode image)
adb.exe wait-for-device root

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

ECHO [ Refer the following url about android log infomation > %DIR_NAME%/%INFO_FILE_NAME% ]
ECHO   ==^> * How to get log : http://collab.lge.com/main/pages/viewpage.action?pageId=98239497  >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO   ==^> * Android log system : http://collab.lge.com/main/display/MCLAP/Android+Log+System  >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO   ==^> * Android log file anlaysis : http://collab.lge.com/main/pages/viewpage.action?pageId=101211784  >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO   ==^> * dumpreport anlaysis : http://collab.lge.com/main/pages/viewpage.action?pageId=132054931  >> %DIR_NAME%/%INFO_FILE_NAME%
ECHO   ==^> * ANR debugging : http://collab.lge.com/main/pages/viewpage.action?pageId=142907866, http://collab.lge.com/main/pages/viewpage.action?pageId=142910677  >> %DIR_NAME%/%INFO_FILE_NAME%

ECHO. >> %DIR_NAME%/%INFO_FILE_NAME%

ECHO [ Device Date ^& TIME at pulling logs] >> %DIR_NAME%/%INFO_FILE_NAME%
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

echo -------------------------------------------
echo ^>^> extract log files to %DIR_NAME% ^<^<
echo -------------------------------------------
:: Android Log
ECHO ^> Retrieving Android Log files(/data/logger, /data/log)...
adb.exe pull /data/logger/ %DIR_NAME%/logger 2> null
adb.exe pull /mnt/sdcard/log/ %DIR_NAME%/smartlog 2> null
adb.exe pull /proc/last_kmsg %DIR_NAME%/logger/last_kmsg.log

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
adb.exe pull /data/system/ckerror/ %DIR_NAME%/ckerror 2> null

:: MLT
::ECHO ^> Retrieving mlt db files(/mpt/)..
::adb.exe pull /mpt %DIR_NAME%/mlt 2> null

:: Art Tool Report Log : Report*.xml, CrashedReport20120701_233950.rpt
ECHO ^> Retrieving art report files(/data/data/com.lge.artui/files/Report/)..
adb.exe pull /data/data/com.lge.artui/files/Report/ %DIR_NAME%/art 2> null

:: Multimedia database
ECHO ^> Retrieving MediaDB files(/data/data/com.android.providers.media/databases/)..
adb pull /data/data/com.android.providers.media/databases/ %DIR_NAME%/MediaDB 2> null

:: Modem Log
ECHO ^> Retrieving modem event logs(/sdcard/modem_loggers)..
adb.exe pull /sdcard/modem_loggers %DIR_NAME%/modem_moca 2> null

::for MTK chipset 
adb.exe pull /sdcard/mtklog %DIR_NAME%/mtklog/ 2> null
::adb.exe pull /data/rtt_dump* %DIR_NAME%/mtklog/sf_rtt
::adb.exe pull /data/aee_exp %DIR_NAME%/mtklog/data_aee_exp

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


::adb shell dumpsys dropbox SYSTEM_BOOT --print > %DIR_NAME%\dropbox\system_BOOT.txt
::adb shell dumpsys dropbox SYSTEM_RESTART --print > %DIR_NAME%\dropbox\system_RESTART.txt
::adb shell dumpsys dropbox SYSTEM_LAST_KMSG --print > %DIR_NAME%\dropbox\system_LAST_KMSG.txt
::adb shell dumpsys dropbox SYSTEM_RECOVERY_LOG --print > %DIR_NAME%\dropbox\SYSTEM_RECOVERY_LOG.txt
::adb shell dumpsys dropbox APANIC_CONSOLE --print > %DIR_NAME%\dropbox\APANIC_CONSOLE.txt
::adb shell dumpsys dropbox APANIC_THREADS --print > %DIR_NAME%\dropbox\APANIC_THREADS.txt
::adb shell dumpsys dropbox system_app_strictmode --print > %DIR_NAME%\dropbox\strictmode.txt
::adb shell dumpsys dropbox data_app_strictmode --print >> %DIR_NAME%\dropbox\strictmode.txt

adb shell dumpsys dropbox SYSTEM_TOMBSTONE --print > %DIR_NAME%\dropbox\SYSTEM_TOMBSTONE.txt

adb shell dumpsys dropbox system_server_anr --print > %DIR_NAME%\dropbox\ANR.txt
adb shell dumpsys dropbox system_app_anr --print >> %DIR_NAME%\dropbox\ANR.txt
adb shell dumpsys dropbox data_app_anr --print >> %DIR_NAME%\dropbox\ANR.txt

adb shell dumpsys dropbox system_server_crash --print > %DIR_NAME%\dropbox\CRASH.txt
adb shell dumpsys dropbox system_app_crash --print >>  %DIR_NAME%\dropbox\CRASH.txt
adb shell dumpsys dropbox data_app_crash --print >> %DIR_NAME%\dropbox\CRASH.txt

::adb shell dumpsys dropbox system_server_wtf --print > %DIR_NAME%\dropbox\WTF.txt
::adb shell dumpsys dropbox system_app_wtf --print >> %DIR_NAME%\dropbox\WTF.txt
::adb shell dumpsys dropbox data_app_wtf --print >> %DIR_NAME%\dropbox\WTF.txt
::adb shell dumpsys dropbox BATTERY_DISCHARGE_INFO --print > %DIR_NAME%\dropbox\BATTERY_DISCHARGE_INFO.txt

adb shell dumpsys dropbox --file > %DIR_NAME%\dropbox\dropbox_files.txt

:: Hprof_dump => ex : JNI 2000 overflow
ECHO ^> Retrieving hprof_dump (/data/hprof_dump)..
adb.exe pull /data/hprof_dump_1701.hprof %DIR_NAME% 2> null
adb.exe pull /data/hprof_dump_1801.hprof %DIR_NAME% 2> null
adb.exe pull /data/hprof_dump_1901.hprof %DIR_NAME% 2> null
adb.exe pull /data/hprof_dump_final.hprof %DIR_NAME% 2> null

::recovery
ECHO ^> Retrieving recovery Logs(/cache/recovery/)...
adb.exe pull /cache/recovery/ %DIR_NAME%/recovery 2> null

:: dump file (Vol up + down + power key Long Click)
ECHO ^> Retrieving dump files(/data/dump)..
adb.exe pull /data/dump %DIR_NAME%/dump 2> null

:: DUMPREPORT
if /i "%DUMPSTATE%" == "1" (
	ECHO ^> Capturing bugreport[adb shell bugreport]
	ECHO     =^>.. It takes 1~2 minutes
	adb bugreport > %DIR_NAME%/last_bugreport.txt
)

set PRINT_DIRECTORY=1
::echo REMOVE_LOG = %REMOVE_LOG%
if /i "%REMOVE_LOG%" == "1" goto DELETE_LOG

goto QUIT

:: ========= DELETE_LOG ===========
:DELETE_LOG
ECHO --------------------------------------------------------------
echo ^>^> Deleting log files ^<^<
ECHO --------------------------------------------------------------
::ECHO ^> Deleting /data/logger/ ...
adb.exe shell rm -rf /data/logger/* 2> null
::ECHO ^> Deleting /mnt/sdcard/log/ ...
adb.exe shell rm -rf /mnt/sdcard/log/* 2> null
::ECHO ^> Deleting /data/anr/ ...
adb.exe shell rm -rf /data/anr/* 2> null
::ECHO ^> Deleting /data/dontpanic/ ...
adb.exe shell rm -rf /data/dontpanic/* 2> null
::ECHO ^> Deleting /data/system/dropbox/ ...
adb.exe shell rm -rf /data/system/dropbox/* 2> null
::ECHO ^> Deleting /data/system/ckerror/ ...
adb.exe shell rm -rf /data/system/ckerror/* 2> null
::ECHO ^> Deleting /data/tombstones/ ...
adb.exe shell rm -rf /data/tombstones/* 2> null
::ECHO ^> Deleting /sdcard/modem_loggers ...
adb.exe shell rm -rf /sdcard/modem_loggers/* 2> null
::ECHO ^> Deleting data/hprof files...
adb.exe shell rm -rf /data/hprof_dump_1701.hprof 2> null
adb.exe shell rm -rf /data/hprof_dump_1801.hprof 2> null
adb.exe shell rm -rf /data/hprof_dump_1901.hprof 2> null
adb.exe shell rm -rf /data/hprof_dump_final.hprof 2> null
adb.exe shell rm -rf /data/data/com.lge.artui/files/Report/*  2> null
adb.exe shell rm -rf /data/data/com.lge.artui/files/Report/*  2> null

ECHO ^>^> All Logs are deleted ^<^<
ECHO --------------------------------------------------------------

:: Restart log service (stop & start)
:STOP_LOG
echo ^>^> Stop Log Service ^<^<
adb.exe shell setprop persist.service.main.enable 0 2> null
adb.exe shell setprop persist.service.system.enable 0 2> null
adb.exe shell setprop persist.service.radio.enable 0 2> null
adb.exe shell setprop persist.service.events.enable 0 2> null
adb.exe shell setprop persist.service.kernel.enable 0 2> null
::adb.exe shell setprop ctl.stop clear-kernel-log 2> null

echo ^>^> Start Log Service ^<^<
adb.exe shell setprop persist.service.main.enable 1 2> null
adb.exe shell setprop persist.service.system.enable 1 2> null
adb.exe shell setprop persist.service.radio.enable 1 2> null
adb.exe shell setprop persist.service.events.enable 1 2> null
adb.exe shell setprop persist.service.kernel.enable 1 2> null
::adb.exe shell setprop ctl.start clear-kernel-log 2> null
goto CHECK_LOG_SERVICE

:CHECK_LOG_SERVICE
::echo ^>^> Checking Log Service ^<^<
::echo Main Log Service 확인중..
::adb.exe shell getprop persist.service.main.enable 2>null
::echo System Log Service 확인중..
::adb.exe shell getprop persist.service.system.enable 2>null
::echo Radio Log Service 확인중..
::adb.exe shell getprop persist.service.radio.enable 2>null
::echo Event Log Service 확인중..
::adb.exe shell getprop persist.service.events.enable 2>null
::echo Kernel Log Service 확인중..
::adb.exe shell getprop persist.service.kernel.enable 2>null

goto QUIT

:: ========= HELP ===========
:HELP
@echo off
echo Pull log files using ADB
echo.
echo Usage : %0 [directory_name] 
echo.
echo   directory_name    Directory name where to save log.
echo.
echo Please reference the wiki page : http://collab.lge.com/main/pages/viewpage.action?pageId=98239497
echo.

goto QUIT

:QUIT
if /i "%PRINT_DIRECTORY%"=="1" (
	ECHO --------------------------------------------------------------
	ECHO ^>^> All Logs are saved into Dir : %cd%\%DIR_NAME%
	ECHO ^>^> Pull logging completed sucessfully!!!
	ECHO --------------------------------------------------------------
)

:EXIT
COLOR
echo.
pause

