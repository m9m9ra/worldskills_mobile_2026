import 'package:flutter/material.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';

class UiKitSearchInput extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String hintText;

  const UiKitSearchInput({
    super.key,
    this.controller,
    this.onChanged,
    this.onClear,
    this.hintText = 'Искать описание',
  });

  @override
  State<UiKitSearchInput> createState() => UiKitSearchInputState();
}

class UiKitSearchInputState extends State<UiKitSearchInput> {
  late final TextEditingController _controller;
  bool _showClearButton = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (value) {
        _updateClearButtonVisibility(value);
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF2D2D2D), // Цвет вводимого текста
      ),
      cursorColor: BrandColors.accent, // Цвет курсора (вертикальной палочки)
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Color(0), // Цвет плейсхолдера
          fontSize: 16,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xFF7A7A7A), // Цвет лупы
          size: 22,
        ),
        suffixIcon: _showClearButton
            ? IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Color(0xFF7A7A7A), // Цвет крестика
                  size: 20,
                ),
                onPressed: _clearInput,
              )
            : null,
        filled: true,
        fillColor: const Color(0xFFF4F5F7), // Серый фоновый цвет поля
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Скругление углов
          borderSide: BorderSide.none, // Убираем внешнюю рамку
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Внутренний контроллер удаляем только если он не был передан снаружи
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _showClearButton = _controller.text.isNotEmpty;
  }

  void _clearInput() {
    _controller.clear();
    _updateClearButtonVisibility('');
    if (widget.onChanged != null) {
      widget.onChanged!('');
    }
    if (widget.onClear != null) {
      widget.onClear!();
    }
  }

  void _updateClearButtonVisibility(String text) {
    if (text.isNotEmpty && !_showClearButton) {
      setState(() => _showClearButton = true);
    } else if (text.isEmpty && _showClearButton) {
      setState(() => _showClearButton = false);
    }
  }
}
