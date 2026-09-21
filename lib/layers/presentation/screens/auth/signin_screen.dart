import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matule/layers/presentation/screens/auth/auth_layout.dart';
import 'package:matule_uikit/matule_uikit.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController _emailEditingController = TextEditingController();
  String _emailValidatingError = '';
  TextEditingController _passwordEditingController = TextEditingController();
  String _passwordValidatingError = '';
  bool validData = false;
  bool passwordEyeVisible = false;

  void onLogin({required String email, required String password}) {
    // MOCK DATA CHECH
    // example@mail.com
    // 1324534789
    // AuthUsecase().login(email: email, password: password);
    context.go('/pincode_create');
  }

  void onValidateData() {
    final emailRegex = RegExp(r'^[a-z0-9]+@[a-z0-9]+\.[a-z0-9]');
    if ((_emailEditingController.text.isNotEmpty &&
            _passwordEditingController.text.isNotEmpty) &&
        emailRegex.hasMatch(_emailEditingController.text)) {
      setState(() {
        _emailValidatingError = '';
        _passwordValidatingError = '';
        validData = true;
      });
      onLogin(
        email: _emailEditingController.text,
        password: _emailEditingController.text,
      );
    } else if (_passwordEditingController.text.isEmpty ||
        _emailEditingController.text.isEmpty) {
      setState(() {
        _emailValidatingError = 'Поле не может быть пустым';
        _passwordValidatingError = 'Поле не может быть пустым';
        validData = false;
      });
    } else {
      setState(() {
        _emailValidatingError = 'Некорректный формат';
        validData = false;
      });
    }
  }

  void onValidateEmailListener(String value) {}

  void onValidatePasswordListener(String value) {}

  @override
  void initState() {
    super.initState();

    _emailEditingController.addListener(() {
      final emailRegex = RegExp(r'^[a-z0-9]+@[a-z0-9]+\.[a-z0-9]');
      if (emailRegex.hasMatch(_emailEditingController.text)) {
        setState(() {
          _emailValidatingError = '';
        });
      }
      if ((_emailEditingController.text.isNotEmpty &&
          _passwordEditingController.text.isNotEmpty)) {
        setState(() {
          validData = true;
        });
      }
      if (_emailEditingController.text.isEmpty) {
        setState(() {
          validData = false;
        });
      }
    });
    _passwordEditingController.addListener(() {
      setState(() {
        passwordEyeVisible = _passwordEditingController.text.isNotEmpty;
      });
      if (_passwordValidatingError.isNotEmpty &&
          _passwordEditingController.text.isNotEmpty) {
        setState(() {
          _passwordValidatingError = '';
        });
      }
      if ((_emailEditingController.text.isNotEmpty &&
          _passwordEditingController.text.isNotEmpty)) {
        setState(() {
          validData = true;
        });
      }
      if (_passwordEditingController.text.isEmpty) {
        setState(() {
          validData = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [
        Divider(height: 26.0, color: Colors.transparent),
        Text('Создание Профиля', style: BrandTextStyleLight.title1ExtraBold),
        Divider(height: 44.0, color: Colors.transparent),
        Column(
          spacing: 8.0,
          children: [
            Text(
              'Без профиля вы не сможете создавать проекты.',
              style: BrandTextStyleLight.captionRegular,
            ),
            Text(
              'В профиле будут храниться результаты проектов и ваши описания.',
              style: BrandTextStyleLight.captionRegular,
            ),
          ],
        ),
        Divider(height: 32.0, color: Colors.transparent),
        Form(
          onChanged: () {
            debugPrint('form changed');
          },
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            spacing: 20.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UiKitInput(
                controller: _emailEditingController,
                onChanged: (value) => onValidateEmailListener(value),
                hintText: 'Имя',
                errorText: _emailValidatingError,
                keyboardType: TextInputType.emailAddress,
              ),
              UiKitInput(
                controller: _emailEditingController,
                onChanged: (value) => onValidateEmailListener(value),
                hintText: 'Отчество',
                errorText: _emailValidatingError,
                keyboardType: TextInputType.emailAddress,
              ),
              UiKitInput(
                controller: _emailEditingController,
                onChanged: (value) => onValidateEmailListener(value),
                hintText: 'Фамилия',
                errorText: _emailValidatingError,
                keyboardType: TextInputType.emailAddress,
              ),
              UiKitInput(
                controller: _emailEditingController,
                onChanged: (value) => onValidateEmailListener(value),
                hintText: 'Дата рождения',
                errorText: _emailValidatingError,
                keyboardType: TextInputType.datetime,
              ),
              UiKitSelect(
                onSelected: (_) {},
                hintText: 'Пол',
                menuItems: [
                  UiKitSelectItem(label: 'Мужской', value: 'male'),
                  UiKitSelectItem(label: 'Женский', value: 'female'),
                ],
              ),
              UiKitInput(
                controller: _emailEditingController,
                onChanged: (value) => onValidateEmailListener(value),
                hintText: 'Почта',
                errorText: _emailValidatingError,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),

        Divider(height: 68.0, color: Colors.transparent),
        UiKitButtonBig(
          text: 'Далее',
          uikitButtonState: validData
              ? UikitButtonState.primary
              : UikitButtonState.inactive,
          onPressed: () => onValidateData(),
        ),
        Divider(height: 32.0, color: Colors.transparent),
      ],
    );
  }
}
