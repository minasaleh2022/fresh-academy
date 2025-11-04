import 'package:dio/dio.dart';
import '../core/http_client.dart';
import 'models.dart';
import 'repo_iface.dart';

class RestRepo implements IDataRepo {
  final Dio _dio = HttpClient.dio;

  // Departments
  @override
  List<Department> getDepartments() => throw UnimplementedError('Use getDepartmentsAsync');
  Future<List<Department>> getDepartmentsAsync() async {
    final res = await _dio.get('/v1/departments');
    final list = (res.data as List).map((e)=> Department(id: e['id'], name: e['name'], description: e['description']??'')).toList();
    return list;
  }
  @override
  Future<void> addDepartment(Department d) async { await _dio.post('/v1/departments', data: {'name': d.name,'description': d.description}); }
  @override
  Future<void> updateDepartment(Department d) async { await _dio.put('/v1/departments/${d.id}', data: {'name': d.name,'description': d.description}); }
  @override
  Future<void> deleteDepartment(int id) async { await _dio.delete('/v1/departments/$id'); }

  // Courses
  @override
  List<Course> getCourses() => throw UnimplementedError('Use getCoursesAsync');
  Future<List<Course>> getCoursesAsync() async {
    final res = await _dio.get('/v1/courses');
    return (res.data as List).map((e)=> Course(id: e['id'], departmentId: e['departmentId'], title: e['title'], level: e['level'], duration: e['duration'], rating: (e['rating'] as num?)?.toDouble() ?? 0.0, trainer: e['trainer']??'', summary: e['summary']??'')).toList();
  }
  @override
  Future<void> addCourse(Course c) async { await _dio.post('/v1/courses', data: {'departmentId': c.departmentId,'title': c.title,'level': c.level,'duration': c.duration,'rating': c.rating,'trainer': c.trainer,'summary': c.summary}); }
  @override
  Future<void> updateCourse(Course c) async { await _dio.put('/v1/courses/${c.id}', data: {'departmentId': c.departmentId,'title': c.title,'level': c.level,'duration': c.duration,'rating': c.rating,'trainer': c.trainer,'summary': c.summary}); }
  @override
  Future<void> deleteCourse(int id) async { await _dio.delete('/v1/courses/$id'); }

  // Trainees
  @override
  List<Trainee> getTrainees() => throw UnimplementedError('Use getTraineesAsync');
  Future<List<Trainee>> getTraineesAsync() async {
    final res = await _dio.get('/v1/trainees');
    return (res.data as List).map((e)=> Trainee(id: e['id'], fullName: e['fullName'], email: e['email'], nationalId: e['nationalId'], departmentId: e['departmentId'])).toList();
  }
  @override
  Future<void> addTrainee(Trainee t) async { await _dio.post('/v1/trainees', data: {'fullName': t.fullName,'email': t.email,'nationalId': t.nationalId,'departmentId': t.departmentId}); }
  @override
  Future<void> updateTrainee(Trainee t) async { await _dio.put('/v1/trainees/${t.id}', data: {'fullName': t.fullName,'email': t.email,'nationalId': t.nationalId,'departmentId': t.departmentId}); }
  @override
  Future<void> deleteTrainee(int id) async { await _dio.delete('/v1/trainees/$id'); }

  // Attendance
  @override
  Future<void> setAttendance(DateTime day, int traineeId, String status) async { await _dio.post('/v1/attendance', data: {'date': day.toIso8601String(),'traineeId': traineeId,'status': status}); }
  @override
  Map<String, dynamic>? getAttendance(DateTime day, int traineeId) => null; // استخدم endpoint منفصل عند الحاجة
}
