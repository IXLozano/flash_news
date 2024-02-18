import 'package:flash_news/domain/entities/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FaforitesToggleButton extends ConsumerWidget {
  final Article article;
  const FaforitesToggleButton({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context, ref) {
    //final isArticleFavorite = ref.watch(provider)
    return const Placeholder();
  }
}
