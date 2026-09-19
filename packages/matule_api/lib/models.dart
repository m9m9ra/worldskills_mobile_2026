// --- Модели Пользователя и Авторизации ---
class User {
  final String id;
  final String collectionId;
  final String collectionName;
  final String created;
  final String updated;
  final String? firstname;
  final String? lastname;
  final String? secondname;
  final bool? emailVisibility;
  final bool? verified;
  final String? datebirthday;
  final String? gender;

  User({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    this.firstname,
    this.lastname,
    this.secondname,
    this.emailVisibility,
    this.verified,
    this.datebirthday,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    collectionId: json['collectionId'],
    collectionName: json['collectionName'],
    created: json['created'],
    updated: json['updated'],
    firstname: json['firstname'],
    lastname: json['lastname'],
    secondname: json['secondname'],
    emailVisibility: json['emailVisibility'],
    verified: json['verified'],
    datebirthday: json['datebirthday'],
    gender: json['gender'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'collectionId': collectionId,
    'collectionName': collectionName,
    'created': created,
    'updated': updated,
    'firstname': firstname,
    'lastname': lastname,
    'secondname': secondname,
    'emailVisibility': emailVisibility,
    'verified': verified,
    'datebirthday': datebirthday,
    'gender': gender,
  };
}

class ResponseAuth {
  final User record;
  final String token;

  ResponseAuth({required this.record, required this.token});

  factory ResponseAuth.fromJson(Map<String, dynamic> json) =>
      ResponseAuth(record: User.fromJson(json['record']), token: json['token']);
}

// --- Модели Магазина и Товаров ---
class News {
  final String id;
  final String collectionId;
  final String collectionName;
  final String newsImage;
  final String created;
  final String updated;

  News({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.newsImage,
    required this.created,
    required this.updated,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json['id'],
    collectionId: json['collectionId'],
    collectionName: json['collectionName'],
    newsImage: json['newsImage'] ?? '',
    created: json['created'],
    updated: json['updated'],
  );
}

class ProductItem {
  final String id;
  final String title;
  final int price;
  final String? typeCloses;
  final String? type;

  ProductItem({
    required this.id,
    required this.title,
    required this.price,
    this.typeCloses,
    this.type,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
    id: json['id'],
    title: json['title'] ?? '',
    price: json['price'] ?? 0,
    typeCloses: json['typeCloses'],
    type: json['type'],
  );
}

class Product {
  final String id;
  final String title;
  final String? description;
  final int price;
  final String? typeCloses;
  final String? type;
  final String? approximateCost;

  Product({
    required this.id,
    required this.title,
    this.description,
    required this.price,
    this.typeCloses,
    this.type,
    this.approximateCost,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    title: json['title'] ?? '',
    description: json['description'],
    price: json['price'] ?? 0,
    typeCloses: json['typeCloses'],
    type: json['type'],
    approximateCost: json['approximateCost'],
  );
}

// --- Модели Корзины и Заказа ---
class ResponseCart {
  final String id;
  final String userId;
  final String productId;
  final int count;

  ResponseCart({
    required this.id,
    required this.userId,
    required this.productId,
    required this.count,
  });

  factory ResponseCart.fromJson(Map<String, dynamic> json) => ResponseCart(
    id: json['id'],
    userId: json['user_id'] ?? '',
    productId: json['product_id'] ?? '',
    count: json['count'] ?? 0,
  );
}

class ResponseOrder {
  final String id;
  final String userId;
  final String productId;
  final int count;

  ResponseOrder({
    required this.id,
    required this.userId,
    required this.productId,
    required this.count,
  });

  factory ResponseOrder.fromJson(Map<String, dynamic> json) => ResponseOrder(
    id: json['id'],
    userId: json['user_id'] ?? '',
    productId: json['product_id'] ?? '',
    count: json['count'] ?? 0,
  );
}

class ResponseRegister {
  String? collectionId;
  String? collectionName;
  String? created;
  bool? emailVisibility;
  String? firstname;
  String? id;
  String? lastname;
  String? secondname;
  String? updated;
  bool? verified;
  String? datebirthday;
  String? gender;

  ResponseRegister({
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.emailVisibility,
    required this.firstname,
    required this.id,
    required this.lastname,
    required this.secondname,
    required this.updated,
    required this.verified,
    required this.datebirthday,
    required this.gender,
  });

  factory ResponseRegister.fromJson(Map<String, dynamic> json) =>
      ResponseRegister(
        collectionId: json['collectionId'],
        collectionName: json['collectionName'],
        created: json['created'],
        emailVisibility: json['emailVisibility'],
        firstname: json['firstname'],
        id: json['id'],
        lastname: json['lastname'],
        secondname: json['secondname'],
        updated: json['updated'],
        verified: json['verified'],
        datebirthday: json['datebirthday'],
        gender: json['gender'],
      );
}

// --- Модели Проектов ---
class Project {
  final String id;
  final String title;
  final String? user_id;
  final String? image;

  Project({required this.id, required this.title, this.user_id, this.image});

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json['id'],
    title: json['title'] ?? '',
    user_id: json['user_id'],
    image: json['image'],
  );
}
