import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets_imports.dart';
import '../../core/http_client.dart';
import '../../core/auth_service.dart';
import '../../core/rbac.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  String _role = 'admin';

  final _email = TextEditingController();
  final _password = TextEditingController();
  bool loading = false;
  final auth = AuthService(HttpClient.dio);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الدخول')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Image.asset('assets/logo/fresh_logo.webp', height: 72, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const FlutterLogo(size: 72)),
            const SizedBox(height: 24),
            AppTextField(controller: _email, label: 'البريد الإلكتروني', type: TextInputType.emailAddress),
            const SizedBox(height: 12),
            AppTextField(controller: _password, label: 'كلمة المرور', obscureText: true),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _role,
              items: const [
                DropdownMenuItem(value: 'admin', child: Text('مدير')),
                DropdownMenuItem(value: 'trainer', child: Text('مدرب')),
                DropdownMenuItem(value: 'trainee', child: Text('متدرب')),
              ],
              onChanged: (v)=> setState(()=> _role = v ?? 'trainee'),
              decoration: const InputDecoration(labelText: 'الدور (للتجربة)'),
            ),
            const SizedBox(height: 12),
            Align(alignment: Alignment.centerLeft, child: TextButton(onPressed: ()=> context.push('/auth/forgot'), child: const Text('نسيت كلمة المرور؟'))),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: loading? null : () async {
                setState(()=> loading = true);
                try {
                  final ok = await auth.login(_email.text.trim(), _password.text); await auth.setDemoRole(_role=='admin'? UserRole.admin : _role=='trainer'? UserRole.trainer : UserRole.trainee);
                  if(ok) context.go('/home');
                } finally {
                  setState(()=> loading = false);
                }
              },
              child: Text(loading? '...جاري' : 'تسجيل الدخول'),
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: ()=> context.push('/auth/register'), child: const Text('إنشاء حساب جديد')),
          ],
        ),
      ),
    );
  }
}
