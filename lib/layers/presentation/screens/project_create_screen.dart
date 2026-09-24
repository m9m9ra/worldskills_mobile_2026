import 'package:flutter/material.dart';
import 'package:matule_uikit/widgets/font/brand_text_style_light.dart';

class ProjectCreateScreen extends StatefulWidget {
  const ProjectCreateScreen({super.key});

  @override
  State<ProjectCreateScreen> createState() => _ProjectCreateScreenState();
}

class _ProjectCreateScreenState extends State<ProjectCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              animateColor: false,
              automaticallyImplyLeading: false,
              title: Text(
                'Создать проект',
                style: BrandTextStyleLight.title2SemiBold,
              ),
            ),
            Divider(height: 18.0, color: Colors.transparent),
          ],
        ),
      ),
    );
  }
}
