import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/model/topping_model.dart';

class ProductRepo {
  ApiService apiService = ApiService();

  // get procuts
  Future<List<ProductModel?>> getProduct() async {
    try {
      final response = await apiService.get('/products');
      return (response['data'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // get Topping
  Future<List<ToppingModel?>> getTopping() async {
    try {
      final response = await apiService.get('/toppings');
      return (response['data'] as List)
          .map((topping) => ToppingModel.fromJson(topping))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // get Opthions
  Future<List<ToppingModel?>> getOptions() async {
    try {
      final response = await apiService.get('/side-options');
      return (response['data'] as List)
          .map((topping) => ToppingModel.fromJson(topping))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // search
  Future<List<ProductModel>> searchProducts(String name) async {
    try {
      final response = await apiService.get('/products', param: {'name': name});
      return (response['data'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
