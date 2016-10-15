@echo off
setlocal

rem Check Administrator Permission
net session > nul 2>&1
if errorlevel 1 set ERR_MSG=Permission denied. & goto ERROR

rem Change Current Directory
cd /d %~dp0

rem Install MacType-Patch
if "%PROCESSOR_ARCHITECTURE%" EQU "x86" (
  call :swap "%SystemRoot%\System32" EasyHK32.dll Easyhk32.dll .bak SYSTEM
  call :swap "%ProgramFiles%\MacType" EasyHK32.dll EasyHK32.dll .bak SYSTEM
) else (
  call :swap "%SystemRoot%\System32" EasyHK64.dll Easyhk64.dll .bak SYSTEM
  call :swap "%SystemRoot%\SysWOW64" EasyHK32.dll Easyhk32.dll .bak SYSTEM
  call :swap "%ProgramFiles%\MacType" EasyHK64.dll EasyHK64.dll .bak SYSTEM
  call :swap "%ProgramFiles%\MacType" EasyHK32.dll EasyHK32.dll .bak SYSTEM
)
copy UserParams.ini "%ProgramFiles%\MacType\"
icacls "%ProgramFiles%\MacType\UserParams.ini" /setowner SYSTEM

:ERROR
if defined ERR_MSG echo %ERR_MSG%

endlocal
pause
exit %errorlevel%


rem ---------------------------------------------
rem Sub Routine
rem ---------------------------------------------

rem Swap file
rem   swap dir source target prefix user
:swap
  if not exist "%~1" set ERR_MSG=%~1 not found. & goto ERROR
  if not exist "%~2" set ERR_MSG=%~2 not found. & goto ERROR
  if not exist "%~3" set ERR_MSG=%~3 not found. & goto ERROR
  ren "%~1\%~3" %~3%~4 && copy %~2 "%~1\" && icacls "%~1\%~2" /setowner %~5
  if errorlevel 1 set ERR_MSG=swap "%~2" to "%~1\%~3" failed. & goto ERROR
exit /b 0
