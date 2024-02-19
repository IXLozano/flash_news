import 'package:flash_news/domain/entities/article.dart';
import 'package:flash_news/domain/repositories/i_local_articles_repository.dart';
import 'package:flash_news/presentation/providers/local_articles_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allFavoriteArticlesProvider =
    StateNotifierProvider<AllFavoriteArticlesMapNotifier, Map<String, Article>>(
        (ref) {
  final repository = ref.read(localArticlesRepositoryProvider);
  return AllFavoriteArticlesMapNotifier(repository: repository);
});

class AllFavoriteArticlesMapNotifier
    extends StateNotifier<Map<String, Article>> {
  final ILocalArticlesRepository repository;
  AllFavoriteArticlesMapNotifier({required this.repository}) : super({});

  int page = 0;

  Future<List<Article>> loadNexPage() async {
    final articles =
        await repository.loadLocalArticles(offset: page * 10, limit: 20);

    page++;

    final tempArticlesMap = <String, Article>{};

    for (final article in articles) {
      tempArticlesMap[article.articleId] = article;
    }

    state = {
      ...state,
      ...tempArticlesMap,
    };

    return articles;
  }

  Future<void> toggleFavorite(Article article) async {
    await repository.toggleFavorite(article);
    final bool isArticleFavorite = state[article.articleId] != null;

    if (isArticleFavorite) {
      state.remove(article.articleId);
      state = {...state};
    } else {
      state = {...state, article.articleId: article};
    }
  }
}
