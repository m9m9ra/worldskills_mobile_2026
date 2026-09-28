import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matule/layers/data/datasource/network/api_client.dart';
import 'package:matule/layers/domain/usecases/api_usecase.dart';
import 'package:matule_api/matule_api.dart';
import 'package:matule_uikit/matule_uikit.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class ProjectCreateScreen extends StatefulWidget {
  const ProjectCreateScreen({super.key});

  @override
  State<ProjectCreateScreen> createState() => _ProjectCreateScreenState();
}

class _ProjectCreateScreenState extends State<ProjectCreateScreen> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _dateCreateEditingController = TextEditingController();
  TextEditingController _endDateEditingController = TextEditingController();
  TextEditingController _mailSourceEditingController = TextEditingController();
  List<TextEditingController> get _observableControllerList => [
    _nameEditingController,
    _dateCreateEditingController,
    _endDateEditingController,
    _mailSourceEditingController,
  ];

  List<AssetEntity> _mediaList = [];
  String? _currentImagePath;
  bool isValidData = false;

  String? type;
  String? name;
  DateTime? createAt;
  DateTime? endAt;
  String? from;
  String? mailSource;
  String? category;
  String? uri;

  @override
  void initState() {
    super.initState();
    _initializePicker();
    Map<TextEditingController, bool> isValidConrollerData = {
      _nameEditingController: false,
      _dateCreateEditingController: false,
      _endDateEditingController: false,
      _mailSourceEditingController: false,
    };
    _observableControllerList.forEach((TextEditingController controller) {
      controller.addListener(() {
        isValidConrollerData[controller] = controller.text.isNotEmpty;
        bool validData = isValidConrollerData.values.every((bool val) => val);
        debugPrint(
          "\n\n controller.text.isNotEmpty: ${controller.text.isNotEmpty} \n validData: $validData",
        );
        setState(() {
          isValidData = validData;
        });
      });
    });
  }

  Future<void> _initializePicker() async {
    // 1. Запрос разрешений на галерею
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      // Получаем только фото, сортируем по дате добавления (новые сверху)
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );
      if (albums.isNotEmpty) {
        List<AssetEntity> media = await albums[0].getAssetListRange(
          start: 0,
          end: 30,
        );
        setState(() {
          _mediaList = media;
        });
        debugPrint("_initializePicker: $_mediaList");
      }
    }
  }

  Future<void> onPlusFile(BuildContext context) async {
    UiKitBottomSheet.showSnappingBottomSheet(context, [
      GridView.builder(
        padding: const EdgeInsets.all(4),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 колонки, как в Telegram
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        // +1 элемент для ячейки камеры
        itemCount: _mediaList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () {
                // Логика по клику на камеру (например, сделать снимок)
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.black,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.videocam_off, color: Colors.white),
                    const Icon(
                      Icons.camera_alt,
                      color: Colors.white70,
                      size: 32,
                    ),
                  ],
                ),
              ),
            );
          }

          final AssetEntity asset = _mediaList[index - 1];
          return GestureDetector(
            onTap: () {
              PhotoManagerPlugin().getFullFile(asset.id, isOrigin: false).then((
                String? path,
              ) {
                setState(() {
                  _currentImagePath = path;
                });
              });
              Navigator.pop(context, asset);
            },
            child: AssetEntityImage(
              asset,
              isOriginal: false,
              thumbnailSize: const ThumbnailSize(200, 200),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    ]);
  }

  Future<void> onProjectCreate() async {
    if (isValidData) {
      ApiUsecase(apiClient)
          .createProject(projectToMap(), imagePath: _currentImagePath)
          .then((Project project) {
            debugPrint(project.toString());
            // ignore: use_build_context_synchronously
            context.go('/project');
          });
    }
  }

  Map<String, String> projectToMap() => {
    "type": type.toString(),
    "name": name.toString(),
    "createAt": createAt.toString(),
    "endAt": endAt.toString(),
    "from": from.toString(),
    "mailSource": mailSource.toString(),
    "category": category.toString(),
    "uri": uri.toString(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
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
            Column(
              spacing: 16.0,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Тип', style: BrandTextStyleLight.captionRegular),
                    const SizedBox(height: 8),
                    UiKitSelect(
                      onSelected: (val) {
                        setState(() {
                          type = val;
                        });
                      },
                      hintText: 'Выберите тип',
                      menuItems: [
                        UiKitSelectItem(label: 'Тип 1', value: '0'),
                        UiKitSelectItem(label: 'Тип 2', value: '1'),
                      ],
                    ),
                  ],
                ),
                UiKitInput(
                  labelText: "Название проекта",
                  hintText: "Введите имя",
                  controller: _nameEditingController,
                  onChanged: (value) => name = value,
                  keyboardType: TextInputType.text,
                ),
                UiKitInput(
                  labelText: "Дата начала",
                  hintText: "--.--.----",
                  controller: _dateCreateEditingController,
                  onChanged: (value) {
                    createAt = DateTime.now();
                  },
                  keyboardType: TextInputType.datetime,
                ),
                UiKitInput(
                  labelText: "Дата Окончания",
                  hintText: "--.--.----",
                  controller: _endDateEditingController,
                  onChanged: (value) {
                    endAt = DateTime(20230);
                  },
                  keyboardType: TextInputType.datetime,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Кому', style: BrandTextStyleLight.captionRegular),
                    const SizedBox(height: 8),
                    UiKitSelect(
                      onSelected: (e) {
                        from = e;
                      },
                      hintText: 'Выберите  кому',
                      menuItems: [
                        UiKitSelectItem(label: '', value: '2'),
                        UiKitSelectItem(label: '', value: '3'),
                      ],
                    ),
                  ],
                ),
                UiKitInput(
                  labelText: "Источник описания",
                  hintText: "example.com",
                  controller: _mailSourceEditingController,
                  onChanged: (value) {
                    endAt = DateTime(20230);
                  },
                  keyboardType: TextInputType.datetime,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Категория',
                      style: BrandTextStyleLight.captionRegular,
                    ),
                    const SizedBox(height: 8),
                    UiKitSelect(
                      onSelected: (e) {
                        category = e;
                      },
                      hintText: 'Выберите  категорию',
                      menuItems: [
                        UiKitSelectItem(label: '', value: '5'),
                        UiKitSelectItem(label: '', value: '5'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(height: 38.0, color: Colors.transparent),
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: BrandColors.inputBg,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // alignment: Alignment.center,
                child: _currentImagePath != null
                    ? GestureDetector(
                        onTap: () => onPlusFile(context),
                        child: Image.file(
                          File(_currentImagePath!),
                          fit: BoxFit.cover,
                        ),
                      )
                    : IconButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () => onPlusFile(context),
                        icon: Icon(
                          CupertinoIcons.plus,
                          size: 80.0,
                          weight: 1,
                          color: BrandColors.description,
                        ),
                      ),
              ),
            ),
            Divider(height: 32.0, color: Colors.transparent),
            UiKitButtonBig(
              text: 'Подтвердить',
              uikitButtonState: isValidData
                  ? UikitButtonState.primary
                  : UikitButtonState.inactive,
              onPressed: () => onProjectCreate(),
            ),
            Divider(height: 20.0, color: Colors.transparent),
          ],
        ),
      ),
    );
  }
}
