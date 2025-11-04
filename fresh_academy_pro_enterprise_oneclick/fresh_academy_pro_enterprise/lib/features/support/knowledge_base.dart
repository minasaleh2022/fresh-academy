import 'package:flutter/material.dart';
import '../../data/hive_RepoProvider.RepoProvider.repo.dart';
class KnowledgeBase extends StatelessWidget {
  const KnowledgeBase({super.key});
  @override
  Widget build(BuildContext context) {
    final list = RepoProvider.RepoProvider.repo.getErrorCodesByDept(3); // مثال لقسم الغسالات
    return Scaffold(
      appBar: AppBar(title: const Text('قاعدة المعرفة')),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i){
          final e = list[i];
          return Card(child: ListTile(
            leading: const Icon(Icons.bug_hiveReport_outlined),
            title: Text('الكود ${e.code} — ${e.description}'),
            subtitle: Text('الحل: ${e.resolution}'),
          ));
        },
      ),
    );
  }
}
