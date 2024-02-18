import 'package:flash_news/config/router/app_router.dart';
import 'package:flash_news/data/datasources/isar_local_articles_datasource.dart';
import 'package:flash_news/data/repositories/local_articles_repository_impl.dart';
import 'package:flash_news/domain/datasources/i_local_articles_datasource.dart';
import 'package:flash_news/domain/repositories/i_local_articles_repository.dart';
import 'package:go_router/go_router.dart';

class AppFactory {
  static GoRouter getGoRouterConfig() => GoRouterConfig.routerConfig;

  // Isar objects
  static ILocalArticlesDatasource getDataSource() =>
      IsarLocalArticlesDatasource();

  static ILocalArticlesRepository getLocalArticlesRepository() =>
      LocalArticlesRepositoryImpl(datasource: getDataSource());
}
