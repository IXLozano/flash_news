import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/articles/layout_screen.dart';

// GoRouterConfig: Manages route configuration for the app.
class GoRouterConfig {
  static final routerConfig = GoRouter(
    initialLocation: '/home/0',
    routes: [
      // Redirects root path '/' to '/home/0'.
      //
      GoRoute(
        path: '/',
        redirect: (_, __) => '/home/0',
      ),

      // Defines a route for '/home/:page' where ':page' is a dynamic segment.
      GoRoute(
        path: '/home/:page',
        builder: (context, state) {
          // Extracts 'page' parameter from the route, defaults to '0'.
          final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
          return LayoutScreen(pageIndex: pageIndex);
        },
      ),
    ],
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => Center(
      child: Text('${state.error}'),
    ),
  );
}
