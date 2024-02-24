import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/mappers/article_mapper.dart';
import '../../../../data/models/article_response_dto.dart';
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

  Future<void> loadArticlesSavedByBackgroundProcess() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? articlesJson = prefs.getString('articles');
    if (articlesJson != null) {
      // Decode the JSON string into a Map
      final Map<String, dynamic> jsonData = jsonDecode(articlesJson);
      // Access the 'articles' list from the decoded JSON
      final List<dynamic> articlesList = jsonData['articles'];
      // ArticleMapper.fromDtoToEntity takes a Map and returns an Article
      final List<ArticleDTO> articleListDTO = articlesList
          .map((articleJson) => ArticleDTO.fromJson(articleJson))
          .toList();

      final articles =
          articleListDTO.map(ArticleMapper.fromDtoToEntity).toList();

      Future.delayed(const Duration(seconds: 2));

      state = articles;
    }
  }
}
