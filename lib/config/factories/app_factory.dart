import 'package:go_router/go_router.dart';

import '../../data/datasources/articles_datasource.dart';
import '../../data/datasources/isar_local_articles_datasource.dart';
import '../../data/repositories/articles_repository_impl.dart';
import '../../data/repositories/local_articles_repository_impl.dart';
import '../../domain/datasources/i_articles_datasource.dart';
import '../../domain/datasources/i_local_articles_datasource.dart';
import '../../domain/repositories/i_articles_repository.dart';
import '../../domain/repositories/i_local_articles_repository.dart';
import '../router/app_router.dart';

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
