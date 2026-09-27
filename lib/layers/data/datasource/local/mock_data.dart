import 'package:matule_api/models.dart';

abstract class MockData {
  static final User mockUser = User(
    id: "user_ws_2026",
    collectionId: "users",
    collectionName: "users",
    created: "2026-01-01T00:00:00Z",
    updated: "2026-01-02T00:00:00Z",
    firstname: "Иван",
    lastname: "Иванов",
    secondname: "Иванович",
    emailVisibility: true,
    verified: true,
    datebirthday: "1995-05-15",
    gender: "male",
  );

  static final ResponseAuth mockAuth = ResponseAuth(
    record: mockUser,
    token: "mock_jwt_token_for_worldskills_testing",
  );

  static final ResponseRegister mockRegister = ResponseRegister(
    id: "user_ws_2026",
    collectionId: "users",
    collectionName: "users",
    created: "2026-01-01T00:00:00Z",
    updated: "2026-01-01T00:00:00Z",
    emailVisibility: true,
    firstname: "Иван",
    lastname: "Иванов",
    secondname: "Иванович",
    verified: false,
    datebirthday: "1995-05-15",
    gender: "male",
  );

  static final List<News> mockNews = [
    News(
      id: "news_1",
      collectionId: "news",
      collectionName: "news",
      newsImage: "news_0.png", // Красный кроссовок
      created: "2026-09-19",
      updated: "2026-09-19",
    ),
    News(
      id: "news_2",
      collectionId: "news",
      collectionName: "news",
      newsImage: "news_1.png", // Стильный кроссовок
      created: "2026-09-20",
      updated: "2026-09-20",
    ),
  ];

  static final List<ProductItem> mockCatalog = [
    ProductItem(id: "p1", title: "Nike Air Max Plus", price: 14900, typeCloses: "Мужчинам", type: "Бег"),
    ProductItem(id: "p2", title: "Adidas Forum Low", price: 11200, typeCloses: "Женщинам", type: "Стрит"),
    ProductItem(id: "p3", title: "Puma RS-X Bold", price: 9800, typeCloses: "Мужчинам", type: "Спорт"),
    ProductItem(id: "p5", title: "Asics Kayano", price: 8500, typeCloses: "Мужчинам", type: "Бег"),
    ProductItem(id: "p6", title: "Asics Gel", price: 6500, typeCloses: "Женщинам", type: "Бег"),
    ProductItem(id: "p7", title: "Nike x Asics Gel-Kayano", price: 12200, typeCloses: "Популярное", type: "Бег"),
  ];

  static final List<Project> mockProjects = [
    Project(id: "proj_1", title: "Моя осенняя коллекция", user_id: "user_ws_2026", image: "https://unsplash.com"),
    Project(id: "proj_2", title: "Кастомные Air Force", user_id: "user_ws_2026", image: "https://unsplash.com"),
  ];
}
