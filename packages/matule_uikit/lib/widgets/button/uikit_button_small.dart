import 'package:flutter/cupertino.dart';
import 'package:matule_uikit/widgets/button/uikit_button_state.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';

// ignore: must_be_immutable
class UiKitButtonSmall extends StatelessWidget {
  UiKitButtonSmall({
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
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
            fontSize: 14.0,
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
