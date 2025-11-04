import 'package:flutter/material.dart';
import '../../widgets_imports.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final email = TextEditingController();
    final nid = TextEditingController();
    final password = TextEditingController();
    final confirm = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextField(controller: name, label: 'الاسم الكامل'),
            const SizedBox(height: 12),
            AppTextField(controller: email, label: 'البريد الإلكتروني', type: TextInputType.emailAddress),
            const SizedBox(height: 12),
            AppTextField(controller: nid, label: 'الرقم القومي', type: TextInputType.number),
            const SizedBox(height: 12),
            AppTextField(controller: password, label: 'كلمة المرور', obscureText: true),
            const SizedBox(height: 12),
            AppTextField(controller: confirm, label: 'تأكيد كلمة المرور', obscureText: true),
            const SizedBox(height: 20),
            AppButton(text: 'إنشاء الحساب', onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إنشاء الحساب (تجريبي)')));
            }, icon: Icons.person_add_alt),
          ],
        ),
      ),
    );
  }
}
