import 'package:flutter/material.dart';
import 'package:matule_uikit/matule_uikit.dart';
import 'package:matule_uikit/widgets/search/uikit_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Divider(color: Colors.transparent, height: 24.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: UiKitSearchInput(hintText: 'Искать  описания'),
          ),
          Divider(color: Colors.transparent, height: 32.0),
          Expanded(
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Акции и новости',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Горизонтальный список акций
                      SizedBox(
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) => Container(
                            width: 260,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(child: Text('Акция ${index + 1}')),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),

                // 3. КАТАЛОГ / КАТЕГОРИИ (Едет вверх и УПИРАЕТСЯ в поиск)
                SliverPersistentHeader(
                  pinned: true, // Магия закрепления
                  delegate: _StickyHeaderDelegate(
                    child: ColoredBox(
                      color: Colors.white,
                      child: UiKitMenuCategory(
                        currentIndex: 0,
                        height: 56.0,
                        category: [
                          "category",
                          "category",
                          "category",
                          "category",
                          "category",
                        ],
                        onPressed: (_) {},
                      ),
                    ),
                  ),
                ),

                // 4. КАРТОЧКИ ТОВАРОВ (Скроллятся под категории)
                SliverPadding(
                  padding: const EdgeInsets.only(top: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return UiKitCard.primary(
                        title: 'Рубашка Воскресенье для машинного вязания',
                        subTitle: 'subTitle',
                        buttonText: 'buttonText',
                        price: 300,
                        onCardTap: () {},
                        onPrimaryButtonTap: () {},
                      );
                    }, childCount: 15),
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
  double get maxExtent => 56.0; // Высота вашей ленты категорий
  @override
  double get minExtent => 56.0; // Должна быть равна maxExtent, чтобы не сжималась
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
