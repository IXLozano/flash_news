import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/mappers/article_mapper.dart';
import '../../../data/models/article_response_dto.dart';
import '../../../domain/entities/article.dart';
import 'articles_masonry_grid_view.dart';
import 'providers/articles_provider.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //loadData();
    ref.read(articlesProvider.notifier).loadNextPage();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final articles = ref.watch(articlesProvider);

    if (articles.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flash News'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: ArticlesMasonryGridView(
        articles: articles,
        loadNextPage: () => ref.read(articlesProvider.notifier).loadNextPage(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? articlesJson = prefs.getString('articles');
    if (articlesJson != null) {
      final List<ArticleDTO> decodedJson = jsonDecode(articlesJson);
      // Assuming you have a method to convert JSON to Article objects
      final List<Article> articles =
          decodedJson.map(ArticleMapper.fromDtoToEntity).toList();
      ref.read(articlesProvider.notifier).updateArticles(articles);
    }
  }
}
