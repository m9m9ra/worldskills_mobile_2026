import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matule/layers/data/datasource/network/api_client.dart';
import 'package:matule/layers/domain/usecases/api_usecase.dart';
import 'package:matule/layers/domain/usecases/basket_usecase.dart';
import 'package:matule_api/matule_api.dart';
import 'package:matule_uikit/matule_uikit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchEditingController = TextEditingController();
  Stream<List<ProductItem>> _basketStream = BasketUsecase().getBasketStream.asBroadcastStream();
  List<News>? newsList;
  List<ProductItem>? productItemList;
  List<ProductItem>? sortedProductItemList;
  List<ProductItem>? basket;
  Set<String> categoryList = <String>{"Все"};
  int currentCategoryIndex = 0;

  StreamSubscription<List<ProductItem>>? _basketSubscription;

  @override
  void initState() {
    super.initState(); 
    _loadServerData();
    _basketSubscription = _basketStream.listen((List<ProductItem> streamList) {
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
    ApiUsecase(apiClient).getNews().then((List<News> news) {
      setState(() {
        newsList = news;
      });
    });
    ApiUsecase(apiClient).getCatalog().then((List<ProductItem> productList) {
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
        basket = BasketUsecase().removeProductFromBasket(product: productItem);
      });
      return;
    }
    BasketUsecase().addProductToBasket(product: productItem, count: 1).then((
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Divider(color: Colors.transparent, height: 24.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: UiKitSearchInput(
              controller: _searchEditingController,
              onChanged: (value) => onSearchInputQuery(value),
              hintText: 'Искать  описания',
            ),
          ),
          Divider(color: Colors.transparent, height: 12.0),
          Expanded(
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(color: Colors.transparent, height: 12.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Акции и новости',
                          style: BrandTextStyleLight.title3SemiBold,
                        ),
                      ),
                      const Divider(color: Colors.transparent, height: 16.0),
                      // Горизонтальный список акций
                      SizedBox(
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: newsList != null ? newsList!.length : 3,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 260,
                              margin: const EdgeInsets.only(left: 18.0),

                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: newsList != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(16.0),
                                      child: Image.asset(
                                        "assets/mock/${newsList![index].newsImage}",
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    )
                                  : CupertinoActivityIndicator(),
                            );
                          },
                        ),
                      ),
                      Divider(color: Colors.transparent, height: 32.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Каталог описаний',
                          style: BrandTextStyleLight.title3SemiBold,
                        ),
                      ),
                      Divider(color: Colors.transparent, height: 12.0),
                    ],
                  ),
                ),

                // 3. КАТАЛОГ / КАТЕГОРИИ (Едет вверх и УПИРАЕТСЯ в поиск)
                SliverPersistentHeader(
                  pinned: true, // Магия закрепления
                  delegate: _StickyHeaderDelegate(
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(top: 4, bottom: 4.0),
                      child: UiKitMenuCategory(
                        height: 50.0,
                        currentIndex: currentCategoryIndex,
                        onPressed: (int index) => onCategorySelect(index),
                        category: categoryList.toList(),
                      ),
                    ),
                  ),
                ),

                // 4. КАРТОЧКИ ТОВАРОВ (Скроллятся под категории)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 10.0,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
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
                      childCount: sortedProductItemList != null
                          ? sortedProductItemList!.length
                          : 4,
                    ),
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

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyHeaderDelegate({required this.child});

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) => child;
  @override
  double get maxExtent => 54.0; // Высота вашей ленты категорий
  @override
  double get minExtent => 54.0; // Должна быть равна maxExtent, чтобы не сжималась

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
