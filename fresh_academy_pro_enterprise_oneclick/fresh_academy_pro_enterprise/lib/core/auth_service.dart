import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _kToken = 'jwt_token';
  final Dio dio;
  AuthService(this.dio){
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await getToken();
      if(token != null){
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    }));
  }

  Future<bool> login(String email, String password) async {
    // مثال توضيحي: استبدل الرابط بمخدمك الحقيقي
    try {
      final res = await dio.post('/v1/auth/login', data: {'email': email, 'password': password});
      final token = res.data['token'] as String? ?? 'demo-token';
      final sp = await SharedPreferences.getInstance();
      await sp.setString(_kToken, token);
      return true;
    } catch (_) {
      // للتجربة بدون سيرفر:
      final sp = await SharedPreferences.getInstance();
      await sp.setString(_kToken, 'demo-token');
      return true;
    }
  }

  Future<void> logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kToken);
  }

  Future<String?> getToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_kToken);
  }

  Future<bool> isLoggedIn() async => (await getToken()) != null;
}


import 'rbac.dart';

extension AuthRole on AuthService {
  Future<void> setDemoRole(UserRole role) async {
    await RBAC.setRole(role);
  }
}
