import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UiKitBottomSheet extends StatelessWidget {
  /// UiKitBottomSheet usage
  ///```
  ///showModalBottomSheet(
  ///   context: context,
  ///   isScrollControlled: true,
  ///   backgroundColor: Colors.transparent,
  ///   builder: (context) {
  ///   return UiKitBottomSheet(children: []);
  ///   },
  ///);
  ///```
  UiKitBottomSheet({super.key, required this.children});

  List<Widget>? children;

  /// Show UiKitBottomSheet as modal
  /// ```
  /// UiKitBottomSheet.showSnappingBottomSheet(context, [])
  /// ```
  static void showSnappingBottomSheet(
    BuildContext context,
    List<Widget> _children,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Позволяет шторке расти выше 50% экрана
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.2,
          maxChildSize: 0.85,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
              ),
              child: Column(
                children: [
                  // Индикатор для перетаскивания (Handle)
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Контент шторки
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: _children,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.2,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
          ),
          child: Column(
            children: [
              // Индикатор для перетаскивания (Handle)
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              const SizedBox(height: 12),

              // Контент шторки
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: children!,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
