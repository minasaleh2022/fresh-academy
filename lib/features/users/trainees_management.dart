import 'package:flutter/material.dart';
import '../../data/hive_RepoProvider.RepoProvider.repo.dart';
import '../../data/models.dart';

class TraineesManagement extends StatefulWidget {
  const TraineesManagement({super.key});
  @override
  State<TraineesManagement> createState() => _TraineesManagementState();
}

class _TraineesManagementState extends State<TraineesManagement> {
  void _openForm([Trainee? t]){
    final name = TextEditingController(text: t?.fullName);
    final email = TextEditingController(text: t?.email);
    final nid = TextEditingController(text: t?.nationalId);
    int? deptId = t?.departmentId ?? (RepoProvider.RepoProvider.repo.getDepartments().isNotEmpty? RepoProvider.RepoProvider.repo.getDepartments().first.id : null);

    showDialog(context: context, builder: (_)=> AlertDialog(
      title: Text(t==null? 'إضافة متدرب':'تعديل متدرب'),
      content: SizedBox(width: 420, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'الاسم الكامل')),
        const SizedBox(height: 8),
        TextField(controller: email, decoration: const InputDecoration(labelText: 'البريد الإلكتروني')),
        const SizedBox(height: 8),
        TextField(controller: nid, decoration: const InputDecoration(labelText: 'الرقم القومي'), keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: deptId,
          items: RepoProvider.RepoProvider.repo.getDepartments().map((d)=> DropdownMenuItem(value: d.id, child: Text(d.name))).toList(),
          onChanged: (v)=> deptId = v,
          decoration: const InputDecoration(labelText: 'القسم'),
        ),
      ])),
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('إلغاء')),
        ElevatedButton(onPressed: (){
          if(t==null){
            final id = (RepoProvider.RepoProvider.repo.getTrainees().isEmpty?1: RepoProvider.RepoProvider.repo.getTrainees().map((e)=>e.id).reduce((a,b)=> a>b?a:b)+1);
            RepoProvider.RepoProvider.repo.addTrainee(Trainee(id: id, fullName: name.text, email: email.text, nationalId: nid.text, departmentId: deptId));
          }else{
            RepoProvider.RepoProvider.repo.updateTrainee(Trainee(id: t.id, fullName: name.text, email: email.text, nationalId: nid.text, departmentId: deptId));
          }
          setState((){}); Navigator.pop(context);
        }, child: const Text('حفظ')),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final list = RepoProvider.RepoProvider.repo.getTrainees();
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة المتدربين')),
      floatingActionButton: FloatingActionButton(onPressed: ()=> _openForm(), child: const Icon(Icons.person_add_alt)),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i){
          final t = list[i];
          final deptName = t.departmentId==null? '—' : RepoProvider.RepoProvider.repo.getDepartments().firstWhere((d)=> d.id==t.departmentId).name;
          return Card(child: ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text('${t.fullName}  •  ${t.nationalId}'),
            subtitle: Text('${t.email} • $deptName'),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(icon: const Icon(Icons.edit), onPressed: ()=> _openForm(t)),
              IconButton(icon: const Icon(Icons.delete_outline), onPressed: (){ RepoProvider.RepoProvider.repo.deleteTrainee(t.id); setState((){}); }),
            ]),
          ));
        },
      ),
    );
  }
}
