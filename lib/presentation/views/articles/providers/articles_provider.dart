import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/article.dart';
import '../../../providers/articles_repository_provider.dart';

final articlesProvider =
    StateNotifierProvider<ArticlesNotifier, List<Article>>((ref) {
  final repoFunction = ref.read(articlesRepositoryProvider).getArticles;
  return ArticlesNotifier(articleRepositoryFunction: repoFunction);
});

typedef ArticleRepositoryFunction = Future<List<Article>> Function({int page});

class ArticlesNotifier extends StateNotifier<List<Article>> {
  final ArticleRepositoryFunction articleRepositoryFunction;
  int currentPage = 0;
  bool isLoading = false;
  ArticlesNotifier({required this.articleRepositoryFunction}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    final List<Article> articles =
        await articleRepositoryFunction(page: currentPage);
    state = [...state, ...articles];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  void updateArticles(List<Article> newArticles) {
    state = newArticles;
  }
}
