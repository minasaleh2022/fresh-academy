import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../data/repo_provider.dart';
import '../../data/models.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});
  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}
class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime focused = DateTime.now();
  DateTime selected = DateTime.now();
  int? traineeId;

  @override
  Widget build(BuildContext context) {
    final trainees = RepoProvider.RepoProvider.repo.getTrainees();
    traineeId ??= trainees.isNotEmpty ? trainees.first.id : null;
    return Scaffold(
      appBar: AppBar(title: const Text('نظام الحضور والجدولة')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<int>(
            value: traineeId,
            items: trainees.map((t)=> DropdownMenuItem(value: t.id, child: Text('${t.fullName} • ${t.nationalId}'))).toList(),
            onChanged: (v)=> setState(()=> traineeId = v),
            decoration: const InputDecoration(labelText: 'المتدرب'),
          ),
          const SizedBox(height: 12),
          TableCalendar(
            focusedDay: focused,
            firstDay: DateTime.utc(2020,1,1),
            lastDay: DateTime.utc(2030,12,31),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (d)=> isSameDay(d, selected),
            onDaySelected: (sel, foc){ setState((){ selected = sel; focused = foc; }); },
          ),
          const SizedBox(height: 12),
          if(traineeId!=null) _attendanceControls(),
        ],
      ),
    );
  }

  Widget _attendanceControls(){
    final rec = RepoProvider.RepoProvider.repo.getAttendance(selected, traineeId!);
    final status = rec==null? 'غير مسجل' : rec['status'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('الحالة لليوم ${selected.toString().substring(0,10)}: $status'),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: [
            ElevatedButton(onPressed: ()=> _set('حاضر'), child: const Text('تسجيل حضور')),
            ElevatedButton(onPressed: ()=> _set('متأخر'), child: const Text('تسجيل تأخير')),
            ElevatedButton(onPressed: ()=> _set('غائب'), child: const Text('تسجيل غياب')),
          ]),
        ]),
      ),
    );
  }

  void _set(String s){
    RepoProvider.RepoProvider.repo.setAttendance(selected, traineeId!, s);
    setState((){});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم التحديث: $s')));
  }
}
