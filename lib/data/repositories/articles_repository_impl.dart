import '../../domain/datasources/i_articles_datasource.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/i_articles_repository.dart';
import '../mappers/article_mapper.dart';

class ArticlesRepositoryImpl implements IArticlesRepository {
  final IArticlesDatasource _datasource;

  ArticlesRepositoryImpl({required IArticlesDatasource datasource})
      : _datasource = datasource;
  @override
  Future<List<Article>> getArticles({int page = 1}) async {
    final response = await _datasource.getArticles(page: page);
    return response.articles.map(ArticleMapper.fromDtoToEntity).toList();
  }
}
