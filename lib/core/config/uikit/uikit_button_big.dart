import 'package:flutter/cupertino.dart';
import 'package:matule/core/config/brand_colors.dart';
import 'package:matule/core/config/uikit/uikit_button_state.dart';

// ignore: must_be_immutable
class UiKitButtonBig extends StatelessWidget {
  UiKitButtonBig({
    super.key,
    this.height,
    this.width,
    this.uikitButtonState = UikitButtonState.primary,
    required this.text,
    required this.onPressed,
  });

  String text = '';
  UikitButtonState? uikitButtonState = UikitButtonState.primary;
  Function onPressed = () {};
  double? width = double.maxFinite;
  double? height = 56.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        color: () {
          switch (uikitButtonState!.name) {
            case 'primary':
              return BrandColors.accent;
            case 'inactive':
              return BrandColors.accentInactive;
            case 'secondary':
              return BrandColors.accent;
            case 'tetriary':
              return BrandColors.inputBg;
            default:
              return BrandColors.error;
          }
        }(),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: CupertinoButton(
        borderRadius: BorderRadius.circular(10.0),
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
        color: () {
          switch (uikitButtonState!.name) {
            case 'primary':
              return BrandColors.accent;
            case 'inactive':
              return BrandColors.accentInactive;
            case 'secondary':
              return BrandColors.white;
            case 'tetriary':
              return BrandColors.inputBg;
            default:
              return BrandColors.error;
          }
        }(),
        child: Text(
          text,
          maxLines: 1,
          softWrap: true,
          style: TextStyle(
            fontWeight: FontWeight(600),
            fontSize: 17.0,
            color: () {
              switch (uikitButtonState!.name) {
                case 'primary':
                  return BrandColors.white;
                case 'inactive':
                  return BrandColors.white;
                case 'secondary':
                  return BrandColors.accent;
                case 'tetriary':
                  return BrandColors.black;
                default:
                  return BrandColors.error;
              }
            }(),
          ),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
