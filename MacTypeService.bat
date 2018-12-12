@echo off
setlocal

rem Check Administrator Permission
net session > nul 2>&1
if errorlevel 1 set ERR_MSG=Permission denied. & goto ERROR

rem Change Current Directory
cd /d %~dp0

rem Start MacType from TaskScheduler
sc config mactype start= demand
schtasks /Create /XML MacTypeService.xml /TN MacType

:ERROR
if defined ERR_MSG echo %ERR_MSG%

endlocal
pause
exit %errorlevel%
