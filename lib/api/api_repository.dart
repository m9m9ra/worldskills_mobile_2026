// import '../layers/domain/repository/api_client.dart';
// import '../layers/domain/repository/models.dart';

// class ApiRepository {
//   final ApiClient _client;
//   ApiRepository(this._client);

//   // 1) Авторизация
//   Future<ResponseAuth> login({required String email, required String password}) async {
//     final data = await _client.post('/collections/users/auth-with-password', body: {
//       'identity': email,
//       'password': password,
//     });
//     final authResponse = ResponseAuth.fromJson(data);
//     _client.updateToken(authResponse.token); // Сохраняем токен в клиенте
//     return authResponse;
//   }

//   // 2) Создание пользователя (Регистрация)
//   Future<ResponseRegister> register({required String email, required String password, required String passwordConfirm}) async {
//     final data = await _client.post('/collections/users/records', body: {
//       'email': email,
//       'password': password,
//       'passwordConfirm': passwordConfirm,
//     });
//     return ResponseRegister.fromJson(data);
//   }

//   // 3) Изменение профиля
//   Future<User> updateProfile({required String userId, Map<String, String> fields = const {}, String? avatarPath}) async {
//     final data = await _client.patchMultipart(
//       '/collections/users/records/$userId',
//       fields,
//       filePath: avatarPath,
//       fileKey: 'avatar',
//     );
//     return User.fromJson(data);
//   }

//   // 4) Получение акций
//   Future<List<News>> getNews() async {
//     final data = await _client.get('/collections/news/records');
//     final List items = data['items'] ?? [];
//     return items.map((e) => News.fromJson(e)).toList();
//   }

//   // 5) Получение каталога
//   Future<List<ProductItem>> getCatalog() async {
//     final data = await _client.get('/collections/products/records');
//     final List items = data['items'] ?? [];
//     return items.map((e) => ProductItem.fromJson(e)).toList();
//   }

//   // 6) Поиск
//   Future<List<ProductItem>> searchProducts(String query) async {
//     final data = await _client.get('/collections/products/records', queryParams: {
//       'filter': "(title ?~ '$query')",
//     });
//     final List items = data['items'] ?? [];
//     return items.map((e) => ProductItem.fromJson(e)).toList();
//   }

//   // 7) Получение описания товара
//   Future<Product> getProductDetail(String productId) async {
//     final data = await _client.get('/collections/products/records/$productId');
//     return Product.fromJson(data);
//   }

//   // 8) Добавление в корзину
//   Future<ResponseCart> addToCart({required String userId, required String productId, required int count}) async {
//     final data = await _client.post('/collections/cart/records', body: {
//       'user_id': userId,
//       'product_id': productId,
//       'count': count,
//     });
//     return ResponseCart.fromJson(data);
//   }

//   // 9) Изменение корзины
//   Future<ResponseCart> updateCart({required String cartId, required Map<String, String> fields}) async {
//     final data = await _client.patchMultipart('/collections/cart/records/$cartId', fields);
//     return ResponseCart.fromJson(data);
//   }

//   // 10) Оформление заказа
//   Future<ResponseOrder> createOrder({required String userId, required String productId, required int count}) async {
//     final data = await _client.post('/collections/orders/records', body: {
//       'user_id': userId,
//       'product_id': productId,
//       'count': count,
//     });
//     return ResponseOrder.fromJson(data);
//   }

//   // 11) Список проектов
//   Future<List<Project>> getProjects() async {
//     final data = await _client.get('/collections/project/records');
//     final List items = data['items'] ?? [];
//     return items.map((e) => Project.fromJson(e)).toList();
//   }

//   // 12) Создание проекта
//   Future<Project> createProject(Map<String, String> fields, {String? imagePath}) async {
//     final data = await _client.patchMultipart(
//       '/collections/project/records', // Swagger использует POST для создания, но multipart обертку можно использовать
//       fields,
//       filePath: imagePath,
//       fileKey: 'image',
//     );
//     return Project.fromJson(data);
//   }

//   // 13) Получение информации о профиле
//   Future<User> getUserProfile(String userId) async {
//     final data = await _client.get('/collections/users/records/$userId');
//     return User.fromJson(data);
//   }

//   // 14) Выход
//   void logout() {
//     _client.updateToken(null); // Сбрасываем сохраненный локально сессионный токен
//   }
// }
