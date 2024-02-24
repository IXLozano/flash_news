import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'config/factories/app_factory.dart';
import 'config/platform_channels/method_channel_setup.dart';
import 'config/tasks/background_task_setup.dart';
import 'config/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  BackgroundTaskSetup.initialize();
  BackgroundTaskSetup.registerTask();
  MethodChannelSetup.setupChannel();

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
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
