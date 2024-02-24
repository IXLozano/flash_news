import 'package:flutter/services.dart';

import '../data/background_datasources/background_articles_datasource.dart';

class MethodChannelSetup {
  static const MethodChannel channel =
      MethodChannel('com.flashNews.backgroundfetch');

  static void setupChannel() {
    channel.setMethodCallHandler((call) async {
      if (call.method == 'backgroundFetch') {
        await ArticlesFetcher.fetchArticlesInBackground();
        print('IOS Background proccess Fetched new data');
        return true; // Return true if new data was fetched, false otherwise
      }
      print('IOS Background DID NOT proccess Fetched new data');

      return false;
    });
  }
}
