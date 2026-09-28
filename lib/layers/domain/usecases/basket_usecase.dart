import 'dart:async';
import 'package:matule/layers/data/datasource/network/api_client.dart';
import 'package:matule/layers/domain/usecases/api_usecase.dart';
import 'package:matule/layers/domain/usecases/auth_usecase.dart';
import 'package:matule_api/matule_api.dart';

class BasketUsecase {
  BasketUsecase._();
  ApiUsecase _apiUsecase = ApiUsecase(apiClient);
  AuthUsecase _authUsecase = AuthUsecase();
  List<ProductItem> _productList = [];

  StreamController<List<ProductItem>> _streamController =
      StreamController<List<ProductItem>>.broadcast();
  Stream<List<ProductItem>> get getBasketStream =>
      _streamController.stream.asBroadcastStream();

  static BasketUsecase? _instance;

  factory BasketUsecase() {
    _instance ??= BasketUsecase._();
    return _instance!;
  }

  List<ProductItem> get getBasket => _productList;

  Future<List<ProductItem>> addProductToBasket({
    required ProductItem product,
    required int count,
  }) async {
    _productList.add(product);
    _streamController.add(_productList);
    return _productList;
  }

  List<ProductItem> removeProductFromBasket({required ProductItem product}) {
    _productList.remove(product);
    _streamController.add(_productList);
    return _productList;
  }

  Future<void> creatOrder() async {
    _productList = [];
    _streamController.add(_productList);
  }
}
