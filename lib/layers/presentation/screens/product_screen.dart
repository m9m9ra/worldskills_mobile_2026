import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matule/layers/data/datasource/network/api_client.dart';
import 'package:matule/layers/domain/usecases/api_usecase.dart';
import 'package:matule/layers/domain/usecases/basket_usecase.dart';
import 'package:matule_api/matule_api.dart';
import 'package:matule_uikit/matule_uikit.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  BasketUsecase get _basketUsecase => BasketUsecase();
  ApiUsecase get _apiUsecase => ApiUsecase(apiClient);
  TextEditingController _searchEditingController = TextEditingController();
  StreamSubscription<List<ProductItem>>? _basketSubscription;

  List<News>? newsList;
  List<ProductItem>? productItemList;
  List<ProductItem>? sortedProductItemList;
  List<ProductItem>? basket;
  Set<String> categoryList = <String>{"Все"};
  int currentCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadServerData();
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
    _searchEditingController.dispose();
    super.dispose();
  }

  void _loadServerData() {
    setState(() {
      basket = BasketUsecase().getBasket;
    });
    _apiUsecase.getNews().then((List<News> news) {
      setState(() {
        newsList = news;
      });
    });
    _apiUsecase.getCatalog().then((List<ProductItem> productList) {
      setState(() {
        productItemList = productList;
        sortedProductItemList = productItemList;
        Set<String> productTypeList = productItemList!.map((
          ProductItem product,
        ) {
          return product.typeCloses!;
        }).toSet();
        categoryList = {...categoryList, ...productTypeList};
      });
    });
  }

  void onCategorySelect(int index) {
    setState(() {
      if (index <= categoryList.length) {
        currentCategoryIndex = index;
        if (index == 0 || categoryList.elementAt(index) == "Все") {
          sortedProductItemList = productItemList;
          return;
        }
        sortedProductItemList = productItemList!
            .where(
              (product) => product.typeCloses == categoryList.elementAt(index),
            )
            .toList();
      } else {
        throw Exception("index > categoryList.length");
      }
    });
  }

  void onAddToCard(ProductItem productItem) {
    bool isInCart = basket!.any((item) => item.id == productItem.id);
    if (isInCart) {
      setState(() {
        basket = _basketUsecase.removeProductFromBasket(product: productItem);
      });
      return;
    }
    _basketUsecase.addProductToBasket(product: productItem, count: 1).then((
      basketList,
    ) {
      setState(() {
        basket = basketList;
      });
      debugPrint(basket.toString());
    });
    // context.go('/product');
  }

  Future<void> onDetailsCardTap(ProductItem productItem) async {
    bool isInCart = basket!.any((item) => item.id == productItem.id);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      builder: (context) {
        return UiKitBottomSheet(
          children: [
            FutureBuilder(
              future: ApiUsecase(apiClient).getProductDetail(productItem.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CupertinoActivityIndicator();
                }
                return Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data!.title,
                                style: BrandTextStyleLight.title2SemiBold,
                              ),
                              IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: Icon(Icons.close),
                              ),
                            ],
                          ),
                          Divider(height: 20, color: Colors.transparent),
                          Text(
                            'Описание',
                            style: BrandTextStyleLight.headlineMedium,
                          ),
                          Divider(height: 8, color: Colors.transparent),
                          Text(
                            "${snapshot.data!.description}",
                            style: BrandTextStyleLight.textRegular,
                          ),
                        ],
                      ),

                      Divider(height: 40, color: Colors.transparent),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 19.0,
                        children: [
                          Text(
                            'Примерный расход:',
                            style: BrandTextStyleLight.captionSemiBold,
                          ),
                          Text(
                            '80-90 г',
                            style: BrandTextStyleLight.headlineMedium,
                          ),
                          UiKitButtonBig(
                            uikitButtonState: isInCart
                                ? UikitButtonState.secondary
                                : UikitButtonState.primary,
                            text:
                                "${isInCart ? "Убрать" : "Добавить"} за ${snapshot.data!.price} ₽",
                            onPressed: () {
                              onAddToCard(productItem);
                              context.pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void onSearchInputQuery(String query) {
    setState(() {
      if (query.isEmpty) {
        sortedProductItemList = productItemList;
      }
      sortedProductItemList = productItemList!
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void onBusketButton() {
    context.push('/basket');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Divider(color: Colors.transparent, height: 24.0),
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: UiKitSearchInput(
                    controller: _searchEditingController,
                    onChanged: (value) => onSearchInputQuery(value),
                    hintText: 'Искать  описания',
                  ),
                ),
                IconButton(
                  iconSize: 32.0,
                  onPressed: () {
                    context.go('/profile');
                  },
                  icon: Icon(CupertinoIcons.person_fill),
                ),
              ],
            ),
          ),
          Divider(color: Colors.transparent, height: 12.0),
          Container(
            color: Colors.white,
            child: UiKitMenuCategory(
              height: 46.0,
              currentIndex: currentCategoryIndex,
              onPressed: (int index) => onCategorySelect(index),
              category: categoryList.toList(),
            ),
          ),
          Divider(color: Colors.transparent, height: 12.0),
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 19.0),
                  itemCount: sortedProductItemList != null
                      ? sortedProductItemList!.length
                      : 4,
                  itemBuilder: (context, index) {
                    // bool inBasket = sortedProductItemList.contains(element)
                    if (productItemList == null) {
                      return UiKitCard(
                        onCardTap: () {},
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    bool isInCart = basket!.any(
                      (item) => item.id == sortedProductItemList![index].id,
                    );
                    return UiKitCard.primary(
                      title: sortedProductItemList![index].title,
                      subTitle: sortedProductItemList![index].typeCloses,
                      buttonText: isInCart ? "Убрать" : 'Добавить',
                      uikitButtonState: isInCart
                          ? UikitButtonState.secondary
                          : UikitButtonState.primary,
                      price: sortedProductItemList![index].price,
                      onCardTap: () =>
                          onDetailsCardTap(sortedProductItemList![index]),
                      onPrimaryButtonTap: () =>
                          onAddToCard(sortedProductItemList![index]),
                    );
                  },
                ),
                if (basket != null && basket!.isNotEmpty)
                  Positioned(
                    left: 20.0,
                    right: 20.0,
                    bottom: 32.0,
                    child: UiKitButtonCart(
                      iconData: Icons.shopping_cart_outlined,
                      text: 'В корзину',
                      price: () {
                        int price = 0;
                        basket!.forEach((ProductItem item) {
                          price += item.price;
                        });
                        return price;
                      }(),
                      onPressed: () => onBusketButton(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
