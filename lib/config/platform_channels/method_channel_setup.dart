import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../../data/datasources/background_articles_datasource.dart';
import '../../data/network/dio_client.dart';
import '../constants/environment.dart';

class MethodChannelSetup {
  static const MethodChannel channel =
      MethodChannel('com.flashNews.backgroundfetch');

  static void setupChannel() {
    channel.setMethodCallHandler((call) async {
      if (call.method == 'backgroundFetch') {
        // Configure Dio before using it in the background fetch process
        BackgroundArticlesDatasource.configureDio(
          DioClient(dio: Dio()).configuredDio(apiKey: Environment.newsApiKey),
        );

        // Attempt to fetch articles in the background
        final String result =
            await BackgroundArticlesDatasource.fetchArticlesInBackground();

        // Log the outcome and return true if successful
        if (result == 'Success') {
          print('iOS Background process fetched new data successfully.');
          return true;
        } else {
          print('iOS Background process failed: $result');
        }
      } else {
        print(
          'Unrecognized method call received by iOS background fetch channel.',
        );
      }

      return false;
    });
  }
}
