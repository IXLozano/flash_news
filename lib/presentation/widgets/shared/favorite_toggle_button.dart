import 'package:flash_news/domain/entities/article.dart';
import 'package:flash_news/presentation/providers/all_favorite_articles_provider.dart';
import 'package:flash_news/presentation/providers/is_article_favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteToggleButton extends ConsumerWidget {
  final Article article;
  const FavoriteToggleButton({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context, ref) {
    final isArticleFavorite =
        ref.watch(isArticleFavoriteProvider(article.articleId));
    return IconButton(
      onPressed: () async {
        await ref
            .read(allFavoriteArticlesProvider.notifier)
            .toggleFavorite(article);

        ref.invalidate(isArticleFavoriteProvider(article.articleId));
      },
      icon: isArticleFavorite.when(
        data: (isFavorite) {
          return isFavorite
              ? const Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                )
              : const Icon(Icons.favorite_border);
        },
        error: (error, stackTrace) => Tooltip(
          message: 'Error: ${error.toString()}',
          child: const Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
        loading: () => const CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
