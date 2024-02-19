import 'package:flash_news/presentation/providers/all_favorite_articles_provider.dart';
import 'package:flash_news/presentation/views/articles/articles_masonry_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    loadNextLocalPage();
  }

  void loadNextLocalPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final localArticles =
        await ref.read(allFavoriteArticlesProvider.notifier).loadNexPage();

    isLoading = false;

    if (localArticles.isEmpty) isLastPage = true;
  }

  @override
  Widget build(BuildContext context) {
    final localFavoritesArticles =
        ref.watch(allFavoriteArticlesProvider).values.toList();

    if (localFavoritesArticles.isEmpty) {
      final colors = Theme.of(context).colorScheme;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.heart_broken_sharp,
              size: 60,
              color: colors.primary,
            ),
            Text(
              'No Favorite Articles',
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => context.go('/home/0'),
              child: const Text('Start adding!'),
            )
          ],
        ),
      );
    }
    return Scaffold(
      body: ArticlesMasonryGridView(
        articles: localFavoritesArticles,
        loadNextPage: loadNextLocalPage,
      ),
    );
  }
}
