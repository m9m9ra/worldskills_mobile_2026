import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matule/layers/domain/models/settings.dart';
import 'package:matule/layers/domain/provider/settings_provider.dart';
import 'package:matule/layers/domain/usecases/auth_usecase.dart';
import 'package:matule/layers/presentation/screens/auth/login_screen.dart';
import 'package:matule/layers/presentation/screens/auth/password_screen.dart';
import 'package:matule/layers/presentation/screens/auth/pincode_create_screen.dart';
import 'package:matule/layers/presentation/screens/auth/pincode_screen.dart';
import 'package:matule/layers/presentation/screens/auth/signin_screen.dart';
import 'package:matule/layers/presentation/screens/error_screen.dart/error_screen.dart';
import 'package:matule/layers/presentation/screens/home_screen.dart';
import 'package:matule/layers/presentation/screens/product_screen.dart';
import 'package:matule/layers/presentation/screens/profile_screen.dart';
import 'package:matule/layers/presentation/screens/project_create_screen.dart';
import 'package:matule/layers/presentation/screens/project_screen.dart';
import 'package:matule/layers/presentation/screens/root_screen/view/root_screen.dart';
import 'package:matule_api/models.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';
import 'package:matule_uikit/widgets/font/brand_text_style_light.dart';

class RouterConfigGo {
  RouterConfigGo._();
  static final RouterConfigGo _instance = RouterConfigGo._();
  static RouterConfigGo get instance => _instance;

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static bool isInit = false;

  static GoRouter get config => GoRouter(
    initialLocation: kDebugMode ? '/home' : '/login',
    redirectLimit: 3,
    navigatorKey: rootNavigatorKey,
    redirect: (context, state) async {
      if (!isInit) {
        isInit = true;
        AuthUsecase authUsecase = AuthUsecase();
        User? user = await authUsecase.isAuth();
        if (user != null) {
          Settings settings = await SettingsProvider().getSettings();
          debugPrint(settings.toMap().toString());
          if (settings.code == null) {
            return '/pincode_create';
          }
          return '/pincode';
        }
        return '/login';
      }
      return null;
    },
    onException: (context, state, router) {
      final currentContext = rootNavigatorKey.currentContext;

      if (currentContext == null) {
        router.push('/error');
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        snackBarAnimationStyle: AnimationStyle(curve: Curves.easeOut),
        SnackBar(
          // margin: EdgeInsets.all(10),
          backgroundColor: BrandColors.white,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8.0),
          ),
          content: Container(
            width: 375,
            height: 80.0,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(color: BrandColors.white),
            child: Text(
              'Произошла ошибка\nНу вот опять',
              style: BrandTextStyleLight.title2ExtraBold,
            ),
          ),
        ),
      );
    },
    routes: [
      // Internal routring -> after auth
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            RootScreen(statefulNavigationShell: navigationShell),
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
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/product',
                builder: (context, state) => ProductScreen(),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/project',
                builder: (context, state) => ProjectScreen(),
                routes: [
                  GoRoute(
                    path: '/create',
                    builder: (context, state) => ProjectCreateScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => ProfileScreen(),
                routes: [],
              ),
            ],
          ),
        ],
      ),

      // external routring -> non auth user
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
        routes: [
          GoRoute(
            path: '/signin',
            builder: (context, state) => SigninScreen(),
            routes: [
              GoRoute(
                path: '/password',
                builder: (context, state) =>
                    PasswordScreen(extraEmail: state.extra as String),
                routes: [],
              ),
            ],
          ),
        ],
      ),

      // external shared
      GoRoute(
        path: '/pincode',
        builder: (context, state) => PincodeScreen(),
        routes: [],
      ),
      GoRoute(
        path: '/pincode_create',
        builder: (context, state) => PincodeCreateScreen(),
        routes: [],
      ),
      GoRoute(
        path: '/error',
        builder: (context, state) => ErrorScreen(),
        routes: [],
      ),

      // stack screen will be opened over shell branch
    ],
  );
}
