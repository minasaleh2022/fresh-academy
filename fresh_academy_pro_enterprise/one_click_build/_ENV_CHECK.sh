#!/usr/bin/env bash
set -e
which flutter || echo "[!] Flutter not in PATH"
flutter --version || true
flutter doctor -v || true
echo
echo "If there are red X errors above, copy them here to get fixes."
