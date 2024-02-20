import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:workmanager/workmanager.dart';

import 'config/factories/app_factory.dart';
import 'config/theme/app_theme.dart';
import 'data/background_datasources/background_articles_datasource.dart';

// Unique identifier for the task
const fetchArticlesTask = 'fetchArticlesTask';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    print('callbackDispatcher Background Process Trigered------------<');
    if (taskName == fetchArticlesTask) {
      print('Android Background Process Trigered------------<');
      await ArticlesFetcher.fetchArticlesInBackground();
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize Workmanager
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true, // Set to false in production
  );

  // Register the periodic task
  Workmanager().registerPeriodicTask(
    'com.example.flashNews',
    fetchArticlesTask,
    frequency: const Duration(seconds: 6), // Adjusted to a realistic interval
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );

  // Set up a method channel for iOS background fetch
  setupMethodChannel();
}

void setupMethodChannel() {
  const MethodChannel channel = MethodChannel('com.flashNews.backgroundfetch');
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('en', null);
    final routerConfig = AppFactory.getGoRouterConfig();
    final theme = AppTheme().getTheme();

    return MaterialApp.router(
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
      theme: theme,
    );
  }
}
