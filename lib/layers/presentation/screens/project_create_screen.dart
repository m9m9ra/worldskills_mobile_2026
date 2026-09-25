import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matule_uikit/matule_uikit.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class ProjectCreateScreen extends StatefulWidget {
  const ProjectCreateScreen({super.key});

  @override
  State<ProjectCreateScreen> createState() => _ProjectCreateScreenState();
}

class _ProjectCreateScreenState extends State<ProjectCreateScreen> {
  List<AssetEntity> _mediaList = [];
  bool isValidData = false;

  @override
  void initState() {
    super.initState();
    _initializePicker();
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
              // Возвращаем выбранный ассет на предыдущий экран
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

  void onProjectCreate() {}

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
            Divider(height: 38.0, color: Colors.transparent),
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: BrandColors.inputBg,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: IconButton(
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
              uikitButtonState: isValidData ? UikitButtonState.primary : UikitButtonState.inactive,
              onPressed: () => onProjectCreate(),
            ),
            Divider(height: 20.0, color: Colors.transparent),
          ],
        ),
      ),
    );
  }
}
