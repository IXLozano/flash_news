import 'package:flash_news/data/models/article_response_dto.dart';
import 'package:flash_news/data/repositories/articles_repository_impl.dart';
import 'package:flash_news/domain/datasources/i_articles_datasource.dart';
import 'package:flash_news/domain/entities/article.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'articles_repository_impl_test.mocks.dart';

// Import generated mock

@GenerateMocks([IArticlesDatasource])
void main() {
  late MockIArticlesDatasource mockArticlesDatasource;
  late ArticlesRepositoryImpl articlesRepositoryImpl;

  setUp(() {
    mockArticlesDatasource = MockIArticlesDatasource();
    articlesRepositoryImpl =
        ArticlesRepositoryImpl(datasource: mockArticlesDatasource);
  });

  group('getArticles', () {
    ArticleResponseDto createMockArticleResponseDto() {
      final List<ArticleDTO> articles = [
        ArticleDTO(
          source: 'Test Source',
          author: 'Test Author',
          title: 'Test Title',
          description: 'Test Description',
          url: 'https://example.com',
          urlToImage: 'https://example.com/image.jpg',
          publishedAt: DateTime.now(),
          content: 'Test Content',
        ),
        // Add more articles as needed for your test
      ];

      return ArticleResponseDto(
        status: 'ok',
        totalResults: articles.length,
        articles: articles,
      );
    }

    test('getArticles returns a list of Article entities', () async {
      // Arrange
      const int testPage = 1;
      final ArticleResponseDto mockResponse = createMockArticleResponseDto();

      when(mockArticlesDatasource.getArticles(page: anyNamed('page')))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await articlesRepositoryImpl.getArticles(page: testPage);

      // Assert
      expect(result, isA<List<Article>>());
      expect(
        result.length,
        mockResponse.articles.length,
      ); // Ensure the list size matches
      verify(mockArticlesDatasource.getArticles(page: testPage)).called(1);
    });
  });
}
