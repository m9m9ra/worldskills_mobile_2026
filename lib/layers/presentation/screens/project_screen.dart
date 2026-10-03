import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matule/layers/data/datasource/network/api_client.dart';
import 'package:matule/layers/domain/usecases/api_usecase.dart';
import 'package:matule_api/models.dart';
import 'package:matule_uikit/widgets/card/uikit_card_base.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';
import 'package:matule_uikit/widgets/font/brand_text_style_light.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Project>> getProjectList() async {
    return await ApiUsecase(apiClient).getProjects();
  }

  void onProjectOpen() {
    context.push('/project/create');
  }

  void onProjectCreate() {
    context.push('/project/create');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            animateColor: false,
            actionsPadding: EdgeInsets.symmetric(horizontal: 18.0),
            title: Text('Проекты', style: BrandTextStyleLight.title2SemiBold),
            actions: [
              IconButton(
                iconSize: 24.0,
                color: BrandColors.black,
                onPressed: () => onProjectCreate(),
                icon: Icon(CupertinoIcons.plus),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                Divider(height: 18.0, color: Colors.transparent),
                FutureBuilder(
                  future: getProjectList(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        width: double.maxFinite,
                        height: MediaQuery.sizeOf(context).height * 0.6,
                        alignment: Alignment.center,
                        child: CupertinoActivityIndicator(radius: 12.0),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...snapshot.data!.map((Project project) {
                          return UiKitCard.project(
                            title: project.title,
                            subTitle: 'Прошло 2 дня',
                            onCardTap: () => onProjectOpen(),
                            buttonText: "Открыть",
                            onPrimaryButtonTap: () => onProjectOpen(),
                          );
                        }),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
