import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local_articles_repository_provider.dart';

final isArticleFavoriteProvider =
    FutureProvider.family.autoDispose((ref, String articleId) async {
  return await ref
      .watch(localArticlesRepositoryProvider)
      .isArticleFavorite(articleId);
});
