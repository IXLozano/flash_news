import 'package:flash_news/presentation/providers/local_articles_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isArticleFavoriteProvider =
    FutureProvider.family.autoDispose((ref, String articleId) async {
  return await ref
      .watch(localArticlesRepositoryProvider)
      .isArticleFavorite(articleId);
});
