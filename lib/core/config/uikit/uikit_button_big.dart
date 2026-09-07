import 'package:flutter/cupertino.dart';
import 'package:matule/core/config/brand_colors.dart';

enum UikitButtonState { tetriary, secondary, inactive, primary }

// ignore: must_be_immutable
class UikitButtonBig extends StatelessWidget {
  UikitButtonBig({
    super.key,
    required this.text,
    this.uikitButtonState,
    required this.onPressed,
    this.height,
    this.width
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
