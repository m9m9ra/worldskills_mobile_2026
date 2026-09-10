import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matule/core/config/brand_colors.dart';
import 'package:matule/core/config/uikit/login/uikit_button_login_yandex.dart';
import 'package:matule/core/config/uikit/menu_category/uikit_menu_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int chipSelectedId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              bottom: 23,
            ),
            child: Text(
              'Добро пожаловать!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight(600)),
            ),
          ),
          UiKitButtonLoginYadex(
            onPressed: () {
              debugPrint('vk');
            },
          ),
          Divider(
            height: 20.0,
          ),
          UiKitMenuCategory(
            category: ['All', 'Популярные', 'Не популярные', 'Популярные'],
            currentIndex: chipSelectedId,
            onPressed: (int item) {
              setState(() {
                chipSelectedId = item;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Войдите, чтобы пользоваться функциями приложения',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: BrandColors.accent,
        backgroundColor: BrandColors.white,
        elevation: 1.0,
        onTap: (int index) {
          debugPrint('BottomNavigationBar: $index');
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(CupertinoIcons.person_crop_circle),
          ),
        ],
      ),
    );
  }
}
