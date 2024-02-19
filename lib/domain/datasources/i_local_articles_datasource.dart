import 'package:flash_news/domain/entities/article.dart';

abstract class ILocalArticlesDatasource {
  Future<void> toggleFavorite(Article article);

  Future<bool> isArticleFavorite(String articleId);

  Future<List<Article>> loadLocalArticles({int limit = 10, offset = 0});
}
