import 'package:flutter/material.dart';
class UserProfile extends StatelessWidget {
  const UserProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(title: Text('الملف الشخصي')),
      body: Center(child: Text('الملف الشخصي')),
    );
  }
}
