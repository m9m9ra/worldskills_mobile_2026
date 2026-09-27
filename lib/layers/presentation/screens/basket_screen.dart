import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matule/layers/domain/usecases/basket_usecase.dart';
import 'package:matule_api/matule_api.dart';
import 'package:matule_uikit/matule_uikit.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  BasketUsecase get _basketUsecase => BasketUsecase();
  StreamSubscription<List<ProductItem>>? _basketSubscription;
  List<ProductItem>? basket;

  @override
  void initState() {
    super.initState();
    _basketSubscription = _basketUsecase.getBasketStream
        .asBroadcastStream()
        .listen((List<ProductItem> streamList) {
          setState(() {
            basket = streamList;
          });
        });
  }

  @override
  void dispose() {
    _basketSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                CupertinoSliverNavigationBar(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                  backgroundColor: Colors.white,
                  transitionBetweenRoutes: true,
                  alwaysShowMiddle: false,
                  leading: IconButton(
                    iconSize: 24.0,
                    color: BrandColors.description,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        BrandColors.inputBg,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(CupertinoIcons.chevron_back),
                  ),
                  middle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 0, height: 0),
                      Text(
                        'Корзина',
                        style: BrandTextStyleLight.title2SemiBold,
                      ),
                      IconButton(
                        iconSize: 24.0,
                        color: BrandColors.description,
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.trash),
                      ),
                    ],
                  ),
                  largeTitle: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Корзина',
                          style: BrandTextStyleLight.title1ExtraBold,
                        ),
                        IconButton(
                          iconSize: 24.0,
                          color: BrandColors.description,
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.trash),
                        ),
                      ],
                    ),
                  ),
                  // trailing: IconButton(
                  //   iconSize: 24.0,
                  //   color: BrandColors.description,
                  //   onPressed: () {},
                  //   icon: Icon(CupertinoIcons.trash),
                  // ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    StreamBuilder(
                      initialData: _basketUsecase.getBasket,
                      stream: _basketUsecase.getBasketStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CupertinoActivityIndicator());
                        }
                        int totalPrice = 0;
                        snapshot.data!.forEach((e) {
                          totalPrice += e.price;
                        });
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ...snapshot.data!.map((ProductItem product) {
                                return Padding(
                                  padding: EdgeInsetsGeometry.only(bottom: 16.0),
                                  child: UiKitCard.cart(
                                    title: product.title,
                                    price: product.price,
                                    width: double.maxFinite,
                                    count: 1,
                                    onCloseTap: () {},
                                    onPlusTap: () {},
                                    onMinusTap: () {},
                                    onCardTap: () {},
                                  ),
                                );
                              }),
                              Divider(height: 32.0, color: Colors.transparent),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Сумма", style: BrandTextStyleLight.title2SemiBold),
                                  Text("$totalPrice ₽", style: BrandTextStyleLight.title2SemiBold),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
                ),
              ],
            ),
            Positioned(
              left: 20.0,
              right: 20.0,
              bottom: 32.0,
              child: UiKitButtonBig(text: 'Перейти к оформлению заказа', onPressed: () => ()),
            ),
          ],
        ),
      ),
    );
  }
}
