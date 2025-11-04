import 'package:flutter/material.dart';
import '../../data/hive_RepoProvider.RepoProvider.repo.dart';
class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key});
  @override
  Widget build(BuildContext context) {
    final id = (ModalRoute.of(context)?.settings.arguments ?? (ModalRoute.of(context)!.settings as dynamic).extra) as int? ?? 1;
    final c = RepoProvider.RepoProvider.repo.getCourses().firstWhere((x)=>x.id==id);
    final materials = RepoProvider.RepoProvider.repo.getMaterialsByCourse(c.id);
    return Scaffold(
      appBar: AppBar(title: Text(c.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [
            const CircleAvatar(child: Icon(Icons.person)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('المدرب: ${c.trainer}', style: const TextStyle(fontWeight: FontWeight.w600)),
              Text('القسم: ${c.departmentId} • المستوى: ${c.level} • ⭐ ${c.rating}'),
            ])),
          ]),
          const SizedBox(height: 16),
          Text(c.summary, style: const TextStyle(height: 1.4)),
          const SizedBox(height: 16),
          const Divider(),
          const Text('المواد التعليمية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ...materials.map((m)=> ListTile(leading: const Icon(Icons.picture_as_pdf_outlined), title: Text(m.title), subtitle: Text(m.type))),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تسجيلك تجريبيًا')));
          }, child: const Text('تسجيل في الدورة')),
        ],
      ),
    );
  }
}
