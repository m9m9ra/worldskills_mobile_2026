import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matule_uikit/widgets/bottom_bar/uikit_bottom_bar.dart';
import 'package:matule_uikit/widgets/bottom_sheet/uikit_bottom_sheet.dart';
import 'package:matule_uikit/widgets/button/uikit_button_state.dart';
import 'package:matule_uikit/widgets/card/uikit_card_base.dart';
import 'package:matule_uikit/widgets/counter/uikit_counter.dart';
import 'package:matule_uikit/widgets/input/uikit_input.dart';
import 'package:matule_uikit/widgets/login/uikit_button_login_yandex.dart';
import 'package:matule_uikit/widgets/menu_category/uikit_menu_category.dart';
import 'package:matule_uikit/widgets/search/uikit_search.dart';
import 'package:matule_uikit/widgets/select/uikit_select.dart';
import 'package:matule_uikit/widgets/switch/uikit_switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int chipSelectedId = 0;
  bool switchState = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(microseconds: 200)).then((onValue) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   snackBarAnimationStyle: AnimationStyle(curve: Curves.easeOut),
      //   SnackBar(
      //     // margin: EdgeInsets.all(10),
      //     backgroundColor: BrandColors.white,
      //     behavior: SnackBarBehavior.floating,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadiusGeometry.circular(8.0)
      //     ),
      //     content: Container(
      //       width: 375,
      //       height: 80.0,
      //       alignment: Alignment.topLeft,
      //       decoration: BoxDecoration(
      //         color: BrandColors.white
      //       ),
      //       child: Text('Произошла ошибка\nНу вот опять', style: BrandTextStyleLight.title2ExtraBold,),
      //       ),
      //   ),
      // );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        shrinkWrap: true,
        // padding: EdgeInsets.symmetric(horizontal: 12.0),
        slivers: [
          CupertinoSliverNavigationBar(
            leading: Icon(Icons.traffic),
            largeTitle: Text('Корзина'),
            trailing: Icon(Icons.access_alarm_outlined),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
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
              SizedBox(height: 10),
              UiKitSelect(
                onSelected: (String p1) {},
                menuItems: [
                  UiKitSelectItem(label: 'asd', value: 'asd'),
                  UiKitSelectItem(label: 'asd', value: 'asd'),
                ],
              ),
              SizedBox(height: 10),
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
            ]),
          ),
        ],
      ),
      bottomNavigationBar: UiKitBottomBar(
        currentIndex: _currentIndex,
        onTap: (int p) {
          setState(() {
            _currentIndex = p;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            label: 'Doos',
            icon: Icon(Icons.question_answer),
          ),
          BottomNavigationBarItem(label: 'Lokasd', icon: Icon(Icons.propane)),
          BottomNavigationBarItem(
            label: 'Lokasd',
            icon: Icon(Icons.production_quantity_limits_sharp),
          ),
        ],
      ),
    );
  }
}
