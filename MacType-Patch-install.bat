@echo off
setlocal

rem Check Administrator Permission
net session > nul 2>&1
if errorlevel 1 set ERR_MSG=Permission denied. & goto ERROR

rem Change Current Directory
cd /d %~dp0

rem Install MacType-Patch
if "%PROCESSOR_ARCHITECTURE%" EQU "x86" (
  ren "%SystemRoot%\System32\Easyhk32.dll" Easyhk32.dll.bak
  copy EasyHK32.dll "%SystemRoot%\System32\"
  icacls "%SystemRoot%\System32\EasyHK32.dll" /setowner SYSTEM
  ren "%ProgramFiles%\MacType\EasyHK32.dll" EasyHK32.dll.bak

  ren "%ProgramFiles%\MacType\EasyHK32.dll" EasyHK32.dll.bak
  copy EasyHK32.dll "%ProgramFiles%\MacType\"
  icacls "%ProgramFiles%\MacType\EasyHK32.dll" /setowner SYSTEM
) else (
  ren "%SystemRoot%\System32\Easyhk64.dll" Easyhk64.dll.bak
  ren "%SystemRoot%\SysWOW64\Easyhk32.dll" Easyhk32.dll.bak
  copy EasyHK64.dll "%SystemRoot%\System32\"
  copy EasyHK32.dll "%SystemRoot%\SysWOW64\"
  icacls "%SystemRoot%\System32\EasyHK64.dll" /setowner SYSTEM
  icacls "%SystemRoot%\SysWOW64\EasyHK32.dll" /setowner SYSTEM

  ren "%ProgramFiles%\MacType\EasyHK64.dll" EasyHK64.dll.bak
  ren "%ProgramFiles%\MacType\EasyHK32.dll" EasyHK32.dll.bak
  copy EasyHK64.dll "%ProgramFiles%\MacType\"
  copy EasyHK32.dll "%ProgramFiles%\MacType\"
  icacls "%ProgramFiles%\MacType\EasyHK64.dll" /setowner SYSTEM
  icacls "%ProgramFiles%\MacType\EasyHK32.dll" /setowner SYSTEM
)

:ERROR
if defined ERR_MSG echo %ERR_MSG%

endlocal
pause
exit /b 0
