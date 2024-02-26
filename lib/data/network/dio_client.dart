import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient({required Dio? dio}) : dio = dio ?? Dio();

  Dio configuredDio({required String apiKey}) {
    dio.options = BaseOptions(
      baseUrl: 'https://newsapi.org/v2',
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );
    return dio;
  }
}
