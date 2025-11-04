import 'package:flutter/material.dart';
import '../../data/hive_RepoProvider.RepoProvider.repo.dart';
import 'package:go_router/go_router.dart';

class CoursesCatalog extends StatefulWidget {
  const CoursesCatalog({super.key});
  @override
  State<CoursesCatalog> createState() => _CoursesCatalogState();
}
class _CoursesCatalogState extends State<CoursesCatalog> {
  String query=''; int? deptId;
  @override
  Widget build(BuildContext context) {
    final list = RepoProvider.RepoProvider.repo.getCourses().where((c){
      final byDept = deptId==null || c.departmentId==deptId;
      final byText = query.isEmpty || c.title.contains(query) || c.summary.contains(query);
      return byDept && byText;
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('كتالوج الدورات')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            Expanded(child: TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), labelText: 'ابحث'), onChanged: (v)=> setState(()=> query=v.trim()))),
            const SizedBox(width: 8),
            Expanded(child: DropdownButtonFormField<int>(
              isExpanded: true,
              value: deptId,
              items: [const DropdownMenuItem(value: null, child: Text('كل الأقسام')),
                ...RepoProvider.RepoProvider.repo.getDepartments().map((d)=> DropdownMenuItem(value: d.id, child: Text(d.name)))],
              onChanged: (v)=> setState(()=> deptId=v),
              decoration: const InputDecoration(labelText: 'القسم'),
            )),
          ]),
        ),
        Expanded(child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, i){
            final c = list[i];
            final dept = RepoProvider.RepoProvider.repo.getDepartments().firstWhere((d)=>d.id==c.departmentId).name;
            return Card(child: ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: Text(c.title),
              subtitle: Text('$dept • ${c.level} • ${c.duration} ساعة • ⭐ ${c.rating}'),
              trailing: const Icon(Icons.arrow_back_ios_new),
              onTap: ()=> context.push('/courses/details', extra: c.id),
            ));},
        )),
      ]),
    );
  }
}
