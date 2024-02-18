import 'package:flash_news/domain/entities/article.dart';
import 'package:flash_news/presentation/providers/articles_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final topHeadlinesArticles =
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
}
