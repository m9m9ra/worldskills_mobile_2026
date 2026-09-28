import 'package:flutter/material.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';

// ignore: must_be_immutable
class UiKitCounter extends StatelessWidget {
  /// Uikit counter class
  /// Created from UiKit stg 1
  ///
  UiKitCounter({
    super.key,
    this.width = 98.0,
    required this.onMinusTap,
    required this.onPlusTap,
  });

  double? width;
  Function onPlusTap;
  Function onMinusTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 32.0,
      decoration: BoxDecoration(
        color: BrandColors.inputBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              size: 20.0,
              color: BrandColors.placeholder,
            ),
            style: IconButton.styleFrom(padding: EdgeInsets.all(0)),
            padding: EdgeInsets.all(0),
            onPressed: onMinusTap(),
            color: BrandColors.black,
            tooltip: 'Уменьшить',
          ),
          Container(width: 1.0, height: 18.0, color: BrandColors.inputStroke),
          // Кнопка Увеличить (Плюс)
          IconButton(
            icon: Icon(Icons.add, size: 20.0, color: BrandColors.placeholder),
            style: IconButton.styleFrom(padding: EdgeInsets.all(0)),
            padding: EdgeInsets.all(0),
            onPressed: onPlusTap(),
            tooltip: 'Увеличить',
          ),
        ],
      ),
    );
  }
}
