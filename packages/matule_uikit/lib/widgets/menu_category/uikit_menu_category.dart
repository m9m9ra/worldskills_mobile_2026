import 'package:flutter/cupertino.dart';
import 'package:matule_uikit/widgets/button/uikit_button_chips.dart';

// ignore: must_be_immutable
class UiKitMenuCategory extends StatelessWidget {
  UiKitMenuCategory({
    super.key,
    this.width = double.maxFinite,
    this.height = 50,
    required this.currentIndex,
    required this.category,
    required this.onPressed,
  });

  double? width;
  double? height;
  int currentIndex = 0;
  List<String> category;
  Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
        physics: AlwaysScrollableScrollPhysics(),
        children: category.map((String categoryItem) {
          return Padding(
            padding: category.indexOf(categoryItem) == category.length - 1
                ? const EdgeInsets.only(left: 19.0, right: 19.0)
                : const EdgeInsets.only(left: 19.0),
            child: UiKitButtonChips(
              text: categoryItem,
              height: 46.0,
              uikitButtonState: currentIndex == category.indexOf(categoryItem)
                  ? UiKitButtonChipsState.enable
                  : UiKitButtonChipsState.disable,
              onPressed: () => onPressed(category.indexOf(categoryItem)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
