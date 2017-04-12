@echo off
setlocal

rem Check Administrator Permission
net session > nul 2>&1
if errorlevel 1 set ERR_MSG=Permission denied. & goto ERROR

rem Change Current Directory
cd /d %~dp0

rem Install MacType-Patch
if "%PROCESSOR_ARCHITECTURE%" EQU "x86" (
  call :swap "%ProgramFiles%\MacType" EasyHK32.dll .bak
) else (
  call :swap "%ProgramFiles%\MacType" EasyHK64.dll .bak
  call :swap "%ProgramFiles%\MacType" EasyHK32.dll .bak
)
copy UserParams.ini "%ProgramFiles%\MacType\"

rem (re)set Owner and ACL
icacls "%ProgramFiles%\MacType\*" /setowner SYSTEM /T
icacls "%ProgramFiles%\MacType\*" /reset /T

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
  ren "%~1\%~2" %~2%~4 && copy %~2 "%~1\"
  if errorlevel 1 set ERR_MSG=swap "%~2" to "%~1\%~2" failed. & goto ERROR
exit /b 0
