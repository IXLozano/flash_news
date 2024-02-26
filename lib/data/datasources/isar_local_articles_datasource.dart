import 'package:isar/isar.dart';

import '../../config/database/i_database_manager.dart';
import '../../domain/datasources/i_local_articles_datasource.dart';
import '../../domain/entities/article.dart';

class IsarLocalArticlesDatasource extends ILocalArticlesDatasource {
  final IDatabaseManager isarDB;

  IsarLocalArticlesDatasource({required this.isarDB});

  @override
  Future<bool> isArticleFavorite(String articleId) async {
    try {
      final db = await isarDB.getDatabase();
      final Article? article =
          await db.articles.filter().articleIdEqualTo(articleId).findFirst();

      return article != null;
    } catch (e) {
      throw Exception('Error checking article favorite status');
    }
  }

  @override
  Future<List<Article>> loadLocalArticles({int limit = 10, offset = 0}) async {
    try {
      final db = await isarDB.getDatabase();
      return db.articles.where().offset(offset).limit(limit).findAll();
    } catch (e) {
      throw Exception('Error loading local articles');
    }
  }

  @override
  Future<void> toggleFavorite(Article article) async {
    try {
      final db = await isarDB.getDatabase();
      final favoriteArticle = await db.articles
          .filter()
          .articleIdEqualTo(article.articleId)
          .findFirst();
      if (favoriteArticle != null) {
        // Delete Article From Favorites
        await db.writeTxn(() => db.articles.delete(favoriteArticle.isarId!));
      } else {
        // Insert Article To Favorites
        await db.writeTxn(() => db.articles.put(article));
      }
    } catch (e) {
      throw Exception('Error toggling favorite status');
    }
  }
}
