import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class BottomNav extends StatefulWidget {
  const BottomNav({super.key});
  @override
  State<BottomNav> createState() => _BottomNavState();
}
class _BottomNavState extends State<BottomNav> {
  static const routes = ['/home','/courses/catalog','/support/main','/reports/dashboard','/users/profile'];
  int indexFromLocation(String loc) {
    for (int i=0;i<routes.length;i++){ if (loc.startsWith(routes[i])) return i; }
    return 0;
  }
  @override
  Widget build(BuildContext context) {
    final loc = GoRouter.of(context).location;
    final currentIndex = indexFromLocation(loc);
    return NavigationBar(
      selectedIndex: currentIndex,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
        NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'الدورات'),
        NavigationDestination(icon: Icon(Icons.build_outlined), label: 'الدعم'),
        NavigationDestination(icon: Icon(Icons.bar_chart_outlined), label: 'التقارير'),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'الملف'),
      ],
      onDestinationSelected: (i) => context.go(routes[i]),
    );
  }
}
