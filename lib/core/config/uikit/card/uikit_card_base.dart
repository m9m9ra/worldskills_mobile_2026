import 'package:flutter/material.dart';
import 'package:matule/core/config/brand_colors.dart';
import 'package:matule/core/config/brand_text_style_light.dart';
import 'package:matule/core/config/uikit/uikit_button_small.dart';
import 'package:matule/core/config/uikit/uikit_button_state.dart';

enum _CardVariant { base, primary, cart, project }

// ignore: must_be_immutable
class UiKitCard extends StatelessWidget {
  UiKitCard({
    super.key,
    this.height = 138.0,
    this.width = 335.0,
    required this.child,
    required this.onCardTap,
  }) : _cardVariant = _CardVariant.base;

  double? width;
  double? height;
  Widget? child;
  Function() onCardTap;
  // ignore: prefer_final_fields
  _CardVariant _cardVariant = _CardVariant.base;

  UiKitCard.primary({
    super.key,
    this.height = 138.0,
    this.width = 335.0,
    this.uikitButtonState = UikitButtonState.primary,
    required this.title,
    required this.subTitle,
    required this.buttonText,
    required this.price,
    required this.onCardTap,
    required this.onPrimaryButtonTap,
  }) : _cardVariant = _CardVariant.primary;

  String? title;
  String? subTitle;
  String? buttonText;
  int? price;
  UikitButtonState? uikitButtonState;
  Function() onPrimaryButtonTap = () {};

  UiKitCard.cart({
    super.key,
    this.height = 138.0,
    this.width = 335.0,
    required this.title,
    required this.price,
    required this.count,
    required this.onCloseTap,
    required this.onPlusTap,
    required this.onMinusTap,
    required this.onCardTap,
  }) : _cardVariant = _CardVariant.cart;

  int? count;
  Function() onCloseTap = () {};
  Function() onPlusTap = () {};
  Function() onMinusTap = () {};

  UiKitCard.project({
    super.key,
    this.height = 138.0,
    this.width = 335.0,
    this.uikitButtonState = UikitButtonState.primary,
    required this.title,
    required this.subTitle,
    required this.onCardTap,
    required this.buttonText,
    required this.onPrimaryButtonTap,
  }) : _cardVariant = _CardVariant.project;

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      width: width,
      height: height,
      onCardTap: onCardTap,
      child: () {
        switch (_cardVariant.name) {
          case 'base':
            return child;
          case 'primary':
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title!,
                    maxLines: 2,
                    style: BrandTextStyleLight.headlineMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subTitle!,
                            maxLines: 1,
                            style: BrandTextStyleLight.captionSemiBold,
                          ),
                          Text(
                            '$price ₽',
                            maxLines: 1,
                            style: BrandTextStyleLight.title3SemiBold,
                          ),
                        ],
                      ),
                      UiKitButtonSmall(
                        text: buttonText!,
                        uikitButtonState: uikitButtonState,
                        onPressed: onCardTap,
                      ),
                    ],
                  ),
                ],
              ),
            );
          case 'cart':
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 225.0,
                        child: Text(
                          title!,
                          maxLines: 2,
                          style: BrandTextStyleLight.headlineMedium,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 2, top: 2),
                        child: GestureDetector(
                          onTap: () => onCloseTap(),
                          child: Icon(Icons.close, size: 20),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$price ₽',
                        style: BrandTextStyleLight.title3SemiBold,
                      ),
                      Text(
                        '$price ₽',
                        style: BrandTextStyleLight.title3SemiBold,
                      ),
                      Text(
                        '$price ₽',
                        style: BrandTextStyleLight.title3SemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            );
          case 'project':
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title!,
                    maxLines: 2,
                    style: BrandTextStyleLight.headlineMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        subTitle!,
                        maxLines: 1,
                        style: BrandTextStyleLight.captionSemiBold,
                      ),
                      UiKitButtonSmall(
                        text: buttonText!,
                        uikitButtonState: uikitButtonState,
                        onPressed: onCardTap,
                      ),
                    ],
                  ),
                ],
              ),
            );
          default:
            return child;
        }
      }()!,
    );
  }
}

// ignore: must_be_immutable
class _BaseCard extends StatelessWidget {
  _BaseCard({
    this.height = 138.0,
    this.width = 335.0,
    required this.child,
    required this.onCardTap,
  });

  double? width;
  double? height;
  Widget child;
  Function() onCardTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onTap: () {},
        child: Card(
          elevation: 1.1,
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          shadowColor: BrandColors.cardStroke,
          child: child,
        ),
      ),
    );
  }
}
