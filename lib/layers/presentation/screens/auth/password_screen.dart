import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matule/layers/domain/usecases/auth_usecase.dart';
import 'package:matule/layers/presentation/screens/auth/auth_layout.dart';
import 'package:matule_uikit/matule_uikit.dart';

// ignore: must_be_immutable
class PasswordScreen extends StatefulWidget {
  PasswordScreen({super.key, required this.extraEmail});
  String extraEmail;

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _passwordConfirmEditingController =
      TextEditingController();
  List<TextEditingController> get _controllerList => [
    _passwordEditingController,
    _passwordConfirmEditingController,
  ];
  String _passwordValidatingError = '';
  String _passwordConfirmError = '';
  bool validData = false;

  void onSignin({
    required String email,
    required String password,
    required String passwordConfirm,
  }) {
    // MOCK DATA CHECH
    // example@mail.com
    // 1324534789
    AuthUsecase().register(email: email, password: password, passwordConfirm: passwordConfirm);
    context.replace('/pincode_create');
  }

  void onValidateData() {
    if (validData) {
      onSignin(
        email: widget.extraEmail,
        password: _passwordEditingController.text,
        passwordConfirm: _passwordConfirmEditingController.text,
      );
    }
  }

  void onValidatePasswordListener(String value) {
    setState(() {
      if (!validatePassword(_passwordEditingController.text)) {
        _passwordValidatingError = 'Хуйня пароль твой';
      } else {
        _passwordValidatingError = '';
      }
    });
  }

  bool validatePassword(String password) {
    // Проверяем длину (не менее 8 символов)
    if (password.length < 8) {
      debugPrint('password lenght');
      return false;
    }

    // Проверяем наличие заглавной буквы
    if (!password.contains(RegExp(r'[A-ZА-Я]'))) {
      debugPrint('Upset literal undef');
      return false;
    }

    // Проверяем наличие строчной буквы
    if (!password.contains(RegExp(r'[a-zа-я]'))) {
      debugPrint('lowset literal');
      return false;
    }

    // Проверяем наличие цифры
    if (!password.contains(RegExp(r'[0-9]'))) {
      debugPrint('match not found');
      return false;
    }

    // Проверяем наличие пробела
    if (password.contains(RegExp(r' '))) {
      debugPrint('also contail space');
      return false;
    }

    // Проверяем наличие специального символа
    // if (!password.contains(RegExp((r"!@#$%^&*()_+\-=\[\]{};:\\|,.<>\/?~`]")))) {
    //   debugPrint('char req');
    //   return false;
    // }

    return true;
  }

  @override
  void initState() {
    super.initState();
    _controllerList.forEach((TextEditingController controller) {
      controller.addListener(() {
        if (validatePassword(_passwordEditingController.text) &&
            (_passwordEditingController.text ==
                _passwordConfirmEditingController.text)) {
          setState(() {
            validData = true;
          });
        } else {
          setState(() {
            validData = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerList.forEach((TextEditingController controller) {
      controller.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [
        Divider(height: 60.0, color: Colors.transparent),
        Row(
          spacing: 16.0,
          children: [
            Text('✋', style: BrandTextStyleLight.title1ExtraBold),
            Text('Создание пароля', style: BrandTextStyleLight.title1ExtraBold),
          ],
        ),
        Divider(height: 25.0, color: Colors.transparent),
        Text('Введите новый пароль', style: BrandTextStyleLight.textRegular),
        Divider(height: 90.0, color: Colors.transparent),
        Column(
          spacing: 14.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UiKitInput(
              controller: _passwordEditingController,
              onChanged: (value) => onValidatePasswordListener(value),
              labelText: 'Новый Пароль',
              hintText: '',
              isPassword: true,
              errorText: _passwordValidatingError,
            ),
            UiKitInput(
              controller: _passwordConfirmEditingController,
              onChanged: (value) => onValidatePasswordListener(value),
              labelText: 'Повторите пароль',
              hintText: '',
              isPassword: true,
              errorText: _passwordConfirmError,
            ),
            UiKitButtonBig(
              text: 'Далее',
              uikitButtonState: validData
                  ? UikitButtonState.primary
                  : UikitButtonState.inactive,
              onPressed: () => onValidateData(),
            ),
          ],
        ),
      ],
    );
  }
}
