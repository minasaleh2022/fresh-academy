#!/usr/bin/env bash
set -e
echo "=== Fresh Academy — ONE CLICK: Build + Install (Debug) ==="
command -v flutter >/dev/null 2>&1 || { echo "[!] Flutter not found in PATH"; exit 1; }
[ -f "pubspec.yaml" ] || { echo "[!] Run from project root (pubspec.yaml)"; exit 1; }
flutter doctor --android-licenses || true
flutter create .
flutter pub get
echo "Building APK (debug)..."
flutter build apk --debug -v > one_click_build/build_log.txt 2>&1 || { echo "[!] Build failed. See one_click_build/build_log.txt"; exit 1; }
APK1="build/app/outputs/flutter-apk/app-debug.apk"
APK2="android/app/build/outputs/apk/debug/app-debug.apk"
FOUND=""; [ -f "$APK1" ] && FOUND="$APK1"; [ -f "$APK2" ] && FOUND="$APK2"
if [ -z "$FOUND" ]; then
  echo "[!] APK not found in expected paths."
  echo "Please open one_click_build/build_log.txt and share the last 30 lines."
  exit 1
fi
echo "APK ready at: $FOUND"
if command -v adb >/dev/null 2>&1; then
  adb devices
  adb install -r "$FOUND" || { echo "[!] adb install failed"; exit 1; }
  echo "Done! App installed."
else
  echo "[i] adb not found. Copy the APK to phone manually or install with: adb install -r "$FOUND""
fi
