import 'package:dio/dio.dart';
import 'package:flash_news/data/datasources/background_articles_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'background_articles_datasource_test.mocks.dart';

// Generate Mocks
@GenerateMocks([Dio, SharedPreferences])
void main() {
  // Initialize mocks
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockDio = MockDio();
    mockSharedPreferences = MockSharedPreferences();

    // Inject Dio mock
    BackgroundArticlesDatasource.configureDio(mockDio);

    // Mock SharedPreferences setup
    SharedPreferences.setMockInitialValues({});
  });

  group('fetchArticlesInBackground', () {
    final testResponseData = {
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

    test('Success scenario', () async {
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer(
        (_) async => Response<dynamic>(
          data: testResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      final result =
          await BackgroundArticlesDatasource.fetchArticlesInBackground();
      expect(result, 'Success');
    });

    test(
        'fetchArticlesInBackground throws exception when Dio is not configured',
        () async {
      // Ensure Dio is not configured to trigger the exception
      BackgroundArticlesDatasource.configureDio(null);

      // Assert that the method throws an exception
      await expectLater(
        BackgroundArticlesDatasource.fetchArticlesInBackground(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
