#!/usr/bin/env bash
set -e
APK=build/app/outputs/flutter-apk/app-debug.apk
if [ ! -f "$APK" ]; then
  echo "[!] $APK not found. Run one_click_build/build_debug_apk.sh first."
  exit 1
fi
command -v adb >/dev/null 2>&1 || { echo >&2 "[!] adb not found in PATH"; exit 1; }
adb devices
adb install -r "$APK"
