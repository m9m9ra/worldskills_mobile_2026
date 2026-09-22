import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matule/layers/domain/usecases/auth_usecase.dart';
import 'package:matule/layers/presentation/screens/auth/auth_layout.dart';
import 'package:matule_uikit/matule_uikit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    AuthUsecase().login(email: email, password: password);
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
        Divider(height: 60.0, color: Colors.transparent),
        Row(
          spacing: 16.0,
          children: [
            Text('✋', style: BrandTextStyleLight.title1ExtraBold),
            Text(
              'Добро пожаловать!',
              style: BrandTextStyleLight.title1ExtraBold,
            ),
          ],
        ),
        Divider(height: 25.0, color: Colors.transparent),
        Text(
          'Войдите, чтобы пользоваться функциями приложения',
          style: BrandTextStyleLight.textRegular,
        ),
        Divider(height: 64.0, color: Colors.transparent),
        Column(
          spacing: 14.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UiKitInput(
              controller: _emailEditingController,
              onChanged: (value) => onValidateEmailListener(value),
              labelText: 'Вход по E-mail',
              hintText: 'example@mail.com',
              errorText: _emailValidatingError,
              keyboardType: TextInputType.emailAddress,
            ),
            UiKitInput(
              controller: _passwordEditingController,
              onChanged: (value) => onValidatePasswordListener(value),
              labelText: 'Пароль',
              hintText: '',
              isPassword: passwordEyeVisible,
              errorText: _passwordValidatingError,
            ),
            UiKitButtonBig(
              text: 'Далее',
              uikitButtonState: validData
                  ? UikitButtonState.primary
                  : UikitButtonState.inactive,
              onPressed: () => onValidateData(),
            ),
            InkWell(
              onTap: () {
                context.go('/login/signin');
              },
              child: Text(
                'Зарегистрироваться',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight(400),
                  fontSize: 15.0,
                  color: BrandColors.accent,
                ),
              ),
            ),
          ],
        ),

        Divider(height: 56.0, color: Colors.transparent),
        Column(
          spacing: 14.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Или войдите с помощью',
              textAlign: TextAlign.center,
              style: BrandTextStyleLight.textRegular,
            ),
            UiKitButtonLoginVk(onPressed: () {}),
            UiKitButtonLoginYadex(onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
