import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/cart/data/cart_model.dart';

class CartRepo {
  final ApiService _apiService = ApiService();

  // AddTOCart
  Future<void> addToCart(CartRequestModel cartData) async {
    try {
      final response = await _apiService.post('/cart/add', cartData.toJson());
      
      if (response['code'] == 200 && response['data'] == null) {
        throw ApiError(message: response['message']);
      }
    } on Exception catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // GetCart
  Future<GetCartResponse?> getCartData() async {
    try {
      final response = await _apiService.get('/cart');
      if (response is ApiError) {
        throw ApiError(message: response.message);
      }
      return GetCartResponse.fromJson(response);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // delete Cart item
  Future<void> removeCardItem(int id) async {
    try {
      final response = await _apiService.delete('/cart/remove/$id', {});
      if (response['code'] == 200 && response['data'] == null) {
        throw ApiError(message: response['message']);
      }
    } catch (e) {
      throw ApiError(message: 'Remove item From Cart :${e.toString()}');
    }
  }
}
