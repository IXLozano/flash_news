import 'package:flash_news/presentation/views/articles/articles_masonry_grid_view.dart';
import 'package:flash_news/presentation/views/articles/providers/articles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    ref.read(topHeadlinesArticles.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final articles = ref.watch(topHeadlinesArticles);

    if (articles.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    return Scaffold(
        body: ArticlesMasonryGridView(
      articles: articles,
      loadNextPage: () =>
          ref.read(topHeadlinesArticles.notifier).loadNextPage(),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
