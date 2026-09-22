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
      newsImage: "https://unsplash.com", // Красный кроссовок
      created: "2026-09-19",
      updated: "2026-09-19",
    ),
    News(
      id: "news_2",
      collectionId: "news",
      collectionName: "news",
      newsImage: "https://unsplash.com", // Стильный кроссовок
      created: "2026-09-20",
      updated: "2026-09-20",
    ),
  ];

  static final List<ProductItem> mockCatalog = [
    ProductItem(id: "p1", title: "Nike Air Max Plus", price: 14900, typeCloses: "Шнурки", type: "Бег"),
    ProductItem(id: "p2", title: "Adidas Forum Low", price: 11200, typeCloses: "Липучки", type: "Стрит"),
    ProductItem(id: "p3", title: "Puma RS-X Bold", price: 9800, typeCloses: "Шнурки", type: "Спорт"),
    ProductItem(id: "p4", title: "Asics Gel-Kayano", price: 16500, typeCloses: "Шнурки", type: "Бег"),
  ];

  static final List<Project> mockProjects = [
    Project(id: "proj_1", title: "Моя осенняя коллекция", user_id: "user_ws_2026", image: "https://unsplash.com"),
    Project(id: "proj_2", title: "Кастомные Air Force", user_id: "user_ws_2026", image: "https://unsplash.com"),
  ];
}
