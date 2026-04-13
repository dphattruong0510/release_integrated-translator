@echo off

:: Check admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting admin...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit
)

set "DIR=%~dp0"

echo Running as admin...
echo Unblocking...

powershell -Command "Get-ChildItem '%DIR%' -Recurse | Unblock-File"
icacls "%DIR%" /grant Everyone:F /T

echo.
echo Launching app...

start "" "%DIR%IntegratedTranslator.exe"