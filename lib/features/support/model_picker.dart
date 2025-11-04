import 'package:flutter/material.dart';
import '../../data/repo.dart';
class ModelPicker extends StatelessWidget {
  const ModelPicker({super.key});
  @override
  Widget build(BuildContext context) {
    final models = repo.getModels();
    return Scaffold(
      appBar: AppBar(title: const Text('اختيار الموديل بواسطة الفني')),
      body: ListView.builder(
        itemCount: models.length,
        itemBuilder: (_, i){
          final m = models[i];
          return Card(child: ListTile(
            leading: const Icon(Icons.view_in_ar_outlined),
            title: Text(m.name),
            subtitle: Text('قسم ID: ${m.departmentId}'),
            trailing: const Icon(Icons.arrow_back_ios_new),
            onTap: (){
              final errors = repo.getErrorCodesByDept(m.departmentId);
              Navigator.push(context, MaterialPageRoute(builder: (_)=> ModelResult(name: m.name, deptId: m.departmentId, errors: errors)));
            },
          ));
        },
      ),
    );
  }
}

class ModelResult extends StatelessWidget {
  final String name; final int deptId; final List errors;
  const ModelResult({super.key, required this.name, required this.deptId, required this.errors});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الموديل: $name')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('قسم: $deptId', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          const Text('المادة العلمية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const ListTile(leading: Icon(Icons.menu_book_outlined), title: Text('كتيب فني'), subtitle: Text('PDF • دليل الأعطال الشائعة')),
          const ListTile(leading: Icon(Icons.video_library_outlined), title: Text('فيديو تدريبي'), subtitle: Text('تشخيص عملى وحلول')),
          const Divider(),
          const Text('أكواد الأعطال والحلول', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ...errors.map((e)=> ListTile(
            leading: const Icon(Icons.bug_report_outlined),
            title: Text('الكود: ${e.code} — ${e.description}'),
            subtitle: Text('الحل: ${e.resolution}'),
          )),
        ],
      ),
    );
  }
}
