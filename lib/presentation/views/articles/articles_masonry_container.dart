import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/article.dart';
import 'article_card.dart';

class ArticleMasonryContainer extends StatelessWidget {
  final Article article;
  const ArticleMasonryContainer({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => {}, //Article View implementation missing
      child: FadeIn(
        duration: const Duration(milliseconds: 400),
        delay: const Duration(milliseconds: 250),
        child: ArticleCard(article: article, size: size),
      ),
    );
  }
}
