import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:matule_uikit/widgets/bottom_bar/uikit_bottom_bar.dart';

// ignore: must_be_immutable
class RootScreen extends StatefulWidget {
  RootScreen({super.key, required this.statefulNavigationShell});
  StatefulNavigationShell statefulNavigationShell;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  void _goBranch(int index) {
    widget.statefulNavigationShell.goBranch(
      index,
      initialLocation: index == widget.statefulNavigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle!,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: widget.statefulNavigationShell,
        ),
        bottomNavigationBar: Container(
          height: Platform.isAndroid ? 80 : null,
          width: double.maxFinite,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: UiKitBottomBar(
            currentIndex: widget.statefulNavigationShell.currentIndex,
            onTap: (int index) => _goBranch(index),
            items: [
              BottomNavigationBarItem(
                label: 'Главная',
                icon: Icon(CupertinoIcons.home),
              ),
              BottomNavigationBarItem(
                label: 'Каталог',
                icon: Icon(CupertinoIcons.square_list),
              ),
              BottomNavigationBarItem(
                label: 'Проекты',
                icon: Icon(CupertinoIcons.doc_text),
              ),
              BottomNavigationBarItem(
                label: 'Профиль',
                icon: Icon(CupertinoIcons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
