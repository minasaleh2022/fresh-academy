import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStore {
  static const deptBox = 'departments';
  static const courseBox = 'courses';
  static const traineeBox = 'trainees';
  static const attendanceBox = 'attendance';
  static const chatBox = 'chat';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(deptBox);
    await Hive.openBox(courseBox);
    await Hive.openBox(traineeBox);
    await Hive.openBox(attendanceBox);
    await Hive.openBox(chatBox);
  }
}
