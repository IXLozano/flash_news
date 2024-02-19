import 'package:flash_news/domain/entities/article.dart';
import 'package:flash_news/presentation/views/articles/articles_masonry_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ArticlesMasonryGridView extends StatefulWidget {
  final List<Article> articles;
  final VoidCallback? loadNextPage;

  const ArticlesMasonryGridView({
    super.key,
    required this.articles,
    this.loadNextPage,
  });

  @override
  State<ArticlesMasonryGridView> createState() =>
      _ArticlesMasonryGridViewState();
}

class _ArticlesMasonryGridViewState extends State<ArticlesMasonryGridView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      // if the current scroll position + 100 pixels,
      // is greater than the max bottom limit,
      // then ask for more articles
      if (scrollController.position.pixels + 100 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.articles.length,
        itemBuilder: (context, index) {
          return ArticleMasonryContainer(
            article: widget.articles[index],
          );
        },
      ),
    );
  }
}
