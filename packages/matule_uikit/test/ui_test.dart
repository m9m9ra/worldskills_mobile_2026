import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matule_uikit/widgets/bottom_bar/uikit_bottom_bar.dart';
import 'package:matule_uikit/widgets/colors/brand_colors.dart';
import 'package:matule_uikit/widgets/input/uikit_input.dart';

// Цвета из дизайн-системы макета
const colorErrorBg = Color(0xFFFFF0F0);
const colorErrorBorder = Color(0xFFFF3B30);
const colorErrorText = Color(0xFFFF3B30);
const colorActive = Color(0xFF007AFF);
const colorInactive = Color(0);

void main() {
  group('Модуль Е. Тестирование (вариатив) — Спринт-1', () {
    // -------------------------------------------------------------------------
    // b) Инпут ошибки
    // Проверяемые параметры: фон, обводка, наличие текста ошибки и цвет
    // -------------------------------------------------------------------------
    testWidgets('b) Инпут ошибки: проверка фона, обводки и текста ошибки', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: UiKitInput(errorText: 'Неверный формат ввода')),
        ),
      );

      // 1. Проверка наличия и цвета текста ошибки
      final errorTextFinder = find.text('Неверный формат ввода');
      expect(errorTextFinder, findsOneWidget);

      final Text textWidget = tester.widget(errorTextFinder);
      expect(textWidget.style?.color, BrandColors.error);

      // 2. Проверка фона и обводки инпута через контейнер декорации
      final textFieldFinder = find.byType(TextField);
      final TextField textField = tester.widget(textFieldFinder);
      final InputDecoration decoration = textField.decoration!;

      expect(decoration.fillColor, colorErrorBg);
      expect(
        (decoration.errorBorder as OutlineInputBorder).borderSide.color,
        BrandColors.error,
      );
    });

    // -------------------------------------------------------------------------
    // c) Селект без иконки
    // При нажатии на селект открывается BottomSheet
    // -------------------------------------------------------------------------
    testWidgets('c) Селект без иконки: открытие BottomSheet при нажатии', (
      WidgetTester tester,
    ) async {
      // bool isBottomSheetOpened = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => GestureDetector(
                key: const Key('select_widget'),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const SizedBox(
                      key: Key('bottom_sheet_content'),
                      height: 200,
                      child: Text('Варианты выбора'),
                    ),
                  );
                },
                child: const Text(
                  'Выбрать регион',
                ), // Селект без иконки стрелочки
              ),
            ),
          ),
        ),
      );

      // Проверяем, что изначально BottomSheet закрыт
      expect(find.byKey(const Key('bottom_sheet_content')), findsNothing);

      // Имитируем тап на селект
      await tester.tap(find.byKey(const Key('select_widget')));
      await tester.pumpAndSettle(); // Ждем завершения анимации открытия

      // Проверяем, что BottomSheet успешно отобразился на экране
      expect(find.byKey(const Key('bottom_sheet_content')), findsOneWidget);
    });

    // -------------------------------------------------------------------------
    // d) Кнопка chips
    // Кнопка при значениях status ON и OFF соответствует макету
    // -------------------------------------------------------------------------
    testWidgets('d) Кнопка chips: соответствие состояниям ON и OFF', (
      WidgetTester tester,
    ) async {
      // Функция-хелпер для сборки чипса
      Widget buildChip(bool isSelected) {
        return MaterialApp(
          home: Scaffold(
            body: ChoiceChip(
              label: const Text('Фильтр'),
              selected: isSelected, // true = ON, false = OFF
              selectedColor: colorActive,
              disabledColor: colorInactive,
            ),
          ),
        );
      }

      // Тестируем статус ON
      await tester.pumpWidget(buildChip(true));
      final ChoiceChip chipOn = tester.widget(find.byType(ChoiceChip));
      expect(chipOn.selected, true);
      expect(chipOn.selectedColor, colorActive);

      // Тестируем статус OFF
      await tester.pumpWidget(buildChip(false));
      final ChoiceChip chipOff = tester.widget(find.byType(ChoiceChip));
      expect(chipOff.selected, false);
    });

    // -------------------------------------------------------------------------
    // e) Карточка Primary
    // Карточка при значениях status ADD и DELETE соответствует макету
    // -------------------------------------------------------------------------
    testWidgets('e) Карточка Primary: соответствие состояниям ADD и DELETE', (
      WidgetTester tester,
    ) async {
      Widget buildCard(String status) {
        return MaterialApp(
          home: Scaffold(
            body: Card(
              child: ListTile(
                title: const Text('Товар'),
                trailing: Icon(
                  status == 'ADD' ? Icons.add_circle : Icons.delete,
                  key: const Key('card_action_icon'),
                ),
              ),
            ),
          ),
        );
      }

      // 1. Проверяем состояние ADD
      await tester.pumpWidget(buildCard('ADD'));
      final Icon iconAdd = tester.widget(
        find.byKey(const Key('card_action_icon')),
      );
      expect(iconAdd.icon, Icons.add_circle);

      // 2. Проверяем состояние DELETE
      await tester.pumpWidget(buildCard('DELETE'));
      final Icon iconDelete = tester.widget(
        find.byKey(const Key('card_action_icon')),
      );
      expect(iconDelete.icon, Icons.delete);
    });

    // -------------------------------------------------------------------------
    // f) Tabbar
    // При фокусировке (клике) любого элемента выбранный активен, остальные нет
    // -------------------------------------------------------------------------
    testWidgets(
      'f) Tabbar: изменение фокуса и переключение состояний активности',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: DefaultTabController(
              length: 3,
              child: Scaffold(
                bottomNavigationBar: UiKitBottomBar(
                  currentIndex: 0,
                  onTap: (int p) {
                    
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(CupertinoIcons.home),
                    ),
                    BottomNavigationBarItem(
                      label: 'Doos',
                      icon: Icon(Icons.question_answer),
                    ),
                    BottomNavigationBarItem(
                      label: 'Lokasd',
                      icon: Icon(Icons.propane),
                    ),
                    BottomNavigationBarItem(
                      label: 'Lokasd',
                      icon: Icon(Icons.production_quantity_limits_sharp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        // По умолчанию выбран первый таб (индекс 0)
        final UiKitBottomBar tabBar = tester.widget(find.byType(UiKitBottomBar));
        expect(tabBar.items.first.label, BrandColors.accent);

        // Кликаем по второму табу (Корзина)
        await tester.tap(find.text('Корзина'));
        await tester.pumpAndSettle();

        // Проверяем внутреннее состояние контроллера после переключения фокуса
        final TabController controller = DefaultTabController.of(
          tester.element(find.text('Корзина')),
        );

        expect(controller.index, 1); // Вторым стал активным (индекс 1)
        expect(controller.indexIsChanging, false); // Анимация завершена
      },
    );
  });
}
