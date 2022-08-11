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
	
echo [%date% %time%] Windows Cleaner Utility Launcher by Chainski Tools >> WindowsCleanerUtility-Log.txt
echo [%date% %time%] Launching  Windows Cleaner Utility... >> WindowsCleanerUtility-Log.txt
echo Windows Cleaner Utility Launcher by Chainski Tools
goto int

:int
echo Loading configuration, please wait ...
cls
echo [%date% %time%] Loading configuration... >> WindowsCleanerUtility-Log.txt
set VER=1.0.0
echo [%date% %time%] Value Loaded: VER = %ver% >> WindowsCleanerUtility-Log.txt
set dir=%temp%

set github-link=https://github.com/Chainski/WindowsCleanerUtility
echo [%date% %time%] Value Loaded: github-link = %github-link% >> WindowsCleanerUtility-Log.txt
set license=GNU GENERAL PUBLIC LICENSE (version 3)
echo [%date% %time%] Value Loaded: license = %license% >> WindowsCleanerUtility-Log.txt
set license-file=LICENSE.txt
echo [%date% %time%] Value Loaded: license-file = %license-file% >> WindowsCleanerUtility-Log.txt
echo [%date% %time%] Windows Cleaner Utility Version Loaded: %ver% >> WindowsCleanerUtility-Log.txt
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

echo [%date% %time%] Windows Cleaner Utility succesfully launched >> WindowsCleanerUtility-Log.txt
title Windows Cleaner Utility %ver% by Chainski Tools 
echo.
echo [40;32m Press a button from 1 to 4 - each of these buttons has its own function as described below:
echo.
echo  1 - Delete the Temporary Files
echo.
echo  2 - Program and license information
echo  3 - Page on GitHub
echo.
echo  4 - End session (will close the program)
choice /c 1234 /n
if %errorlevel%==1 goto clear-init
if %errorlevel%==2 goto info
if %errorlevel%==3 goto github
if %errorlevel%==4 goto End

:END
cls
echo [%date% %time%] Session Ended >> WindowsCleanerUtility-Log.txt
exit

:clear-init
echo [%date% %time%] Preparing... >> WindowsCleanerUtility-Log.txt
cls
echo Checking Temporary Files...
cd %temp%
if exist * goto clear-warning
if not exist * goto good-to-go

:clear-warning
echo [%date% %time%] PC needs deep cleaning >> WindowsCleanerUtility-Log.txt
cls
echo.
echo Your PC needs deep cleaning! Check the list above and select the appropriate action.
echo Press 1 to clear data and reclaim disk space.
echo Press 2 to stop the current operations and exit the program.
choice /c 12 /n
if %errorlevel%==1 goto clear
if %errorlevel%==2 exit

:clear

rem Delete Temporary Files
echo [%date% %time%] Cleaning... >> WindowsCleanerUtility-Log.txt
cleanmgr.exe /autoclean :: Used to delete old files left after upgrading a Windows build
del /s /f /q %windir%\temp\*.*
del /s /f /q %temp%\*.*
del /s /f /q %windir%\Prefetch\*.*
del /s /f /q %LOCALAPPDATA%\Microsoft\Windows\Caches\*.*
del /s /f /q %windir%\SoftwareDistribution\Download\*.*
del /s /f /q %programdata%\Microsoft\Windows\WER\Temp\*.*
del /s /f /q %HomePath%\AppData\LocalLow\Temp\*.*
rd /s /f /q %windir%\history 2>nul >nul
rd /s /f /q %windir%\cookies 2>nul >nul
cls

REM Delete Log Files
del /s /f /q %windir%\Logs\CBS\CbsPersist*.log
del /s /f /q %windir%\Logs\MoSetup\*.log
del /s /f /q %windir%\Panther\*.log 
del /s /f /q %windir%\logs\*.log
del /s /f /q %localappdata%\Microsoft\Windows\WebCache\*.log 
rd /s /f /q %localappdata%\Microsoft\Windows\INetCache\*.log 
cls

rem Delete Remnant Drivers Files (Not needed because already installed)
del /s /f /q %SYSTEMDRIVE%\AMD\*.*
del /s /f /q %SYSTEMDRIVE%\NVIDIA\*.*
del /s /f /q %SYSTEMDRIVE%\INTEL\*.*
cls

REM Delete Browser Cache 
del /s /f /q "%USERPROFILE%\AppData\Local\Microsoft\Edge\User Data\Default\Cache" 

REM Clean DNS Resolver Cache (Restart May Be Required)
ipconfig /flushdns
cls
netsh winsock reset all
cls

:clear-error
echo Unfortunately, we were unable to remove all of the Temporary files (some are being used by other processes).
echo You can manually open the Temporary Folders and try to delete the remaining files.
echo.
echo Press 1 to try again.
echo Press 2 to return to the menu.
choice /c 12 /n
if %errorlevel%==1 goto clear
if %errorlevel%==2 goto menu

echo Reclaiming disk space, please wait (this process may take some time) ...
if exist * goto clear-error
if not exist * goto clear-complete

:clear-complete
echo [%date% %time%] Requested operations completed. >> WindowsCleanerUtility-Log.txt
cls
echo Ready! Your computer has been cleared of unnecessary temporary data!
pause
goto menu

:good-to-go
echo [%date% %time%] Requested operations completed. >> WindowsCleanerUtility-Log.txt
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