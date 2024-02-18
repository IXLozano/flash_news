import 'package:flash_news/data/models/article_response_dto.dart';

abstract interface class IArticlesDatasource {
  Future<ArticleResponseDto> getArticles({int page = 1});
}
