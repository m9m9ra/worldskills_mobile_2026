import 'package:flutter/material.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';

// ignore: must_be_immutable
class UiKitBottomBar extends StatefulWidget {
  UiKitBottomBar({
    super.key,
    required this.items,
    required this.onTap,
    required this.currentIndex,
  });

  List<BottomNavigationBarItem> items;
  Function(int) onTap;
  int currentIndex;

  @override
  State<UiKitBottomBar> createState() => _UKkitBottomBarState();
}

class _UKkitBottomBarState extends State<UiKitBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (_val) {
        widget.onTap(_val);
      },
      currentIndex: widget.items.length >= widget.currentIndex
          ? widget.currentIndex
          : throw Exception('current index > items.lenght'),
      type: BottomNavigationBarType.fixed,
      elevation: 1,
      enableFeedback: false,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      fixedColor: BrandColors.accent,
      landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
      unselectedItemColor: BrandColors.placeholder,
      backgroundColor: Colors.white,
      selectedLabelStyle: TextStyle(
        color: BrandColors.accent,
        fontSize: 12.0,
        fontWeight: FontWeight(400),
      ),
      unselectedLabelStyle: TextStyle(
        color: BrandColors.placeholder,
        fontSize: 12.0,
        fontWeight: FontWeight(400),
      ),
      iconSize: 24.0,
      items: [...widget.items],
    );
  }
}
