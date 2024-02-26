import 'package:flash_news/data/models/article_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ArticleResponseDto', () {
    test('fromJson correctly initializes an ArticleResponseDto from JSON', () {
      // Arrange
      final Map<String, dynamic> json = {
        'status': 'ok',
        'totalResults': 1,
        'articles': [
          {
            'source': {'id': 'source-id', 'name': 'Source Name'},
            'author': 'Author Name',
            'title': 'Article Title',
            'description': 'Article Description',
            'url': 'https://example.com',
            'urlToImage': 'https://example.com/image.jpg',
            'publishedAt': '2020-01-01T00:00:00Z',
            'content': 'Article Content',
          },
        ],
      };

      // Act
      final result = ArticleResponseDto.fromJson(json);

      // Assert
      expect(result.status, 'ok');
      expect(result.totalResults, 1);
      expect(result.articles.length, 1);
      expect(result.articles.first.author, 'Author Name');
      // Continue asserting other fields...
    });

    test('toJson correctly converts an ArticleResponseDto to JSON', () {
      // Arrange
      final articles = [
        ArticleDTO(
          source: 'Source Name',
          author: 'Author Name',
          title: 'Article Title',
          description: 'Article Description',
          url: 'https://example.com',
          urlToImage: 'https://example.com/image.jpg',
          publishedAt: DateTime.parse('2020-01-01T00:00:00Z'),
          content: 'Article Content',
        ),
      ];
      final articleResponseDto = ArticleResponseDto(
        status: 'ok',
        totalResults: 1,
        articles: articles,
      );

      // Act
      final json = articleResponseDto.toJson();

      // Assert
      expect(json['status'], 'ok');
      expect(json['totalResults'], 1);
      expect(json['articles'].length, 1);
      // Verify structure of nested articles...
      expect(json['articles'].first['author'], 'Author Name');
      // Continue asserting other fields...
    });
  });
}
