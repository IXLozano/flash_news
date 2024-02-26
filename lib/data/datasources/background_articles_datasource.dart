import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundArticlesDatasource {
  static Dio? _dio;
  static void configureDio(Dio? dio) {
    _dio = dio;
  }

  static Future<String> fetchArticlesInBackground() async {
    if (_dio == null) {
      throw Exception('Dio not configured. Please call configureDio() first.');
    }
    try {
      final response = await _dio!
          .get('/everything', queryParameters: {'q': 'bitcoin', 'page': 1});
      if (response.statusCode == 200) {
        final String articlesJson = jsonEncode(response.data);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('articles', articlesJson);
        return 'Success'; // Indicates success
      } else {
        // Simple response for non-200 status codes
        return 'Failed: HTTP ${response.statusCode}';
      }
    } catch (e) {
      // Simple response for exceptions
      return 'Error: $e';
    }
  }
}
