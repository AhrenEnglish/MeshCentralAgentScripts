@echo off
set SVC=Mesh Agent
set LOG=%~dp0\MeshAgentRestart.log

:: --- Self-elevate if not running as admin ---
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo %date% %time% Script not elevated. Relaunching as administrator...>> "%LOG%"
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo %date% %time% ==== Restart attempt started for "%SVC%" ====>> "%LOG%"

echo %date% %time% Stopping service "%SVC%"...>> "%LOG%"
net stop "%SVC%" >> "%LOG%" 2>&1

echo %date% %time% Waiting 5 seconds...>> "%LOG%"
timeout /t 5 >nul

echo %date% %time% Starting service "%SVC%"...>> "%LOG%"
cmd /c "net start "%SVC%"" >> "%LOG%" 2>&1

echo %date% %time% ==== Restart attempt finished for "%SVC%" ====>> "%LOG%"
