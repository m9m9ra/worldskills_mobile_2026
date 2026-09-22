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
  final TextEditingController _firstNameEditingController =
      TextEditingController();
  final TextEditingController _lastNameEditingController =
      TextEditingController();
  final TextEditingController _secondNameEditingController =
      TextEditingController();
  final TextEditingController _birthDayEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  List<TextEditingController> get _controllerList => [
    _firstNameEditingController,
    _lastNameEditingController,
    _secondNameEditingController,
    _birthDayEditingController,
    _emailEditingController,
  ];

  String _emailValidatingError = '';
  String? gender;
  bool validData = false;
  bool passwordEyeVisible = false;

  void onSignin({required String email}) {
    // MOCK DATA CHECH
    // example@mail.com
    // 1324534789
    // AuthUsecase().login(email: email, password: password);
    context.go('/login/signin/password', extra: email);
  }

  void onValidateData() {
    if (validData) {
      onSignin(email: _emailEditingController.text);
    }
  }

  void onValidateEmailListener(String value) {}

  void onValidatePasswordListener(String value) {}

  @override
  void initState() {
    super.initState();
    Map<TextEditingController, bool> controllerFilled = {
      _firstNameEditingController: false,
      _lastNameEditingController: false,
      _secondNameEditingController: false,
      _birthDayEditingController: false,
      _emailEditingController: false,
    };
    _controllerList.forEach((TextEditingController controller) {
      controller.addListener(() {
        controllerFilled[controller] = controller.text.isNotEmpty;
        controllerFilled.forEach((controller, val) {
          setState(() {
            validData =
                controllerFilled.values.every((value) => value == true);
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _controllerList.forEach((TextEditingController controller) {
      controller.dispose();
    });
    super.dispose();
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
                controller: _firstNameEditingController,
                onChanged: (value) => onValidateEmailListener(value),
                hintText: 'Имя',
                errorText: _emailValidatingError,
                keyboardType: TextInputType.emailAddress,
              ),
              UiKitInput(
                controller: _lastNameEditingController,
                onChanged: (value) => onValidateEmailListener(value),
                hintText: 'Отчество',
                errorText: _emailValidatingError,
                keyboardType: TextInputType.emailAddress,
              ),
              UiKitInput(
                controller: _secondNameEditingController,
                onChanged: (value) => onValidateEmailListener(value),
                hintText: 'Фамилия',
                errorText: _emailValidatingError,
                keyboardType: TextInputType.emailAddress,
              ),
              UiKitInput(
                controller: _birthDayEditingController,
                onChanged: (value) => onValidateEmailListener(value),
                hintText: 'Дата рождения',
                errorText: _emailValidatingError,
                keyboardType: TextInputType.datetime,
              ),
              UiKitSelect(
                onSelected: (String gender) {
                  setState(() {
                    gender = gender;
                  });
                },
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
