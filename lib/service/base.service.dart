import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(baseUrl: 'http://88.225.235.235:8081/api/'));
//final Dio dio = Dio(BaseOptions(baseUrl: 'http://88.225.235.235:8081/api/', headers:{ "X-Api-Key": "emre"}));