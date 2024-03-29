// Unique identifier for the task
import 'package:dio/dio.dart';
import 'package:workmanager/workmanager.dart';

import '../../data/datasources/background_articles_datasource.dart';
import '../../data/network/dio_client.dart';
import '../constants/environment.dart';

const fetchArticlesTask = 'fetchArticlesTask';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == fetchArticlesTask) {
      BackgroundArticlesDatasource.configureDio(
        DioClient(dio: Dio()).configuredDio(apiKey: Environment.newsApiKey),
      );
      await BackgroundArticlesDatasource.fetchArticlesInBackground();
    }
    return Future.value(true);
  });
}

class BackgroundTaskSetup {
  static void initialize() {
    // Initialize Workmanager
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true, // Set to false in production
    );
  }

  static void registerTask() {
    // Register the periodic task
    Workmanager().registerPeriodicTask(
      'com.example.flashNews',
      fetchArticlesTask,
      frequency:
          const Duration(minutes: 15), // Adjusted to a realistic interval
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }
}
