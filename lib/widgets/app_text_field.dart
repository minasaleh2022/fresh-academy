import 'package:flutter/material.dart';
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? type;
  final bool obscureText;
  const AppTextField({super.key, required this.controller, required this.label, this.type, this.obscureText=false});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: type,
      obscureText: obscureText,
      decoration: InputDecoration(labelText: label),
    );
  }
}
