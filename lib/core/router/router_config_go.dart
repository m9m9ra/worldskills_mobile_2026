import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matule/layers/presentation/home_screen.dart';
import 'package:matule/layers/presentation/root_screen/view/root_screen.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';
import 'package:matule_uikit/widgets/font/brand_text_style_light.dart';

class RouterConfigGo {
  RouterConfigGo._();
  static final RouterConfigGo _instance = RouterConfigGo._();
  static RouterConfigGo get instance => _instance;

  static GoRouter get config => GoRouter(
    initialLocation: '/home',
    redirectLimit: 8,
    redirect: (context, state) {
      return null;
    },
    onException: (context, state, router) {
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
                path: '/profile',
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
