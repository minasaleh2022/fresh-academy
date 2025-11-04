import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'core/router.dart';
import 'core/hive_store.dart';
import 'bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStore.init();
  await bootstrap();
  runApp(const FreshApp());
}
class FreshApp extends StatelessWidget {
  const FreshApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fresh Academy',
      theme: buildAppTheme(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
