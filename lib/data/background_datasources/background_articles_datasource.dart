import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/constants/environment.dart';

class ArticlesFetcher {
  static Future<void> fetchArticlesInBackground() async {
    print('fetchArticlesInBackground Method------------<');

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
        await prefs.setString(
          'articles',
          articlesJson,
        );
      } else {
        print('Failed to fetch articles');
      }
    } catch (e) {
      print('Error fetching articles in background: $e');
    }
  }
}
