@ echo off
if not exist .\KLUpdater\Updater.exe goto v
if not exist .\KLUpdater\ss_storage.ini goto v
if not exist .\tools\7z.exe goto x
if not exist rescue.iso goto y
if exist .\kavrescue rmdir /s .\kavrescue /q
if exist .\rescueusb.iso del .\rescueusb.iso
ECHO Kaspersky Rescue Disk Updater by Bharat Balegere
echo               AgniPulse.Com
echo http://agnipulse.com/2009/12/kaspersky-rescue-disk-updater/
echo https://github.com/bbalegere/Kaspersky-Rescue-Disk-Updater
echo.
echo.
echo.
Echo Extracting the contents of Kaspersky Rescue Disk
Title Extracting Kaspersky Rescue Disk
.\tools\7z x -o"kavrescue" -bsp2 -y "rescue.iso" "rescue" > nul
if errorlevel 1 goto :ERR
echo Kaspersky Files Extracted in %~dp0kavrescue
echo.
echo.
Echo Next Step:Copying Virus Definition Files from your Rescue Disk to a Temporary Location


Echo Copying Virus Definition Files from your Rescue Disk to a Temporary Location
title Copying Virus Definition Files from your Rescue Disk to a Temporary Location
if not exist .\kavrescue\rescue\bases goto u
if not exist .\KLUpdater\Temp\temporaryFolder\bases\av\kdb\i386 md .\KLUpdater\Temp\temporaryFolder\bases\av\kdb\i386
echo n|copy .\kavrescue\rescue\bases\*.* .\KLUpdater\Temp\temporaryFolder\bases\av\kdb\i386\ /-y > nul
echo Successfully Copied Definition Files to a Temporary Location
echo.
echo.
Echo Next Step:Updating Virus Definition Files from Kaspersky Server

Echo Updating Virus Definition Files from Kaspersky Server
title Updating Virus Definition Files from Kaspersky Server
pushd KLUpdater
Updater.exe -u -c -rpt report.txt 
popd

echo.
echo.
Echo Next Step:Copying the Updated Virus Definition Files back to %~dp0kavrescue
cls
Echo Copying the Updated Virus Definition Files back to %~dp0kavrescue
title Copying the Updated Virus Definition Files back to %~dp0kavrescue
copy .\KLUpdater\Updates\bases\av\kdb\i386\*.* .\kavrescue\rescue\bases\ > nul
copy .\KLUpdater\Updates\bases\av\emu\i386\*.* .\kavrescue\rescue\bases\ > nul
copy .\KLUpdater\Updates\bases\av\kdb\i386\kdb-i386-0607g.xml .\kavrescue\rescue\bases\kdb-0607g.xml > nul
copy /y .\KLUpdater\Updates\bases\av\kdb\i386\old\kdb.stt .\kavrescue\rescue\bases\stat\kdb.stt > nul
copy .\KLUpdater\Updates\index\u0607g.xml .\kavrescue\rescue\bases\data\u0607g.xml > nul
for /f "tokens=1,2,3,4,5,6 usebackq delims=.:-/ " %%a in ('%date% %time%') do echo bases id:%%c%%b%%a%%d%%e > .\kavrescue\rescue\BASES.ID
echo Successfully Copied Updated Definition Files back to %~dp0kavrescue
echo.
echo.
echo.
echo.
echo NO ERRORS - new update IS DOWNLOADED to %~dp0kavrescue!
echo Removing extracted files and temp files.
rem rmdir /s .\kavrescue /q
rmdir /s .\KLUpdater\Temp /q
goto end

:ERR
echo ERROR! Some problem occurred!
pause
goto end

:u
echo !! The Kaspersky Rescue Disk is not a valid Disk. !!
echo It does not contain the bases folder.
echo http://rescuedisk.kaspersky-labs.com/rescuedisk/updatable/kav_rescue_10.iso
echo and rename it to rescue.iso
pause
goto end
:v
echo Missing file(s) %~dp0KLUpdater\Updater.exe, %~dp0KLUpdater\ss_storage.ini
goto end
:x
echo Missing file(s)  %~dp0Tools\7z.exe
goto end
:y
echo !! Kaspersky Rescue Disk Not Found !!.
echo Missing File %~dp0rescue.iso
echo Please download Rescue Disk from:
echo http://rescuedisk.kaspersky-labs.com/rescuedisk/updatable/kav_rescue_10.iso
echo and rename it to rescue.iso
goto end
:end
pause
goto :EOF





