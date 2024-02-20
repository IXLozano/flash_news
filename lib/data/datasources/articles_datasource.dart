import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../../domain/datasources/i_articles_datasource.dart';
import '../models/article_response_dto.dart';

class ArticlesDatasource implements IArticlesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org/v2',
      headers: {
        'Authorization': 'Bearer ${Environment.newsApiKey}',
      },
    ),
  );

  @override
  Future<ArticleResponseDto> getArticles({int page = 50}) async {
    final reponse = await dio
        .get('/everything', queryParameters: {'q': 'bitcoin', 'page': page});
    return ArticleResponseDto.fromJson(reponse.data);
  }
}
