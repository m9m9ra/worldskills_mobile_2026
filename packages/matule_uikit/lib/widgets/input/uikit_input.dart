import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';
import 'package:matule_uikit/widgets/font/brand_text_style_light.dart';

class UiKitInput extends StatefulWidget {
  const UiKitInput({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = 'Введите имя',
    this.labelText,
    this.errorText,
    this.isPassword = false,
    this.keyboardType,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final String? labelText; // Текст над полем
  final String? errorText; // Текст ошибки под полем
  final bool isPassword; // Флаг для скрытия текста (пароль)
  final TextInputType? keyboardType;
  final List<TextInputFormatter>?
  inputFormatters; // Для масок (например, телефона)

  @override
  State<UiKitInput> createState() => _UiKitInputState();
}

class _UiKitInputState extends State<UiKitInput> {
  late final TextEditingController _controller;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Заголовок поля (если передан)
        if (widget.labelText != null) ...[
          Text(widget.labelText!, style: BrandTextStyleLight.textRegular),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: _controller,
          onChanged: (value) {
            // widget.onChanged!(value);
          },
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          style: TextStyle(
            fontSize: 16,
            color: BrandColors.black, // Цвет вводимого текста
          ),
          cursorColor: BrandColors.accent,
          decoration: InputDecoration(
            filled: true,
            errorText: hasError ? widget.errorText : null,
            fillColor: hasError
                ? Color.fromRGBO(253, 53, 53, 0.1)
                : BrandColors.inputBg,
            contentPadding: const EdgeInsets.all(14.0),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: BrandColors.placeholder,
              fontSize: 16,
            ),
            // Кнопка переключения видимости для пароля
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: BrandColors.inputIcon,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
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
          ),
        ),
      ],
    );
  }
}
