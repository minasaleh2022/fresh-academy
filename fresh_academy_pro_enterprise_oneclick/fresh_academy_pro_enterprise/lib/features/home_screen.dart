import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fresh Academy - الرئيسية')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(leading: Icon(Icons.dashboard_outlined), title: Text('لوحة تحكم المدير'), subtitle: Text('إدارة الأقسام/الدورات/المتدربين')),
          ListTile(leading: Icon(Icons.menu_book_outlined), title: Text('كتالوج الدورات')),
          ListTile(leading: Icon(Icons.support_agent_outlined), title: Text('الدعم الفني')),
          ListTile(leading: Icon(Icons.bar_chart_outlined), title: Text('التقارير')),
        ],
      ),
    );
  }
}
