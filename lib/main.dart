import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matule/core/router/router_config_go.dart';
import 'package:matule/layers/data/datasource/local/sqflite_client.dart';

/// v0.0.1+1
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteClient().initDatabase();
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      showSemanticsDebugger: false,
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        primaryColorLight: Colors.black87,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white,
            systemNavigationBarColor: Colors.white, // Change Background color
            systemNavigationBarIconBrightness:
                Brightness.dark, // Change Icon color
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      routerConfig: RouterConfigGo.config,
    );
  }
}
