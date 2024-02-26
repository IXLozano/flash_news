import 'package:flash_news/data/repositories/local_articles_repository_impl.dart';
import 'package:flash_news/domain/datasources/i_local_articles_datasource.dart';
import 'package:flash_news/domain/entities/article.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_articles_repository_impl_test.mocks.dart';

@GenerateMocks([ILocalArticlesDatasource])
void main() {
  late MockILocalArticlesDatasource mockLocalArticlesDatasource;
  late LocalArticlesRepositoryImpl localArticlesRepositoryImpl;

  setUp(() {
    mockLocalArticlesDatasource = MockILocalArticlesDatasource();
    localArticlesRepositoryImpl =
        LocalArticlesRepositoryImpl(datasource: mockLocalArticlesDatasource);
  });

  test('isArticleFavorite returns correct value', () async {
    const articleId = 'test-id';
    when(mockLocalArticlesDatasource.isArticleFavorite(articleId))
        .thenAnswer((_) async => true);

    final result =
        await localArticlesRepositoryImpl.isArticleFavorite(articleId);

    expect(result, true);
    verify(mockLocalArticlesDatasource.isArticleFavorite(articleId)).called(1);
  });

  test('loadLocalArticles returns a list of articles', () async {
    final List<Article> testArticles = List.generate(
      3,
      (index) => Article(
        articleId: 'article-$index',
        source: 'Test Source $index',
        author: 'Test Author $index',
        title: 'Test Title $index',
        description: 'This is a test description for article $index.',
        url: 'https://example.com/test-article-$index',
        urlToImage: 'https://example.com/test-image-$index.jpg',
        publishedAt: DateTime.now().subtract(Duration(days: index)),
        content:
            'This is the content of test article $index, used for testing.',
      ),
    );
    when(mockLocalArticlesDatasource.loadLocalArticles(limit: 10, offset: 0))
        .thenAnswer((_) async => testArticles);

    final result = await localArticlesRepositoryImpl.loadLocalArticles();

    expect(result, equals(testArticles));
    verify(mockLocalArticlesDatasource.loadLocalArticles(limit: 10, offset: 0))
        .called(1);
  });

  test('toggleFavorite calls datasource method', () async {
    final testArticle = Article(
      articleId: 'test-id',
      source: 'Test Source',
      author: 'Test Author',
      title: 'Test Title',
      description: 'Test Description',
      url: 'https://example.com',
      urlToImage: 'https://example.com/image.jpg',
      publishedAt: DateTime.now(),
      content: 'Test Content',
    );
    // Assuming toggleFavorite does not return a value
    when(mockLocalArticlesDatasource.toggleFavorite(testArticle))
        .thenAnswer((_) async => {});

    await localArticlesRepositoryImpl.toggleFavorite(testArticle);

    verify(mockLocalArticlesDatasource.toggleFavorite(testArticle)).called(1);
  });
}
