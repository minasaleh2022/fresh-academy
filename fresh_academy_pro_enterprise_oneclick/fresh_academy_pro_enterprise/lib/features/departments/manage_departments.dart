import 'package:flutter/material.dart';
import '../../data/hive_RepoProvider.RepoProvider.repo.dart';
import '../../data/models.dart';

class ManageDepartments extends StatefulWidget {
  const ManageDepartments({super.key});
  @override
  State<ManageDepartments> createState() => _ManageDepartmentsState();
}
class _ManageDepartmentsState extends State<ManageDepartments> {
  void _openForm([Department? d]){
    final name = TextEditingController(text: d?.name);
    final desc = TextEditingController(text: d?.description);
    showDialog(context: context, builder: (_)=> AlertDialog(
      title: Text(d==null? 'إضافة قسم':'تعديل قسم'),
      content: SizedBox(width: 400, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'اسم القسم')),
        const SizedBox(height: 12),
        TextField(controller: desc, decoration: const InputDecoration(labelText: 'الوصف')),
      ])),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('إلغاء')),
        ElevatedButton(onPressed: (){
          if(d==null){
            final id = (RepoProvider.RepoProvider.repo.getDepartments().isEmpty?1: RepoProvider.RepoProvider.repo.getDepartments().map((e)=>e.id).reduce((a,b)=> a>b?a:b)+1);
            RepoProvider.RepoProvider.repo.addDepartment(Department(id: id, name: name.text, description: desc.text));
          }else{
            RepoProvider.RepoProvider.repo.updateDepartment(Department(id: d.id, name: name.text, description: desc.text));
          }
          setState((){});
          Navigator.pop(context);
        }, child: const Text('حفظ')),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final list = RepoProvider.RepoProvider.repo.getDepartments();
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة الأقسام')),
      floatingActionButton: FloatingActionButton(onPressed: ()=>_openForm(), child: const Icon(Icons.add)),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i){
          final d = list[i];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.apartment_outlined),
              title: Text(d.name),
              subtitle: Text(d.description),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(icon: const Icon(Icons.edit), onPressed: ()=> _openForm(d)),
                IconButton(icon: const Icon(Icons.delete_outline), onPressed: (){ RepoProvider.RepoProvider.repo.deleteDepartment(d.id); setState((){}); }),
              ]),
            ),
          );
        },
      ),
    );
  }
}
