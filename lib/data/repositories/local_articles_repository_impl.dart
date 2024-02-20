import '../../domain/datasources/i_local_articles_datasource.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/i_local_articles_repository.dart';

class LocalArticlesRepositoryImpl extends ILocalArticlesRepository {
  final ILocalArticlesDatasource _datasource;

  LocalArticlesRepositoryImpl({
    required ILocalArticlesDatasource datasource,
  }) : _datasource = datasource;
  @override
  Future<bool> isArticleFavorite(String articleId) {
    return _datasource.isArticleFavorite(articleId);
  }

  @override
  Future<List<Article>> loadLocalArticles({int limit = 10, offset = 0}) {
    return _datasource.loadLocalArticles(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Article article) {
    return _datasource.toggleFavorite(article);
  }
}
