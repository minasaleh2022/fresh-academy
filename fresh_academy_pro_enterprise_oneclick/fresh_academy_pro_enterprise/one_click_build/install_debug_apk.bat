@echo off
REM === Install Debug APK to connected Android (Windows) ===
set APK=build\app\outputs\flutter-apk\app-debug.apk
if not exist %APK% (
  echo [!] %APK% not found. Run one_click_build\build_debug_apk.bat first.
  pause
  exit /b 1
)
where adb >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
  echo [!] ADB not found in PATH. Install Android Platform-Tools and add to PATH.
  pause
  exit /b 1
)
adb devices
adb install -r %APK%
pause
