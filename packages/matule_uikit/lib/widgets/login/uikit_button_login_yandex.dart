import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';

// ignore: must_be_immutable
class UiKitButtonLoginYadex extends StatelessWidget {
  UiKitButtonLoginYadex({
    super.key,
    this.height = 60.0,
    this.width = 335.0,
    required this.onPressed,
  });

  Function onPressed = () {};
  double? width = 335.0;
  double? height = 60.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        color: BrandColors.inputStroke,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: CupertinoButton(
        borderRadius: BorderRadius.circular(12.0),
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
        color: BrandColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16.0,
          children: [
            Image(
              height: 32.0,
              width: 32.0,
              image: AssetImage('assets/yandex.png', package: 'matule_uikit'),
            ),
            Text(
              'Войти с Yandex',
              style: TextStyle(
                color: BrandColors.black,
                fontWeight: FontWeight(500),
                fontSize: 17.0,
              ),
            ),
          ],
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
