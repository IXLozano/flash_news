import '../entities/article.dart';

abstract class ILocalArticlesRepository {
  Future<void> toggleFavorite(Article article);

  Future<bool> isArticleFavorite(String articleId);

  Future<List<Article>> loadLocalArticles({int limit = 10, offset = 0});
}
