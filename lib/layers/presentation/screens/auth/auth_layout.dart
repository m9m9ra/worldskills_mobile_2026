import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class AuthLayout extends StatefulWidget {
  AuthLayout({super.key, required this.children});
  List<Widget> children;

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle!,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              shrinkWrap: false,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: BouncingScrollPhysics(),
              hitTestBehavior: HitTestBehavior.opaque,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              children: widget.children,
            ),
          ),
        ),
      ),
    );
  }
}
