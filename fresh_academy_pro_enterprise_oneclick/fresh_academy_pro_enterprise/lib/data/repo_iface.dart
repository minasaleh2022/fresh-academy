import 'models.dart';

abstract class IDataRepo {
  // Departments
  List<Department> getDepartments();
  Future<void> addDepartment(Department d);
  Future<void> updateDepartment(Department d);
  Future<void> deleteDepartment(int id);

  // Courses
  List<Course> getCourses();
  Future<void> addCourse(Course c);
  Future<void> updateCourse(Course c);
  Future<void> deleteCourse(int id);

  // Trainees
  List<Trainee> getTrainees();
  Future<void> addTrainee(Trainee t);
  Future<void> updateTrainee(Trainee t);
  Future<void> deleteTrainee(int id);

  // Attendance
  Future<void> setAttendance(DateTime day, int traineeId, String status);
  Map<String, dynamic>? getAttendance(DateTime day, int traineeId);
}
