import 'package:flutter/cupertino.dart';
import 'package:matule/core/config/brand_colors.dart';

enum UiKitButtonChipsState { enable, disable }

// ignore: must_be_immutable
class UiKitButtonChips extends StatelessWidget {
  UiKitButtonChips({
    super.key,
    this.height,
    this.width,
    this.uikitButtonState = UiKitButtonChipsState.enable,
    required this.text,
    required this.onPressed,
  });

  String text = '';
  UiKitButtonChipsState? uikitButtonState = UiKitButtonChipsState.enable;
  Function onPressed = () {};
  double? width = 96.0;
  double? height = 40.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        color: () {
          debugPrint(uikitButtonState!.name.toString());
          switch (uikitButtonState!.name) {
            case 'enable':
              return BrandColors.accent;
            default:
              return BrandColors.inputBg;
          }
        }(),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: CupertinoButton(
        borderRadius: BorderRadius.circular(10.0),
        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
        color: () {
          switch (uikitButtonState!.name) {
            case 'enable':
              return BrandColors.accent;
            default:
              return BrandColors.inputBg;
          }
        }(),
        child: Text(
          text,
          maxLines: 1,
          softWrap: true,
          style: TextStyle(
            fontWeight: FontWeight(500),
            fontSize: 15.0,
            color: () {
              switch (uikitButtonState!.name) {
                case 'enable':
                  return BrandColors.white;
                default:
                  return BrandColors.description;
              }
            }(),
          ),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
