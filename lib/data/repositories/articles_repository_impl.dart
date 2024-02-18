import 'package:flash_news/data/mappers/article_mapper.dart';
import 'package:flash_news/domain/datasources/i_articles_datasource.dart';
import 'package:flash_news/domain/entities/article.dart';
import 'package:flash_news/domain/repositories/i_articles_repository.dart';

class ArticlesRepositoryImpl implements IArticlesRepository {
  final IArticlesDatasource _datasource;

  ArticlesRepositoryImpl({required IArticlesDatasource datasource})
      : _datasource = datasource;
  @override
  Future<List<Article>> getArticles({int page = 1}) async {
    final response = await _datasource.getArticles();
    return response.articles.map(ArticleMapper.fromDtoToEntity).toList();
  }
}
