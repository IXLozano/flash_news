// Step 1: Create a Mock class for Dio
import 'package:dio/dio.dart';
import 'package:flash_news/data/datasources/articles_datasource.dart';
import 'package:flash_news/data/models/article_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'articles_datasource_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late ArticlesDatasource articlesDatasource;

  setUp(() {
    mockDio = MockDio();
    articlesDatasource = ArticlesDatasource(dio: mockDio);
  });

  group('getArticles', () {
    const testPage = 1;
    final mockResponseData = {
      'status': 'ok',
      'totalResults': 1,
      'articles': [
        {
          'source': {
            'id': null,
            'name': 'ExampleSource',
          },
          'author': 'Test Author',
          'title': 'Test Article',
          'description': 'This is a test article description.',
          'url': 'https://example.com/article',
          'urlToImage': 'https://example.com/image.jpg',
          'publishedAt':
              '2024-02-25T12:34:56Z', // Use ISO 8601 format for datetime
          'content': 'This is the content of the test article.',
        },
      ],
    };
    final articleResponseDto = ArticleResponseDto.fromJson(mockResponseData);

    test('should return ArticleResponseDto on successful response', () async {
      // Arrange
      when(
        mockDio.get(
          '/everything',
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response<dynamic>(
          data: mockResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final result = await articlesDatasource.getArticles(page: testPage);

      // Assert
      expect(result, equals(articleResponseDto));
      verify(
        mockDio.get(
          '/everything',
          queryParameters: {'q': 'bitcoin', 'page': testPage},
        ),
      );
    });

    test('should throw an exception when the response code is not 200', () {
      // Arrange
      when(
        mockDio.get(
          '/endpoint',
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response<dynamic>(
          data: 'Something went wrong',
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act & Assert
      expect(
        () async => await articlesDatasource.getArticles(page: testPage),
        throwsException,
      );
    });
  });
}
