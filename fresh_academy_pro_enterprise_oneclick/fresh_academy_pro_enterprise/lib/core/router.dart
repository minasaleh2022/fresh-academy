import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_shell.dart';
import '../features/home_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/auth/forgot_password_screen.dart';
import '../features/dashboard/admin_dashboard.dart';
import '../features/departments/manage_departments.dart';
import '../features/courses/manage_courses.dart';
import '../features/courses/ui_catalog.dart';
import '../features/courses/ui_details.dart';
import '../features/users/trainees_management.dart';
import '../features/users/user_profile.dart';
import '../features/support/support_main.dart';
import '../features/support/knowledge_base.dart';
import '../features/support/live_chat.dart';
import '../features/support/model_picker.dart';
import '../features/reports/reports_dashboard.dart';
import '../features/reports/extra_charts.dart';
import '../features/attendance/attendance_screen.dart';

final router = GoRouter(
  initialLocation: '/auth/login',
  routes: [
    GoRoute(path: '/auth/login', builder: (c, s) => const LoginScreen()),
    GoRoute(path: '/auth/register', builder: (c, s) => const RegisterScreen()),
    GoRoute(path: '/auth/forgot', builder: (c, s) => const ForgotPasswordScreen()),
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (c, s) => const HomeScreen()),
        GoRoute(path: '/dashboard/admin', builder: (c, s) => const AdminDashboard()),
        GoRoute(path: '/departments/manage', builder: (c, s) => const ManageDepartments()),
        GoRoute(path: '/courses/manage', builder: (c, s) => const ManageCourses()),
        GoRoute(path: '/courses/catalog', builder: (c, s) => const CoursesCatalog()),
        GoRoute(path: '/courses/details', builder: (c, s) => const CourseDetails()),
        GoRoute(path: '/users/trainees', builder: (c, s) => const TraineesManagement()),
        GoRoute(path: '/users/profile', builder: (c, s) => const UserProfile()),
        GoRoute(path: '/support/main', builder: (c, s) => const SupportMain()),
        GoRoute(path: '/support/kb', builder: (c, s) => const KnowledgeBase()),
        GoRoute(path: '/support/chat', builder: (c, s) => const LiveChat()),
        GoRoute(path: '/support/model', builder: (c, s) => const ModelPicker()),
        GoRoute(path: '/reports/dashboard', builder: (c, s) => const ReportsDashboard()),
        GoRoute(path: '/reports/extra', builder: (c, s) => const ExtraCharts()),
        GoRoute(path: '/attendance', builder: (c, s) => const AttendanceScreen()),
      ],
    ),
  ],
);
