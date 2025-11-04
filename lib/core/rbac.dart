import 'package:shared_preferences/shared_preferences.dart';

enum UserRole { admin, trainer, trainee }

class RBAC {
  static const _kRole = 'user_role';
  static Future<void> setRole(UserRole role) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kRole, role.name);
  }
  static Future<UserRole> getRole() async {
    final sp = await SharedPreferences.getInstance();
    final v = sp.getString(_kRole);
    switch (v) {
      case 'admin': return UserRole.admin;
      case 'trainer': return UserRole.trainer;
      case 'trainee': return UserRole.trainee;
      default: return UserRole.trainee;
    }
  }
  static bool canManageCatalog(UserRole r) => r == UserRole.admin || r == UserRole.trainer;
  static bool canManageUsers(UserRole r) => r == UserRole.admin;
  static bool canSeeReports(UserRole r) => r == UserRole.admin || r == UserRole.trainer;
  static bool canUseAttendance(UserRole r) => r != UserRole.trainer ? true : true; // الكل مسموح
}
