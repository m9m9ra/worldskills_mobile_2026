import 'package:flutter_test/flutter_test.dart';
// Импортируйте ваши файлы (подправьте пути под свой проект)
import 'package:matule_api/api_client.dart';
import 'package:matule_api/api_repository.dart';
import 'package:matule_api/models.dart';

// 1. Создаем один фейк-клиент для всех тестов
class FakeApiClient implements ApiClient {
  @override
  void updateToken(String? token) {}

  @override
  Future get(String path, {Map<String, String>? queryParams}) async {
    // Возвращаем минимальный валидный JSON-мап под GET запросы
    return {'items': [], 'id': 'test', 'title': 'test', 'price': 0};
  }

  @override
  Future post(String path, {Object? body}) async {
    // Возвращаем минимальный JSON под POST запросы (Auth, Регистрация, Корзина)
    return {'record': {'id': 'test', 'collectionId': '', 'collectionName': '', 'created': '', 'updated': ''}, 'token': 'jwt'};
  }

  @override
  Future patchMultipart(String path, Map<String, String> fields, {String? filePath, String? fileKey}) async {
    return {'id': 'test', 'title': 'test'}; // Для картинок и обновлений
  }
}

void main() {
  late ApiRepository repository;

  setUp(() {
    // Инициализируем репозиторий с нашим фейком
    repository = ApiRepository(FakeApiClient());
  });

  group('Тесты сетевого слоя (Чемпионат):', () {
    test('1) Авторизация', () async {
      expect(await repository.login(email: 'e', password: 'p'), isA<ResponseAuth>());
    });

    test('2) Создание профиля (Регистрация)', () async {
      expect(await repository.register(email: 'e', password: 'p', passwordConfirm: 'p'), isA<ResponseRegister>());
    });

    test('3) Изменение профиля', () async {
      expect(await repository.updateProfile(userId: '1'), isA<User>());
    });

    test('4) Получение акций', () async {
      expect(await repository.getNews(), isA<List<News>>());
    });

    test('5) Получение каталога', () async {
      expect(await repository.getCatalog(), isA<List<ProductItem>>());
    });

    test('6) Поиск', () async {
      expect(await repository.searchProducts('query'), isA<List<ProductItem>>());
    });

    test('7) Получение описания товара', () async {
      expect(await repository.getProductDetail('1'), isA<Product>());
    });

    test('8) Добавление в корзину', () async {
      expect(await repository.addToCart(userId: '1', productId: '1', count: 1), isA<ResponseCart>());
    });

    test('9) Изменение корзины', () async {
      expect(await repository.updateCart(cartId: '1', fields: {}), isA<ResponseCart>());
    });

    test('10) Оформление заказа', () async {
      expect(await repository.createOrder(userId: '1', productId: '1', count: 1), isA<ResponseOrder>());
    });

    test('11) Список проектов', () async {
      expect(await repository.getProjects(), isA<List<Project>>());
    });

    test('12) Создание проекта', () async {
      expect(await repository.createProject({}), isA<Project>());
    });

    test('13) Получение информации о профиле', () async {
      expect(await repository.getUserProfile('1'), isA<User>());
    });

    test('14) Выход', () {
      expect(() => repository.logout(), returnsNormally);
    });
  });
}
