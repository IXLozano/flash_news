import 'package:flash_news/domain/entities/article.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Article Entity', () {
    test('should correctly initialize with provided values', () {
      final DateTime testDate = DateTime(2022, 01, 01);
      final Article article = Article(
        articleId: '123',
        source: 'Test Source',
        author: 'Test Author',
        title: 'Test Title',
        description: 'Test Description',
        url: 'https://testurl.com',
        urlToImage: 'https://testurl.com/image.jpg',
        publishedAt: testDate,
        content: 'Test Content',
      );

      // Verify the properties are correctly assigned
      expect(article.articleId, '123');
      expect(article.source, 'Test Source');
      expect(article.author, 'Test Author');
      expect(article.title, 'Test Title');
      expect(article.description, 'Test Description');
      expect(article.url, 'https://testurl.com');
      expect(article.urlToImage, 'https://testurl.com/image.jpg');
      expect(article.publishedAt, testDate);
      expect(article.content, 'Test Content');
    });
  });
}
