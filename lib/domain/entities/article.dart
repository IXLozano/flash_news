import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';

part 'article.g.dart';

@collection
class Article {
  Id? isarId;
  late final String articleId;
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime? publishedAt;
  final String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  }) {
    final idRaw = '$title$url$publishedAt';
    articleId = sha256.convert(utf8.encode(idRaw)).toString();
  }
}
