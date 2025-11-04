#!/usr/bin/env bash
# === Fresh Academy — Build Debug APK (macOS/Linux) ===
set -e
command -v flutter >/dev/null 2>&1 || { echo >&2 "[!] Flutter not found in PATH"; exit 1; }
flutter create .
flutter pub get
flutter build apk --debug
echo "APK ready at: build/app/outputs/flutter-apk/app-debug.apk"
echo
echo "To install (needs adb):"
echo "  adb install -r build/app/outputs/flutter-apk/app-debug.apk"
