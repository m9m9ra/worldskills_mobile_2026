import 'package:go_router/go_router.dart';
import 'package:matule/home_screen.dart';
import 'package:matule/main.dart';

class RouterConfigGo {
  RouterConfigGo._();
  static final RouterConfigGo _instance = RouterConfigGo._();
  static RouterConfigGo get instance => _instance;

  static GoRouter get config => GoRouter(
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        branches: [StatefulShellBranch(routes: [])],
      ),
      GoRoute(
        path: '/',
        builder: (context, state) =>
            MyHomePage(title: 'Flutter Demo Home Page'),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
        ],
      ),
    ],
  );
}
