import 'package:dio/dio.dart';

class HttpClient {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.example.com', // عدّلها لسيرفرك
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {'Accept': 'application/json'},
  ));
}
