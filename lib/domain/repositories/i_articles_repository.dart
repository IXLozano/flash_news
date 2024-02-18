import 'package:flash_news/domain/entities/article.dart';

abstract interface class IArticlesRepository {
  Future<List<Article>> getArticles({int page = 1});
}
