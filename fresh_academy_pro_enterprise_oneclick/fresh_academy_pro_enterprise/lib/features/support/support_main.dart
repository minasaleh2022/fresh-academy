import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class SupportMain extends StatelessWidget {
  const SupportMain({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الدعم الفني')),
      body: GridView.count(
        crossAxisCount: 2, padding: const EdgeInsets.all(16), crossAxisSpacing: 12, mainAxisSpacing: 12,
        children: [
          _tile(context, Icons.chat_bubble_outline, 'الدردشة المباشرة', '/support/chat'),
          _tile(context, Icons.article_outlined, 'قاعدة المعرفة', '/support/kb'),
          _tile(context, Icons.view_in_ar_outlined, 'اختيار الموديل', '/support/model'),
        ],
      ),
    );
  }
  Widget _tile(BuildContext ctx, IconData i, String t, String route)=> Card(child: InkWell(
    onTap: ()=> ctx.push(route),
    child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(i, size: 36), const SizedBox(height: 8), Text(t)])),
  ));
}
