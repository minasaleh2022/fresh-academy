class Department {
  int id; String name; String description;
  Department({required this.id, required this.name, required this.description});
}

class Course {
  int id; int departmentId; String title; String level; int duration; double rating; String trainer; String summary;
  Course({required this.id, required this.departmentId, required this.title, required this.level, required this.duration, required this.rating, required this.trainer, required this.summary});
}

class Trainee {
  int id; String fullName; String email; String nationalId; int? departmentId;
  Trainee({required this.id, required this.fullName, required this.email, required this.nationalId, this.departmentId});
}

class ErrorCode {
  int id; int departmentId; String code; String description; String resolution;
  ErrorCode({required this.id, required this.departmentId, required this.code, required this.description, required this.resolution});
}

class MaterialDoc {
  int id; int courseId; String title; String type; String url;
  MaterialDoc({required this.id, required this.courseId, required this.title, required this.type, required this.url});
}

class ChatMessage {
  int id; String from; String text; DateTime at;
  ChatMessage({required this.id, required this.from, required this.text, required this.at});
}

class DeviceModel {
  int id; int departmentId; String name;
  DeviceModel({required this.id, required this.departmentId, required this.name});
}
