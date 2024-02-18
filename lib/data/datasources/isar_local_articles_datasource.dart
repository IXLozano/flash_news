import 'package:flash_news/domain/datasources/i_local_articles_datasource.dart';
import 'package:flash_news/domain/entities/article.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalArticlesDatasource extends ILocalArticlesDatasource {
  late Future<Isar> db;

  IsarLocalArticlesDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([ArticleSchema],
          directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isArticleFavorite(String articleId) async {
    final isar = await db;
    final Article? article =
        await isar.articles.filter().articleIdEqualTo(articleId).findFirst();

    return article != null;
  }

  @override
  Future<List<Article>> loadArticles({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.articles.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(Article article) async {
    final isarDB = await db;
    //final articleId = article.compositeArticleId;
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
  }
}
