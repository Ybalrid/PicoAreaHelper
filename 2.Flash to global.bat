@echo off

:Retry
cls
echo ===================================================
echo PICO Area Switch Assistant
echo Version: 1.0.2
echo By£ºÈçÃÎNya & Cyberbug
set adb=%~dp0\ADB\adb.exe
%adb% devices -l | findstr "PICO">nul && (goto Success)
echo ===================================================
echo Can't find the PICO device, please check whether the data cable is connected normally, and whether the device has USB debugging turned on!
pause
cls
goto Retry

:Success
echo ===================================================
echo prepare to switch device region to: global
echo Please make sure not to unplug the data cable during the process
echo After the setting is completed, the device will automatically restart, please pay attention
echo ===================================================
pause
echo Change device region...
REM the line below this needs to be changed to something else then HK or CN but not exactly sure EU EN US or UK for engish (user_settings_initialized is not well documented)
%adb% shell settings put global user_settings_initialized FR
echo Success
echo clear app cache 1/3...
%adb% shell pm clear com.picovr.store
echo clear app cache 2/3...
%adb% shell pm clear com.picovr.vrusercenter
echo clear app cache 3/3...
%adb% shell pm clear com.bytedance.pico.matrix
echo Install required apps...
for %%i in (%~dp0\Apks\Global\*.apk) do (
 	ECHO Installing %%i
 	%adb% install -r -d "%%i"
)
echo Rebooting device...
%adb% reboot
echo Finished.
echo ===================================================
pause
