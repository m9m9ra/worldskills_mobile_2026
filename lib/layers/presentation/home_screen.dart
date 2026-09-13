import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matule/core/config/brand_colors.dart';
import 'package:matule/core/config/uikit/bottom_sheet/uikit_bottom_sheet.dart';
import 'package:matule/core/config/uikit/card/uikit_card_base.dart';
import 'package:matule/core/config/uikit/counter/uikit_counter.dart';
import 'package:matule/core/config/uikit/input/uikit_input.dart';
import 'package:matule/core/config/uikit/login/uikit_button_login_yandex.dart';
import 'package:matule/core/config/uikit/menu_category/uikit_menu_category.dart';
import 'package:matule/core/config/uikit/search/uikit_search.dart';
import 'package:matule/core/config/uikit/switch/uikit_switch.dart';
import 'package:matule/core/config/uikit/uikit_button_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int chipSelectedId = 0;
  bool switchState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 12.0),
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
          UiKitSearchInput(),
          SizedBox(height: 10),
          UiKitInput(isPassword: false),

          SizedBox(height: 10),
          Row(
            children: [UiKitCounter(onMinusTap: () {}, onPlusTap: () {})],
          ),
          UiKitSwitch(
            value: switchState,
            onChange: (bool value) {
              setState(() {
                switchState = value;
              });
            },
          ),
          UiKitButtonLoginYadex(
            onPressed: () => {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return UiKitBottomSheet(children: []);
                },
              ),
            },
          ),
          UiKitCard(child: Column(), onCardTap: () {}),
          UiKitCard.primary(
            onCardTap: () {},
            onPrimaryButtonTap: () {},
            title: 'Рубашка Воскресенье для машинного вязания',
            subTitle: 'Мужская одежда',
            price: 300,
            buttonText: 'Добавить',
            uikitButtonState: UikitButtonState.secondary,
          ),
          UiKitCard.cart(
            onCardTap: () {},
            title: 'Рубашка Воскресенье для машинного вязания',
            price: 300,
            count: 10,
            onCloseTap: () {},
            onPlusTap: () {},
            onMinusTap: () {},
          ),
          UiKitCard.project(
            title: 'Мой первый проект',
            subTitle: 'Прошло 2 дня',
            onCardTap: () {},
            buttonText: 'Открыть',
            onPrimaryButtonTap: () {},
          ),
          Divider(height: 20.0),
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
