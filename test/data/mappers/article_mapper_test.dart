import 'package:flash_news/data/mappers/article_mapper.dart';
import 'package:flash_news/data/models/article_response_dto.dart';
import 'package:flash_news/domain/entities/article.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ArticleMapper', () {
    test('should correctly map from ArticleDTO to Article entity', () {
      // Arrange
      final ArticleDTO dto = ArticleDTO(
        source: 'Test Source',
        author: 'Test Author',
        title: 'Test Title',
        description: 'Test Description',
        url: 'Test URL',
        urlToImage: 'Test URL to Image',
        publishedAt: DateTime.parse('2020-01-01T00:00:00Z'),
        content: 'Test Content',
      );

      // Act
      final Article entity = ArticleMapper.fromDtoToEntity(dto);

      // Assert
      expect(entity.source, dto.source);
      expect(entity.author, dto.author);
      expect(entity.title, dto.title);
      expect(entity.description, dto.description);
      expect(entity.url, dto.url);
      expect(entity.urlToImage, dto.urlToImage);
      expect(entity.publishedAt, dto.publishedAt);
      expect(entity.content, dto.content);

      // Verify articleId is generated (since it's a UUID, checking for non-null
      // and format can be a basic validation)
      expect(entity.articleId, isNotNull);
      expect(entity.articleId, isA<String>());
    });
  });
}
