import 'package:flash_news/config/router/app_router.dart';
import 'package:flash_news/data/datasources/articles_datasource.dart';
import 'package:flash_news/data/datasources/isar_local_articles_datasource.dart';
import 'package:flash_news/data/repositories/articles_repository_impl.dart';
import 'package:flash_news/data/repositories/local_articles_repository_impl.dart';
import 'package:flash_news/domain/datasources/i_articles_datasource.dart';
import 'package:flash_news/domain/datasources/i_local_articles_datasource.dart';
import 'package:flash_news/domain/repositories/i_articles_repository.dart';
import 'package:flash_news/domain/repositories/i_local_articles_repository.dart';
import 'package:go_router/go_router.dart';

class AppFactory {
  static GoRouter getGoRouterConfig() => GoRouterConfig.routerConfig;

  // Isar (Local) Articles Services
  static ILocalArticlesDatasource getLocalArticleDataSource() =>
      IsarLocalArticlesDatasource();

  static ILocalArticlesRepository getLocalArticlesRepository() =>
      LocalArticlesRepositoryImpl(datasource: getLocalArticleDataSource());

  //Articles Services
  static IArticlesDatasource getArticleDatasource() => ArticlesDatasource();

  static IArticlesRepository getArticleRepository() =>
      ArticlesRepositoryImpl(datasource: getArticleDatasource());
}
