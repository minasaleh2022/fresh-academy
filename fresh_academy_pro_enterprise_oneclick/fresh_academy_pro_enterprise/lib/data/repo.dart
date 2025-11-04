import 'models.dart';
import 'mock_data.dart';

class Repo {
  // simple in-memory repo
  List<Department> getDepartments() => departments;
  void addDepartment(Department d) => departments.add(d);
  void updateDepartment(Department d) {
    final i = departments.indexWhere((x)=>x.id==d.id); if (i>=0) departments[i]=d;
  }
  void deleteDepartment(int id) => departments.removeWhere((x)=>x.id==id);

  List<Course> getCourses() => courses;
  void addCourse(Course c) => courses.add(c);
  void updateCourse(Course c){ final i=courses.indexWhere((x)=>x.id==c.id); if(i>=0) courses[i]=c; }
  void deleteCourse(int id)=> courses.removeWhere((x)=>x.id==id);

  List<Trainee> getTrainees()=> trainees;
  void addTrainee(Trainee t)=> trainees.add(t);
  void updateTrainee(Trainee t){ final i=trainees.indexWhere((x)=>x.id==t.id); if(i>=0) trainees[i]=t; }
  void deleteTrainee(int id)=> trainees.removeWhere((x)=>x.id==id);

  List<DeviceModel> getModels()=> models;

  List<ErrorCode> getErrorCodesByDept(int deptId)=> errorCodes.where((e)=>e.departmentId==deptId).toList();
  List<MaterialDoc> getMaterialsByCourse(int courseId)=> materialsDocs.where((m)=>m.courseId==courseId).toList();

  List<ChatMessage> getChatSeed()=> chatSeed;
  void addMessage(ChatMessage m)=> chatSeed.add(m);
}
final repo = Repo();
