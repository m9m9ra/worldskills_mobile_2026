import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matule/core/config/brand_colors.dart';
import 'package:matule/core/config/brand_text_style_dark.dart';
import 'package:matule/core/config/brand_text_style_light.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? chipSelectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
          Container(
            width: double.maxFinite,
            height: 500,
            color: Colors.white,
            child: GridView.count(
              crossAxisCount: 3,
              children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0, 11].map((e) {
                if (e == 10) {
                  return SizedBox();
                }
                if (e == 11) {
                  return IconButton.filled(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                  );
                }
                return CupertinoButton(
                  child: Text(e.toString()),
                  onPressed: () {},
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Войдите, чтобы пользоваться функциями приложения',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          Container(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 0),
            height: 100,
            width: double.maxFinite,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...[0, 1, 2, 3, 4].map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () => setState(() {
                        chipSelectedId = e;
                      }),
                      child: Chip(
                        label: Text(
                          'data',
                          style: () {
                            if (chipSelectedId == e) {
                              return BrandTextStyleDark.textRegular;
                            }
                            return BrandTextStyleLight.textRegular;
                          }(),
                        ),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        backgroundColor: chipSelectedId == e
                            ? BrandColors.accent
                            : BrandColors.white,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
