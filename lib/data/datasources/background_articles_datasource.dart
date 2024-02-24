import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/constants/environment.dart';

class BackgroundArticlesDatasource {
  static Future<String> fetchArticlesInBackground() async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/v2',
        headers: {
          'Authorization': 'Bearer ${Environment.newsApiKey}',
        },
      ),
    );

    try {
      final response = await dio
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
