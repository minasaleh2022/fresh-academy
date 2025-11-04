@echo off
where flutter
if %ERRORLEVEL% NEQ 0 echo [!] Flutter not in PATH
flutter --version
flutter doctor -v
echo.
echo If there are red X errors above, share them here to get fixes.
pause
