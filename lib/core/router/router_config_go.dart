import 'package:go_router/go_router.dart';
import 'package:matule/layers/presentation/home_screen.dart';
import 'package:matule/layers/presentation/root_screen/view/root_screen.dart';

class RouterConfigGo {
  RouterConfigGo._();
  static final RouterConfigGo _instance = RouterConfigGo._();
  static RouterConfigGo get instance => _instance;

  static GoRouter get config => GoRouter(
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => RootScreen(statefulNavigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => HomeScreen(),
                routes: [],
              ),
            ],
          ),
        ],
      ),
      
      GoRoute(
        path: '/signin',
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) => HomeScreen(),
            routes: [
              GoRoute(
                path: '/password',
                builder: (context, state) => HomeScreen(),
                routes: [
                  GoRoute(
                    path: '/pincode',
                    builder: (context, state) => HomeScreen(),
                    routes: [],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => HomeScreen(),
        routes: [],
      ),
    ],
  );
}
