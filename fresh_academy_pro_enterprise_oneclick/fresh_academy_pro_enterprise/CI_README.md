
# CI إعداد GitHub Actions لبناء APK موقّع

## المتطلبات
أضف Secrets التالية في مستودع GitHub (Settings → Secrets and variables → Actions → New repository secret):

- `ANDROID_KEYSTORE_BASE64` : ملف keystore مشفّر base64
- `KEYSTORE_PASSWORD` : كلمة سر keystore
- `KEY_PASSWORD` : كلمة سر المفتاح
- `KEY_ALIAS` : اسم alias (مثلاً fresh)

## إنشاء keystore ثم تحويله إلى Base64
```bash
# إنشاء keystore (مثال)
keytool -genkey -v -keystore ~/fresh-release.jks -keyalg RSA -keysize 2048 -validity 10000 -alias fresh

# تحويل إلى base64 لرفعه كـ Secret
base64 -w 0 ~/fresh-release.jks > keystore.b64
# انسخ محتوى keystore.b64 إلى SECRET باسم ANDROID_KEYSTORE_BASE64
```

## تشغيل الـ CI
- تلقائيًا عند أي push إلى الفرع `main`/`master`، أو يدويًا من تبويب Actions.
- سيظهر Artifact باسم `signed-apk` يحتوي على APK الموقّع.
