@echo off
mode con cols=122 lines=40
chcp 65001
cls

REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

echo Windows Cleaner Utility Launcher by Chainski Tools
goto int

:int
echo Loading configuration, please wait ...
cls
set VER=1.0.0
set dir=%temp%

set github-link=https://github.com/Chainski/WindowsCleanerUtility
set license=GNU GENERAL PUBLIC LICENSE (version 3)
set license-file=LICENSE.txt
timeout 1 /nul
goto menu

:menu
cls
																									     
echo   [40;31m ╔╗╔╗╔╗╔══╗╔═╗ ╔╗╔═══╗╔═══╗╔╗╔╗╔╗╔═══╗ [40;34m  ╔═══╗╔╗   ╔═══╗╔═══╗╔═╗ ╔╗╔═══╗╔═══╗  [40;31m  ╔╗ ╔╗╔════╗╔══╗╔╗   ╔══╗╔════╗╔╗  ╔╗
echo   [40;31m ║║║║║║╚╣╠╝║║╚╗║║╚╗╔╗║║╔═╗║║║║║║║║╔═╗║ [40;34m  ║╔═╗║║║   ║╔══╝║╔═╗║║║╚╗║║║╔══╝║╔═╗║  [40;31m  ║║ ║║║╔╗╔╗║╚╣╠╝║║   ╚╣╠╝║╔╗╔╗║║╚╗╔╝║
echo   [40;31m ║║║║║║ ║║ ║╔╗╚╝║ ║║║║║║ ║║║║║║║║║╚══╗ [40;34m  ║║ ╚╝║║   ║╚══╗║║ ║║║╔╗╚╝║║╚══╗║╚═╝║  [40;31m  ║║ ║║╚╝║║╚╝ ║║ ║║    ║║ ╚╝║║╚╝╚╗╚╝╔╝
echo   [40;31m ║╚╝╚╝║ ║║ ║║╚╗║║ ║║║║║║ ║║║╚╝╚╝║╚══╗║ [40;34m  ║║ ╔╗║║ ╔╗║╔══╝║╚═╝║║║╚╗║║║╔══╝║╔╗╔╝  [40;31m  ║║ ║║  ║║   ║║ ║║ ╔╗ ║║   ║║   ╚╗╔╝ 
echo   [40;31m ╚╗╔╗╔╝╔╣╠╗║║ ║║║╔╝╚╝║║╚═╝║╚╗╔╗╔╝║╚═╝║ [40;34m  ║╚═╝║║╚═╝║║╚══╗║╔═╗║║║ ║║║║╚══╗║║║╚╗  [40;31m  ║╚═╝║ ╔╝╚╗ ╔╣╠╗║╚═╝║╔╣╠╗ ╔╝╚╗   ║║  
echo   [40;31m  ╚╝╚╝ ╚══╝╚╝ ╚═╝╚═══╝╚═══╝ ╚╝╚╝ ╚═══╝ [40;34m  ╚═══╝╚═══╝╚═══╝╚╝ ╚╝╚╝ ╚═╝╚═══╝╚╝╚═╝  [40;31m  ╚═══╝ ╚══╝ ╚══╝╚═══╝╚══╝ ╚══╝   ╚╝  
echo.
echo.
echo                                          [40;33m ╔════════════════════════════════╗
echo                                          [40;33m ║    Windows Cleaner Utility     ║                                              
echo                                          [40;33m ║    coded by Chainski Tools     ║                
echo                                          [40;33m ╚════════════════════════════════╝    

title Windows Cleaner Utility %ver% by Chainski Tools 
echo.
echo [40;32m Press a button from 1 to 5 - each of these buttons has its own function as described below:
echo.
echo  1 - Delete the Temporary Files
echo.
echo  2 - Scan System And Repair Windows Image
echo.
echo  3 - Program and license information
echo.
echo  4 - Page on GitHub
echo.
echo  5 - End session (will close the program)
choice /c 12345 /n
if %errorlevel%==1 goto clear-init
if %errorlevel%==2 goto Repair
if %errorlevel%==3 goto info
if %errorlevel%==4 goto github
if %errorlevel%==5 goto End


:END
cls
exit

:Repair
cls
sfc /scannow
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
cls
echo Windows Repaired Successfully!
echo --------------------------------------------------
echo Press ENTER KEY yo Continue.
echo --------------------------------------------------
pause >nul
goto menu

:clear-init
cls
echo Checking Temporary Files...
cd %temp%
if exist * goto clear-warning
if not exist * goto good-to-go

:clear-warning
cls
echo.
echo Your PC needs deep cleaning! Select an option below to continue.
echo.
echo Press 1 to clear data and reclaim disk space. (This process make several minutes please be patient)
echo Press 2 to stop the current operations and exit the program.
choice /c 12 /n
if %errorlevel%==1 goto clear
if %errorlevel%==2 exit

:clear
rem Delete Temporary Files

RMDIR "%tmp%" /S /Q >nul 2>nul
del /s /f /q %temp%\*.* >nul 2>nul
cleanmgr.exe /autoclean :: Used to delete old files left after upgrading a Windows build
del /s /f /q %windir%\temp\*.* >nul 2>nul
cls

echo [Cleaning] and Optimizations in progress...
timeout /t 2 /nobreak >nul
echo.

echo [Cleaning] Temporary Files && color c
timeout /t 2 /nobreak >nul
echo.

del /s /f /q %windir%\temp\*.* >nul 2>nul
del /s /f /q %windir%\Prefetch\*.* >nul 2>nul
del /s /f /q %LOCALAPPDATA%\Microsoft\Windows\Caches\*.* >nul 2>nul
del /s /f /q %windir%\SoftwareDistribution\Download\*.* >nul 2>nul
del /s /f /q %programdata%\Microsoft\Windows\WER\Temp\*.* >nul 2>nul
del /s /f /q %HomePath%\AppData\LocalLow\Temp\*.* >nul 2>nul
rd /s /f /q %windir%\history 2>nul >nul
rd /s /f /q %windir%\cookies 2>nul >nul


echo [Cleaning] Log Files && color b 
timeout /t 2 /nobreak >nul
echo.

REM Delete Log Files
del /s /f /q %windir%\Logs\CBS\CbsPersist*.log >nul 2>nul
del /s /f /q %windir%\Logs\MoSetup\*.log >nul 2>nul
del /s /f /q %windir%\Panther\*.log >nul 2>nul
del /s /f /q %windir%\logs\*.log >nul 2>nul
del /s /f /q %localappdata%\Microsoft\Windows\WebCache\*.log >nul 2>nul
rd /s /f /q %localappdata%\Microsoft\Windows\INetCache\*.log >nul 2>nul


echo [Cleaning] Remnant Driver Files && color 9
timeout /t 2 /nobreak >nul
echo.

rem Delete Remnant Driver Files (Not needed because already installed)
del /s /f /q %SYSTEMDRIVE%\AMD\*.* >nul 2>nul
del /s /f /q %SYSTEMDRIVE%\NVIDIA\*.* >nul 2>nul
del /s /f /q %SYSTEMDRIVE%\INTEL\*.* >nul 2>nul


echo [Cleaning] Windows Defender Cache/Logs && color 3
timeout /t 2 /nobreak >nul
echo.

del "%ProgramData%\Microsoft\Windows Defender\Network Inspection System\Support\*.log" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\CacheManager" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\ReportLatency\Latency" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\Service\*.log" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Scans\MetaStore" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Support" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\Results\Quick" /F /Q /S >nul 2>nul
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\Results\Resource" /F /Q /S >nul 2>nul

echo [Cleaning] DNS Resolver Cache && color 2
timeout /t 2 /nobreak >nul
echo.

REM Clean DNS Resolver Cache (Restart May Be Required)
ipconfig /release >nul 2>nul
ipconfig /renew >nul 2>nul
ipconfig /flushdns >nul 2>nul
netsh int ip reset >nul 2>nul
netsh winsock reset >nul 2>nul
netsh interface ipv4 reset >nul 2>nul
netsh interface ipv6 reset >nul 2>nul

echo [Enabling] Ultimate Performance Mode && color b 
timeout /t 2 /nobreak >nul
echo.

echo Successfully Enabled Ultimate Performance Mode ! && color c
timeout /t 2 /nobreak >nul
echo.

::Enables Ultimate Performance
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 95533644-e700-4a79-a56c-a89e8cb109d9 >nul 2>nul
powercfg -setactive 95533644-e700-4a79-a56c-a89e8cb109d9 >nul 2>nul

:clear-error
echo Unfortunately, we were unable to remove all of the Temporary files (some are being used by other processes).
echo You can manually open the Temporary Folders and try to delete the remaining files.
echo.
echo Press 1 to try again.
echo Press 2 to return to the menu.
choice /c 12 /n
if %errorlevel%==1 goto clear
if %errorlevel%==2 goto menu

if exist * goto clear-error
if not exist * goto clear-complete

:clear-complete
cls
echo Ready! Your computer has been cleared of unnecessary temporary data!
pause
goto menu

:good-to-go
cls
echo Your PC doesn't need cleaning. Your PC is good to go!
pause
goto menu

:info
cls
echo Windows Cleaner Utility
echo %ver% by Chainski
echo.
echo Source code avaible on GitHub: %github-link%
echo Working under license: %license%
echo.
pause /nul
goto menu

:github
cls
start %github-link%
goto menu
