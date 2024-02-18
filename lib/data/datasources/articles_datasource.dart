import 'package:dio/dio.dart';
import 'package:flash_news/config/constants/environment.dart';
import 'package:flash_news/data/models/article_response_dto.dart';
import 'package:flash_news/domain/datasources/i_articles_datasource.dart';

class ArticlesDatasource implements IArticlesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org/v2',
      queryParameters: {
        'apiKey': Environment.newsApiKey,
      },
    ),
  );

  @override
  Future<ArticleResponseDto> getArticles({int page = 1}) async {
    final reponse = await dio.get('/top-headlines',
        queryParameters: {'country': 'de', 'category': 'business'});
    return ArticleResponseDto.fromJson(reponse.data);
  }
}
