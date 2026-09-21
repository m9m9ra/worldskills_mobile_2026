import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';

class UiKitSelectItem {
  UiKitSelectItem({required this.label, required this.value});

  String? value;
  String? label;
}

// ignore: must_be_immutable
class UiKitSelect extends StatefulWidget {
  UiKitSelect({
    super.key,
    this.hintText = 'placeholder',
    this.initialSelectionValue,
    required this.onSelected,
    required this.menuItems,
  });

  String hintText;
  String? initialSelectionValue;
  List<UiKitSelectItem> menuItems;
  Function(String) onSelected;

  @override
  State<UiKitSelect> createState() => _UKkitSelectState();
}

class _UKkitSelectState extends State<UiKitSelect> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: double.maxFinite,
      initialSelection: widget.initialSelectionValue,
      onSelected: (value) {
        widget.onSelected(value ?? '');
      },
      menuStyle: MenuStyle(
        // Фонового цвет самого меню
        backgroundColor: WidgetStateProperty.all(BrandColors.inputBg),
        // Скругление углов для всего всплывающего окна
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        // Регулировка внутренних отступов контейнера меню (опционально)
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 8.0),
        ),
      ),
      decorationBuilder: (context, controller) {
        return InputDecoration(
          filled: true,
          fillColor: BrandColors.inputBg,
          contentPadding: const EdgeInsets.all(14.0),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: BrandColors.placeholder, fontSize: 16),
          suffixIcon: Icon(CupertinoIcons.chevron_down, size: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Скругление углов
            borderSide: BorderSide.none, // Убираем внешнюю рамку
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: BrandColors.accent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: BrandColors.error),
          ),
        );
      },
      dropdownMenuEntries: [
        ...widget.menuItems.map((UiKitSelectItem item) {
          return DropdownMenuEntry(value: item.value, label: item.label!);
        }),
      ],
    );
  }
}
