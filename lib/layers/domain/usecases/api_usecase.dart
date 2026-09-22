import 'package:matule_api/api_repository.dart';
import 'package:matule_api/models.dart';
import 'package:matule/layers/data/datasource/local/mock_data.dart';

class ApiUsecase extends ApiRepository {
  ApiUsecase(super.client);

  // Вспомогательный метод для имитации задержки сети (1 секунда)
  Future<void> _simulatedDelay() => Future.delayed(const Duration(seconds: 1));

  // 1) Авторизация
  @override
  Future<ResponseAuth> login({
    required String email,
    required String password,
  }) async {
    await _simulatedDelay();
    return MockData.mockAuth;
  }

  // 2) Регистрация
  @override
  Future<ResponseRegister> register({
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    await _simulatedDelay();
    return MockData.mockRegister;
  }

  // 3) Изменение профиля
  @override
  Future<User> updateProfile({
    required String userId,
    Map<String, String> fields = const {},
    String? avatarPath,
  }) async {
    await _simulatedDelay();
    return MockData.mockUser;
  }

  // 4) Получение акций (News)
  @override
  Future<List<News>> getNews() async {
    await _simulatedDelay();
    return MockData.mockNews;
  }

  // 5) Получение каталога
  @override
  Future<List<ProductItem>> getCatalog() async {
    await _simulatedDelay();
    return MockData.mockCatalog;
  }

  // 6) Поиск
  @override
  Future<List<ProductItem>> searchProducts(String query) async {
    await _simulatedDelay();
    if (query.isEmpty) return MockData.mockCatalog;
    // Фильтруем локально по вхождению строки
    return MockData.mockCatalog
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // 7) Детали товара
  @override
  Future<Product> getProductDetail(String productId) async {
    await _simulatedDelay();
    // Ищем товар в каталоге и маппим в детальную модель Product
    final item = MockData.mockCatalog.firstWhere(
      (p) => p.id == productId,
      orElse: () => MockData.mockCatalog.first,
    );
    return Product(
      id: item.id,
      title: item.title,
      price: item.price,
      typeCloses: item.typeCloses,
      type: item.type,
      description:
          "Превосходные кроссовки премиального качества. Идеально подходят для условий WorldSkills!",
      approximateCost: "${item.price} ₽",
    );
  }

  // 8) Добавление в корзину
  @override
  Future<ResponseCart> addToCart({
    required String userId,
    required String productId,
    required int count,
  }) async {
    await _simulatedDelay();
    return ResponseCart(
      id: "cart_${DateTime.now().millisecondsSinceEpoch}",
      userId: userId,
      productId: productId,
      count: count,
    );
  }

  // 9) Изменение корзины
  @override
  Future<ResponseCart> updateCart({
    required String cartId,
    required Map<String, String> fields,
  }) async {
    await _simulatedDelay();
    return ResponseCart(
      id: cartId,
      userId: "user_ws_2026",
      productId: "p1",
      count: int.tryParse(fields['count'] ?? '1') ?? 1,
    );
  }

  // 10) Оформление заказа
  @override
  Future<ResponseOrder> createOrder({
    required String userId,
    required String productId,
    required int count,
  }) async {
    await _simulatedDelay();
    return ResponseOrder(
      id: "order_${DateTime.now().millisecondsSinceEpoch}",
      userId: userId,
      productId: productId,
      count: count,
    );
  }

  // 11) Список проектов
  @override
  Future<List<Project>> getProjects() async {
    await _simulatedDelay();
    return MockData.mockProjects;
  }

  // 12) Создание проекта
  @override
  Future<Project> createProject(
    Map<String, String> fields, {
    String? imagePath,
  }) async {
    await _simulatedDelay();
    return Project(
      id: "proj_${DateTime.now().millisecondsSinceEpoch}",
      title: fields['title'] ?? 'Новый проект',
      user_id: "user_ws_2026",
      image: "https://unsplash.com",
    );
  }

  // 13) Получение информации о профиле
  @override
  Future<User> getUserProfile(String userId) async {
    await _simulatedDelay();
    return MockData.mockUser;
  }

  // 14) Выход
  @override
  void logout() {
    // Просто зануляем токен (в моках это ни на что не повлияет)
  }
}
