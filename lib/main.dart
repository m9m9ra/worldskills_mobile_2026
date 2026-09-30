import 'package:flutter/material.dart';
import 'package:matule/core/router/router_config_go.dart';
import 'package:matule/layers/data/datasource/local/sqflite_client.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';

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
      title: 'Matule 2026',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: BrandColors.accent),
      ),
      routerConfig: RouterConfigGo.config,
    );
  }
}
