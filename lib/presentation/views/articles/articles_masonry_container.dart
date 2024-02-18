import 'package:animate_do/animate_do.dart';
import 'package:flash_news/domain/entities/article.dart';
import 'package:flash_news/presentation/views/articles/title_and_description.dart';
import 'package:flutter/material.dart';

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
        onTap: () => {},
        child: FadeIn(
            duration: const Duration(milliseconds: 400),
            delay: const Duration(milliseconds: 250),
            child: TitleAndDescription(article: article, size: size)));
  }
}
