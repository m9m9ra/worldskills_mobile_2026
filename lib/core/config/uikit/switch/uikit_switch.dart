import 'package:flutter/cupertino.dart';
import 'package:matule/core/config/brand_colors.dart';

// ignore: must_be_immutable
class UiKitSwitch extends StatelessWidget {
  /// UiKitSwitch usage example
  /// ```
  /// UiKitSwitch(
  ///   value: switchState,
  ///   onChange: (bool value) {
  ///   setState(() {
  ///   switchState = value;
  ///   });
  /// })
  /// ```
  UiKitSwitch({super.key, required this.value, required this.onChange});

  bool? value;
  Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      focusColor: BrandColors.accent,
      activeTrackColor: BrandColors.accent,
      value: value!,
      onChanged: (value) => onChange(value),
    );
  }
}
