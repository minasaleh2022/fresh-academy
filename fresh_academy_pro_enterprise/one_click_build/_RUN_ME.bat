@echo off
setlocal enabledelayedexpansion
title Fresh Academy - Build & Install (Debug)
where flutter >nul 2>&1 || (echo [!] Flutter not found in PATH. Install Flutter and add it to PATH. & pause & exit /b 1)
if not exist "pubspec.yaml" (
  echo [!] Run this file from the PROJECT ROOT (the folder that contains pubspec.yaml).
  echo     Open the project folder, then double-click: one_click_build\_RUN_ME.bat
  pause
  exit /b 1
)
echo Checking Android licenses...
for /f "tokens=*" %%i in ('flutter doctor --android-licenses 2^>^&1') do (echo %%i)
echo Ensuring android/ios present...
flutter create . || (echo [!] flutter create failed & pause & exit /b 1)
echo Getting packages...
flutter pub get || (echo [!] flutter pub get failed & pause & exit /b 1)
echo Building APK (debug)... this can take several minutes...
flutter build apk --debug -v > one_click_build\build_log.txt 2>&1
if %ERRORLEVEL% NEQ 0 (
  echo [!] Build failed. See detailed log at one_click_build\build_log.txt
  notepad one_click_build\build_log.txt
  pause
  exit /b 1
)
set APK1=build\app\outputs\flutter-apk\app-debug.apk
set APK2=android\app\build\outputs\apk\debug\app-debug.apk
set FOUND_APK=
if exist "%APK1%" set FOUND_APK=%APK1%
if exist "%APK2%" set FOUND_APK=%APK2%
if "%FOUND_APK%"=="" (
  echo [!] APK not found in common paths.
  echo Tried:
  echo   %APK1%
  echo   %APK2%
  echo Please open one_click_build\build_log.txt and share the last 30 lines.
  pause
  exit /b 1
)
echo APK ready at: %FOUND_APK%
where adb >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
  echo [i] ADB not found in PATH. Skipping auto-install.
  echo You can copy the APK to your phone manually or install with:
  echo   adb install -r "%FOUND_APK%"
  pause
  exit /b 0
)
echo Installing on connected device (if any)...
adb devices
adb install -r "%FOUND_APK%"
if %ERRORLEVEL% NEQ 0 (
  echo [!] ADB install failed. Ensure USB debugging is enabled and device is authorized.
  pause
  exit /b 1
)
echo Done! App installed successfully.
pause
