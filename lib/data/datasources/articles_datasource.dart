import 'package:dio/dio.dart';

import '../../domain/datasources/i_articles_datasource.dart';
import '../models/article_response_dto.dart';

class ArticlesDatasource implements IArticlesDatasource {
  final Dio _dio;
  ArticlesDatasource({required Dio dio}) : _dio = dio;

  @override
  Future<ArticleResponseDto> getArticles({int page = 1}) async {
    try {
      final response = await _dio
          .get('/everything', queryParameters: {'q': 'bitcoin', 'page': page});
      if (response.statusCode == 200) {
        return ArticleResponseDto.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to fetch articles',
        ); // Throw an exception for testing
      }
    } catch (e) {
      throw Exception(
        'Error fetching articles',
      ); // Throw an exception for testing
    }
  }
}
