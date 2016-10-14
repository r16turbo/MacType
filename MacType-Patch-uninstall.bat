@echo off
setlocal

rem Check Administrator Permission
net session > nul 2>&1
if errorlevel 1 set ERR_MSG=Permission denied. & goto ERROR

rem Uninstall MacType-Patch
if "%PROCESSOR_ARCHITECTURE%" EQU "x86" (
  del "%SystemRoot%\System32\EasyHK32.dll"
  ren "%SystemRoot%\System32\Easyhk32.dll.bak" Easyhk32.dll

  del "%ProgramFiles%\MacType\EasyHK32.dll"
  ren "%ProgramFiles%\MacType\EasyHK32.dll.bak" EasyHK32.dll
) else (
  del "%SystemRoot%\System32\EasyHK64.dll"
  del "%SystemRoot%\SysWOW64\EasyHK32.dll"
  ren "%SystemRoot%\System32\Easyhk64.dll.bak" Easyhk64.dll
  ren "%SystemRoot%\SysWOW64\Easyhk32.dll.bak" Easyhk32.dll

  del "%ProgramFiles%\MacType\EasyHK64.dll"
  del "%ProgramFiles%\MacType\EasyHK32.dll"
  ren "%ProgramFiles%\MacType\EasyHK64.dll.bak" EasyHK64.dll
  ren "%ProgramFiles%\MacType\EasyHK32.dll.bak" EasyHK32.dll
)

:ERROR
if defined ERR_MSG echo %ERR_MSG%

endlocal
pause
exit /b 0
