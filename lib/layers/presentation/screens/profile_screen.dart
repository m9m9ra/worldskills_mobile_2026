import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matule/layers/domain/models/settings.dart';
import 'package:matule/layers/domain/provider/settings_provider.dart';
import 'package:matule/layers/domain/usecases/auth_usecase.dart';
import 'package:matule_uikit/widgets/switch/uikit_switch.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';
import 'package:matule_uikit/widgets/font/brand_text_style_light.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static AuthUsecase authUsecase = AuthUsecase();
  static SettingsProvider settingsProvider = SettingsProvider();

  Future<void> onOpenDocument(String uri) async {
    final Uri url = Uri.parse(uri);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Не удалось открыть ссылку: $uri');
    }
  }

  Future<Settings> onChangeNotification(bool notification) async {
    Settings settings = await settingsProvider.getSettings();
    settings.notification = notification;
    setState(() {});
    return await settingsProvider.updateSettings(settings);
  }

  Future<void> onLogout() async {
    authUsecase.logout();
    context.replace('/login');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Divider(height: 32.0, color: Colors.transparent),
          FutureBuilder(
            future: authUsecase.isAuth(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20.0),
                  child: Column(
                    spacing: 8.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${snapshot.data!.firstname}',
                        style: BrandTextStyleLight.title1ExtraBold,
                      ),
                      Text(
                        'afersfsr@dsfsr.ru',
                        style: BrandTextStyleLight.headlineRegular,
                      ),
                    ],
                  ),
                );
              }
              return CupertinoActivityIndicator();
            },
          ),
          Divider(height: 24.0, color: Colors.transparent),
          FutureBuilder(
            future: settingsProvider.getSettings(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Settings settings = snapshot.data!;

                return Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 64.0,
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 20.0,
                              children: [
                                Icon(CupertinoIcons.square_list, size: 32.0),
                                Text(
                                  'Мои заказы',
                                  style: BrandTextStyleLight.title3SemiBold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 64.0,
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 20.0,
                              children: [
                                Icon(CupertinoIcons.gear, size: 32.0),
                                Text(
                                  'Уведомления',
                                  style: BrandTextStyleLight.title3SemiBold,
                                ),
                              ],
                            ),
                            UiKitSwitch(
                              value: settings.notification,
                              onChange: (bool notification) =>
                                  onChangeNotification(notification),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return CupertinoActivityIndicator();
            },
          ),
          Divider(height: 176.0, color: Colors.transparent),
          Column(
            spacing: 24.0,
            children: [
              // todo: remove this later ->
              GestureDetector(
                onTap: () => onOpenDocument('prive_policy.pdf'),
                child: Text(
                  'Политика конфиденциальности',
                  style: BrandTextStyleLight.textMedium,
                ),
              ),
              // todo: remove this later ->
              GestureDetector(
                onTap: () => onOpenDocument('prive_policy.pdf'),
                child: Text(
                  'Пользовательское соглашение',
                  style: BrandTextStyleLight.textMedium,
                ),
              ),
              GestureDetector(
                onTap: onLogout,
                child: Text(
                  'Выход',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight(500),
                    color: BrandColors.error,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
