@echo off
setlocal

rem Check Administrator Permission
net session > nul 2>&1
if errorlevel 1 set ERR_MSG=Permission denied. & goto ERROR

rem Uninstall MacType-Patch
if "%PROCESSOR_ARCHITECTURE%" EQU "x86" (
  call :revert "%SystemRoot%\System32" Easyhk32.dll .bak
  call :revert "%ProgramFiles%\MacType" EasyHK32.dll .bak
) else (
  call :revert "%SystemRoot%\System32" Easyhk64.dll .bak
  call :revert "%SystemRoot%\SysWOW64" Easyhk32.dll .bak
  call :revert "%ProgramFiles%\MacType" EasyHK64.dll .bak
  call :revert "%ProgramFiles%\MacType" EasyHK32.dll .bak
)
del "%ProgramFiles%\MacType\UserParams.ini"

:ERROR
if defined ERR_MSG echo %ERR_MSG%

endlocal
pause
exit %errorlevel%


rem ---------------------------------------------
rem Sub Routine
rem ---------------------------------------------

rem Revert file
rem   revert dir target prefix
:revert
  if not exist "%~1" set ERR_MSG=%~1 not found. & goto ERROR
  if not exist "%~2" set ERR_MSG=%~2 not found. & goto ERROR
  del "%~1\%~2" && ren "%~1\%~2%~3" %~2
  if errorlevel 1 set ERR_MSG=revert "%~1\%~2" failed. & goto ERROR
exit /b 0
