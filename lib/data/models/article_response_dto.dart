import 'package:equatable/equatable.dart';

class ArticleResponseDto extends Equatable {
  final String status;
  final int totalResults;
  final List<ArticleDTO> articles;

  const ArticleResponseDto({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ArticleResponseDto.fromJson(Map<String, dynamic> json) =>
      ArticleResponseDto(
        status: json['status'] ?? '',
        totalResults: json['totalResults'] ?? '',
        articles: List<ArticleDTO>.from(
          json['articles'].map((x) => ArticleDTO.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'totalResults': totalResults,
        'articles': List<dynamic>.from(articles.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [status, totalResults, articles];
}

class ArticleDTO extends Equatable {
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime? publishedAt;
  final String content;

  const ArticleDTO({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleDTO.fromJson(Map<String, dynamic> json) => ArticleDTO(
        source: json['source'] != null ? json['source']['name'] : '',
        author: json['author'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        url: json['url'] ?? '',
        urlToImage: json['urlToImage'] ?? '',
        publishedAt: json['publishedAt'].toString().isNotEmpty
            ? DateTime.parse(json['publishedAt'])
            : null,
        content: json['content'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'source': source,
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt':
            publishedAt != null ? publishedAt!.toIso8601String() : '',
        'content': content,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}
