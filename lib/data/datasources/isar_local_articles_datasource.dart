import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/datasources/i_local_articles_datasource.dart';
import '../../domain/entities/article.dart';

class IsarLocalArticlesDatasource extends ILocalArticlesDatasource {
  late Future<Isar> db;

  IsarLocalArticlesDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    try {
      if (Isar.instanceNames.isEmpty) {
        final dir = await getApplicationDocumentsDirectory();
        return await Isar.open(
          [ArticleSchema],
          directory: dir.path,
          inspector: true,
        );
      }
      return Future.value(Isar.getInstance());
    } catch (e) {
      throw Exception('Failed to open Isar database');
    }
  }

  @override
  Future<bool> isArticleFavorite(String articleId) async {
    try {
      final isarDB = await db;
      final Article? article = await isarDB.articles
          .filter()
          .articleIdEqualTo(articleId)
          .findFirst();

      return article != null;
    } catch (e) {
      throw Exception('Error checking article favorite status');
    }
  }

  @override
  Future<List<Article>> loadLocalArticles({int limit = 10, offset = 0}) async {
    try {
      final isarDB = await db;
      return isarDB.articles.where().offset(offset).limit(limit).findAll();
    } catch (e) {
      throw Exception('Error loading local articles');
    }
  }

  @override
  Future<void> toggleFavorite(Article article) async {
    try {
      final isarDB = await db;
      final favoriteArticle = await isarDB.articles
          .filter()
          .articleIdEqualTo(article.articleId)
          .findFirst();
      if (favoriteArticle != null) {
        // Delete Article From Favorites
        await isarDB
            .writeTxn(() => isarDB.articles.delete(favoriteArticle.isarId!));
      } else {
        // Insert Article To Favorites
        await isarDB.writeTxn(() => isarDB.articles.put(article));
      }
    } catch (e) {
      throw Exception('Error toggling favorite status');
    }
  }
}
