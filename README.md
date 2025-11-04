# Fresh Academy PRO — Flutter (Full Features)
يشمل:
- CRUD كامل: الأقسام، الدورات، المتدربون (بـ **الرقم القومي**).
- كتالوج دورات بمحتوى حقيقي + تفاصيل دورة + مواد تعليمية.
- لوحة تقارير بسيطة.
- الدعم الفني: الدردشة المباشرة + اختيار الموديل → يظهر المادة العلمية + أكواد الأعطال والحلول.
- تنقل سفلي + GoRouter + Theme Fresh.

## التشغيل
```bash
flutter create .
flutter pub get
flutter run
```

## بناء APK
```bash
flutter build apk --debug
# أو
flutter build apk --release
```

## التوقيع (Release)
- أنشئ keystore ثم key.properties (راجع التعليمات التي سأرسِلها لك).


## الإضافات الجديدة
- **Hive** للتخزين المحلي (Persistence) للأقسام/الدورات/المتدربين/الحضور/الدردشة.
- **Dio + JWT** مع تخزين التوكن وإضافة Header تلقائيًا.
- **Charts (fl_chart)** لعرض التقدم الشهري.
- **Attendance (table_calendar)** لتسجيل الحضور والتأخير والغياب.


## RBAC + REST + PDF
- **RBAC** عبر `lib/core/rbac.dart` — اختر الدور من شاشة الدخول (للتجربة).
- **REST CRUD** عبر `lib/data/rest_repo.dart` — لتفعيلها غيّر `RepoProvider.mode` إلى `DataMode.remote`.
- **Charts إضافية** على المسار `/reports/extra` + زر تصدير PDF (باستخدام pdf/printing).
