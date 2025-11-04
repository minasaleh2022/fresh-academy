import 'package:flutter/material.dart';
import '../../widgets_imports.dart';
import '../../core/rbac.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});
  @override State<AdminDashboard> createState() => _AdminDashboardState();
}
class _AdminDashboardState extends State<AdminDashboard> { UserRole? role; @override void initState(){ super.initState(); _load(); } void _load() async{ role = await RBAC.getRole(); setState((){}); }
  const AdminDashboard({super.key});
  @override
  Widget build(BuildContext context) { if(role==null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة تحكم المدير')),
      floatingActionButton: PopupMenuButton<String>(
        icon: const Icon(Icons.add),
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'dept', child: Text('إضافة قسم')),
          PopupMenuItem(value: 'course', child: Text('إضافة دورة')),
          PopupMenuItem(value: 'trainee', child: Text('إضافة متدرب')),
        ],
        onSelected: (v){
          switch(v){
            case 'dept': context.push('/departments/manage'); break;
            case 'course': context.push('/courses/manage'); break;
            case 'trainee': context.push('/users/trainees'); break;
          }
        },
      ),
      body: GridView.count(
        crossAxisCount: 2, padding: const EdgeInsets.all(16),
        crossAxisSpacing: 12, mainAxisSpacing: 12,
        children: [
          if(RBAC.canManageUsers(role!)) GestureDetector(onTap: ()=>context.push('/departments/manage'), child: const StatCard(title:'الأقسام', value:'—', icon: Icons.apartment_outlined)),
          if(RBAC.canManageCatalog(role!)) GestureDetector(onTap: ()=>context.push('/courses/manage'), child: const StatCard(title:'الدورات', value:'—', icon: Icons.menu_book_outlined)),
          if(RBAC.canManageUsers(role!)) GestureDetector(onTap: ()=>context.push('/users/trainees'), child: const StatCard(title:'المتدربون', value:'—', icon: Icons.group_outlined)),
          if(RBAC.canSeeReports(role!)) GestureDetector(onTap: ()=>context.push('/reports/dashboard'), child: const StatCard(title:'التقارير', value:'—', icon: Icons.bar_chart_outlined)),
          GestureDetector(onTap: ()=>context.push('/attendance'), child: const StatCard(title:'الحضور', value:'', icon: Icons.calendar_month_outlined)) ,
          GestureDetector(onTap: ()=>context.push('/attendance'), child: const StatCard(title:'الحضور', value:'', icon: Icons.calendar_month_outlined)) ,
          GestureDetector(onTap: ()=>context.push('/departments/manage'),
            child: const StatCard(title:'الأقسام', value:'5', icon: Icons.apartment_outlined)),
          GestureDetector(onTap: ()=>context.push('/courses/manage'),
            child: const StatCard(title:'الدورات', value:'3', icon: Icons.menu_book_outlined)),
          GestureDetector(onTap: ()=>context.push('/users/trainees'),
            child: const StatCard(title:'المتدربون', value:'2', icon: Icons.group_outlined)),
          GestureDetector(onTap: ()=>context.push('/reports/dashboard'),
            child: const StatCard(title:'التقارير', value:'4', icon: Icons.bar_chart_outlined)),
        ],
      ),
    );
  }
}
