import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = Dio();
  //10.0.2.2
  //192.168.1.36
  //192.168.137.1
  //192.168.137.1
  dio.options.baseUrl = 'http://192.168.137.1:8000/api/v1';
  dio.options.headers['Accept'] = 'Application/Json';
  return dio;
}
