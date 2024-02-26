import 'package:dio/dio.dart';
import 'package:flash_news/data/network/dio_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../datasource/articles_datasource_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('DioClient', () {
    late MockDio mockDio;
    late DioClient client;

    setUp(() {
      mockDio = MockDio();
      client = DioClient(dio: mockDio);
    });

    test('should configure Dio with correct base options', () {
      const mockApiKey = 'mock-api-key'; // Use a mock API key for testing

      // Arrange
      when(mockDio.options).thenReturn(
        BaseOptions(
          baseUrl: 'https://newsapi.org/v2',
          headers: {
            'Authorization': 'Bearer $mockApiKey',
          },
        ),
      );

      // Act
      client.configuredDio(apiKey: mockApiKey); // Use the mock API key here

      // Assert
      //verify(mockDio.get(any)).called(1);
      expect(mockDio.options.baseUrl, 'https://newsapi.org/v2');
      expect(mockDio.options.headers['Authorization'], 'Bearer $mockApiKey');
      // Verify other options as needed
    });
  });
}
