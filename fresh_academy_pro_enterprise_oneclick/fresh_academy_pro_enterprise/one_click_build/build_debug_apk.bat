@echo off
REM === Fresh Academy — Build Debug APK (Windows) ===
echo Checking Flutter...
where flutter >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
  echo [!] Flutter not found in PATH. Install Flutter or add it to PATH.
  pause
  exit /b 1
)

echo Creating android/ios if missing...
flutter create .
IF %ERRORLEVEL% NEQ 0 ( echo [!] flutter create failed & pause & exit /b 1 )

echo Getting packages...
flutter pub get
IF %ERRORLEVEL% NEQ 0 ( echo [!] flutter pub get failed & pause & exit /b 1 )

echo Building APK (debug)...
flutter build apk --debug
IF %ERRORLEVEL% NEQ 0 ( echo [!] flutter build failed & pause & exit /b 1 )

echo APK ready at: build\app\outputs\flutter-apk\app-debug.apk
echo.
echo To install on a connected device (needs ADB):
echo   adb install -r build\app\outputs\flutter-apk\app-debug.apk
pause
