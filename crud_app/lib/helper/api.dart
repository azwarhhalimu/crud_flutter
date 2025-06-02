import 'package:dio/dio.dart';

class Api<Response> {
  final dio = Dio();
  static const String baseUrl =
      'https://rnenf-180-251-148-233.a.free.pinggy.link/crud/';
  Api() {
    dio.options.baseUrl = baseUrl;
  }
}
