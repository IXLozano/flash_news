import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      ref
          .read(articlesProvider.notifier)
          .loadArticlesSavedByBackgroundProcess();
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
      ),
      body: ArticlesMasonryGridView(
        articles: articles,
        loadNextPage: () => ref.read(articlesProvider.notifier).loadNextPage(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
