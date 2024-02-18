import 'package:flash_news/presentation/screens/articles/layout_screen.dart';
import 'package:go_router/go_router.dart';

// GoRouterConfig: Manages route configuration for the app.
class GoRouterConfig {
  static GoRouter get routerConfig => GoRouter(
        initialLocation: '/home/0',
        routes: [
          // Redirects root path '/' to '/home/0'.
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
          )
        ],
      );
}
