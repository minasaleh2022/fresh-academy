import 'package:flutter/material.dart';
import '../../data/hive_RepoProvider.RepoProvider.repo.dart';
import '../../data/models.dart';

class ManageCourses extends StatefulWidget {
  const ManageCourses({super.key});
  @override
  State<ManageCourses> createState() => _ManageCoursesState();
}
class _ManageCoursesState extends State<ManageCourses> {
  int? _deptId;
  void _openForm([Course? c]){
    _deptId = c?.departmentId ?? RepoProvider.RepoProvider.repo.getDepartments().first.id;
    final title = TextEditingController(text: c?.title);
    final level = TextEditingController(text: c?.level);
    final duration = TextEditingController(text: c?.duration.toString());
    final rating = TextEditingController(text: c?.rating.toString());
    final trainer = TextEditingController(text: c?.trainer);
    final summary = TextEditingController(text: c?.summary);
    showDialog(context: context, builder: (_)=> AlertDialog(
      title: Text(c==null ? 'إضافة دورة':'تعديل دورة'),
      content: SizedBox(width: 420, child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
        DropdownButtonFormField<int>(
          value: _deptId,
          decoration: const InputDecoration(labelText: 'القسم'),
          items: RepoProvider.RepoProvider.repo.getDepartments().map((d)=> DropdownMenuItem(value: d.id, child: Text(d.name))).toList(),
          onChanged: (v)=> _deptId = v,
        ),
        const SizedBox(height: 8),
        TextField(controller: title, decoration: const InputDecoration(labelText: 'عنوان الدورة')),
        const SizedBox(height: 8),
        TextField(controller: level, decoration: const InputDecoration(labelText: 'المستوى')),
        const SizedBox(height: 8),
        TextField(controller: duration, decoration: const InputDecoration(labelText: 'المدة بالساعات'), keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        TextField(controller: rating, decoration: const InputDecoration(labelText: 'التقييم'), keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        TextField(controller: trainer, decoration: const InputDecoration(labelText: 'المدرب')),
        const SizedBox(height: 8),
        TextField(controller: summary, decoration: const InputDecoration(labelText: 'الملخص')),
      ]))),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('إلغاء')),
        ElevatedButton(onPressed: (){
          if(c==null){
            final id = (RepoProvider.RepoProvider.repo.getCourses().isEmpty?1: RepoProvider.RepoProvider.repo.getCourses().map((e)=>e.id).reduce((a,b)=> a>b?a:b)+1);
            RepoProvider.RepoProvider.repo.addCourse(Course(id: id, departmentId: _deptId!, title: title.text, level: level.text, duration: int.tryParse(duration.text)??0, rating: double.tryParse(rating.text)??0.0, trainer: trainer.text, summary: summary.text));
          }else{
            RepoProvider.RepoProvider.repo.updateCourse(Course(id: c.id, departmentId: _deptId!, title: title.text, level: level.text, duration: int.tryParse(duration.text)??0, rating: double.tryParse(rating.text)??0.0, trainer: trainer.text, summary: summary.text));
          }
          setState((){}); Navigator.pop(context);
        }, child: const Text('حفظ')),
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    final list = RepoProvider.RepoProvider.repo.getCourses();
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة الدورات')),
      floatingActionButton: FloatingActionButton(onPressed: ()=>_openForm(), child: const Icon(Icons.add)),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i){
          final c = list[i];
          final dept = RepoProvider.RepoProvider.repo.getDepartments().firstWhere((d)=> d.id==c.departmentId).name;
          return Card(child: ListTile(
            leading: const Icon(Icons.menu_book_outlined),
            title: Text(c.title),
            subtitle: Text('$dept • ${c.level} • ${c.duration} ساعة • ⭐ ${c.rating}'),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(icon: const Icon(Icons.edit), onPressed: ()=> _openForm(c)),
              IconButton(icon: const Icon(Icons.delete_outline), onPressed: (){ RepoProvider.RepoProvider.repo.deleteCourse(c.id); setState((){}); }),
            ]),
          ));},
      ),
    );
  }
}
