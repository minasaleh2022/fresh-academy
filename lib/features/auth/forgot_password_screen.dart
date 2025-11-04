import 'package:flutter/material.dart';
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('استعادة كلمة المرور')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: email, decoration: const InputDecoration(labelText: 'البريد الإلكتروني')),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال رابط الاستعادة (تجريبي)')));
            }, child: const Text('إرسال رابط الاستعادة')),
          ],
        ),
      ),
    );
  }
}
