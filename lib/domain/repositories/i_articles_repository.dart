import '../entities/article.dart';

abstract interface class IArticlesRepository {
  Future<List<Article>> getArticles({int page = 1});
}
