import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matule/layers/domain/usecases/auth_usecase.dart';
import 'package:matule/layers/presentation/screens/auth/auth_layout.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';
import 'package:matule_uikit/widgets/font/brand_text_style_light.dart';

class PincodeScreen extends StatefulWidget {
  const PincodeScreen({super.key});

  @override
  State<PincodeScreen> createState() => _PincodeScreenState();
}

class _PincodeScreenState extends State<PincodeScreen> {
  List<int> pinPad = [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 0, 13];
  List<int> code = [];

  void onPinCharAdd(int char) {
    if (code.length < 4) {
      setState(() {
        code.add(char);
      });
      if (code.length == 4) {
        AuthUsecase().verifyPinCode(code).then((res) {
          if (res != null) {
            context.go('/home');
          } else {
            setState(() {
              code = [];
            });
          }
        });
      }
    }
  }

  void onPnCharDelete() {
    if (code.isNotEmpty) {
      setState(() {
        code.remove(code.last);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [
        Divider(height: 94.0, color: Colors.transparent),
        Column(
          spacing: 16.0,
          children: [
            Text('Вход', style: BrandTextStyleLight.title1ExtraBold),
            Text('', style: BrandTextStyleLight.textRegular),
          ],
        ),
        Divider(height: 56.0, color: Colors.transparent),
        Container(
          height: 18.0,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: Row(
            spacing: 12.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...[1, 2, 3, 4].map((toElement) {
                return Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    color: code.length >= toElement
                        ? BrandColors.accent
                        : BrandColors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: BoxBorder.all(
                      color: BrandColors.accent,
                      width: 1.0,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        Divider(height: 60.0, color: Colors.transparent),
        GridView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 24.0,
            crossAxisSpacing: 24.0,
          ),
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: [
            ...pinPad.map((int elem) {
              if (elem == 11) {
                return SizedBox();
              }
              if (elem == 13) {
                return IconButton(
                  onPressed: () => onPnCharDelete(),
                  icon: Icon(CupertinoIcons.delete_left),
                );
              }
              return TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(BrandColors.inputBg),
                  overlayColor: WidgetStatePropertyAll(BrandColors.accent),
                  foregroundColor: WidgetStateColor.resolveWith((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return BrandColors.white;
                    }
                    return BrandColors.black;
                  }),
                ),
                onPressed: () => onPinCharAdd(elem),
                child: Text(
                  '$elem',
                  style: TextStyle(
                    fontWeight: FontWeight(600),
                    fontSize: 24.0,
                    letterSpacing: 0.33,
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
