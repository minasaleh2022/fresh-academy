import 'package:hive_flutter/hive_flutter.dart';
import 'models.dart';
import '../core/hive_store.dart';

class HiveRepo {
  final Box _dept = Hive.box(HiveStore.deptBox);
  final Box _course = Hive.box(HiveStore.courseBox);
  final Box _trainee = Hive.box(HiveStore.traineeBox);
  final Box _attendance = Hive.box(HiveStore.attendanceBox);
  final Box _chat = Hive.box(HiveStore.chatBox);

  int _nextId(Box box) {
    final keys = box.keys.whereType<int>().toList();
    if(keys.isEmpty) return 1;
    keys.sort();
    return keys.last + 1;
  }

  // Departments
  List<Department> getDepartments(){
    return _dept.values.map((e)=> Department(id: e['id'], name: e['name'], description: e['description'])).toList();
  }
  void addDepartment(Department d){
    final id = _nextId(_dept);
    _dept.put(id, {'id': id, 'name': d.name, 'description': d.description});
  }
  void updateDepartment(Department d){
    _dept.put(d.id, {'id': d.id, 'name': d.name, 'description': d.description});
  }
  void deleteDepartment(int id){ _dept.delete(id); }

  // Courses
  List<Course> getCourses(){
    return _course.values.map((e)=> Course(id: e['id'], departmentId: e['departmentId'], title: e['title'], level: e['level'], duration: e['duration'], rating: (e['rating'] as num).toDouble(), trainer: e['trainer'], summary: e['summary'])).toList();
  }
  void addCourse(Course c){
    final id = _nextId(_course);
    _course.put(id, {'id': id, 'departmentId': c.departmentId, 'title': c.title, 'level': c.level, 'duration': c.duration, 'rating': c.rating, 'trainer': c.trainer, 'summary': c.summary});
  }
  void updateCourse(Course c){
    _course.put(c.id, {'id': c.id, 'departmentId': c.departmentId, 'title': c.title, 'level': c.level, 'duration': c.duration, 'rating': c.rating, 'trainer': c.trainer, 'summary': c.summary});
  }
  void deleteCourse(int id){ _course.delete(id); }

  // Trainees
  List<Trainee> getTrainees(){
    return _trainee.values.map((e)=> Trainee(id: e['id'], fullName: e['fullName'], email: e['email'], nationalId: e['nationalId'], departmentId: e['departmentId'])).toList();
  }
  void addTrainee(Trainee t){
    final id = _nextId(_trainee);
    _trainee.put(id, {'id': id, 'fullName': t.fullName, 'email': t.email, 'nationalId': t.nationalId, 'departmentId': t.departmentId});
  }
  void updateTrainee(Trainee t){
    _trainee.put(t.id, {'id': t.id, 'fullName': t.fullName, 'email': t.email, 'nationalId': t.nationalId, 'departmentId': t.departmentId});
  }
  void deleteTrainee(int id){ _trainee.delete(id); }

  // Attendance: key = 'yyyy-mm-dd|traineeId'
  void setAttendance(DateTime day, int traineeId, String status){
    final key = '${day.toIso8601String().substring(0,10)}|$traineeId';
    _attendance.put(key, {'date': day.millisecondsSinceEpoch, 'traineeId': traineeId, 'status': status});
  }
  Map<String, dynamic>? getAttendance(DateTime day, int traineeId){
    final key = '${day.toIso8601String().substring(0,10)}|$traineeId';
    return _attendance.get(key);
  }

  // Chat
  List<Map> getChatHistory(){
    return _chat.values.map((e)=> {'id': e['id'], 'from': e['from'], 'text': e['text'], 'at': e['at']}).toList();
  }
  void addChat(Map m){
    final id = _nextId(_chat);
    _chat.put(id, {'id': id, ...m});
  }

  // Seed sample data once
  Future<void> seedIfEmpty() async {
    if(_dept.isEmpty){
      addDepartment(Department(id: 0, name: 'قسم التبريد', description: 'أساسيات ونظم التبريد'));
      addDepartment(Department(id: 0, name: 'قسم التكييف', description: 'أنظمة HVAC'));
      addDepartment(Department(id: 0, name: 'قسم الغسالات', description: 'صيانة الغسالات'));
    }
    if(_course.isEmpty){
      addCourse(Course(id: 0, departmentId: 1, title: 'أساسيات التبريد', level: 'مبتدئ', duration: 24, rating: 4.6, trainer: 'م. أحمد', summary: 'مبادئ التبريد.'));
      addCourse(Course(id: 0, departmentId: 2, title: 'صيانة المكيفات', level: 'متوسط', duration: 32, rating: 4.3, trainer: 'م. سارة', summary: 'تشخيص أعطال.'));
    }
    if(_trainee.isEmpty){
      addTrainee(Trainee(id: 0, fullName: 'محمود السيد', email: 'mahmoud@example.com', nationalId: '29801010123456', departmentId: 1));
      addTrainee(Trainee(id: 0, fullName: 'آية عماد', email: 'aya@example.com', nationalId: '30105051234567', departmentId: 2));
    }
  }
}

final hiveRepo = HiveRepo();


import 'repo_iface.dart';

class HiveRepoAdapter implements IDataRepo {
  @override List<Department> getDepartments() => hiveRepo.getDepartments();
  @override Future<void> addDepartment(Department d) async => hiveRepo.addDepartment(d);
  @override Future<void> updateDepartment(Department d) async => hiveRepo.updateDepartment(d);
  @override Future<void> deleteDepartment(int id) async => hiveRepo.deleteDepartment(id);

  @override List<Course> getCourses() => hiveRepo.getCourses();
  @override Future<void> addCourse(Course c) async => hiveRepo.addCourse(c);
  @override Future<void> updateCourse(Course c) async => hiveRepo.updateCourse(c);
  @override Future<void> deleteCourse(int id) async => hiveRepo.deleteCourse(id);

  @override List<Trainee> getTrainees() => hiveRepo.getTrainees();
  @override Future<void> addTrainee(Trainee t) async => hiveRepo.addTrainee(t);
  @override Future<void> updateTrainee(Trainee t) async => hiveRepo.updateTrainee(t);
  @override Future<void> deleteTrainee(int id) async => hiveRepo.deleteTrainee(id);

  @override Future<void> setAttendance(DateTime day, int traineeId, String status) async => hiveRepo.setAttendance(day, traineeId, status);
  @override Map<String, dynamic>? getAttendance(DateTime day, int traineeId) => hiveRepo.getAttendance(day, traineeId);
}
