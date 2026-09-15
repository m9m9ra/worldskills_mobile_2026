import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class RootScreen extends StatefulWidget {
  RootScreen({super.key, required this.statefulNavigationShell});
  StatefulNavigationShell statefulNavigationShell;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: widget.statefulNavigationShell,
      ),
    );
  }
}
