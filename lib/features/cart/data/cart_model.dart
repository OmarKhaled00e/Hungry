
class CartModel {
  final int productId;
  final int quantity;
  final double spicy;
  final List<int> toppings;
  final List<int> options;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.toppings,
    required this.options,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'spicy': spicy,
      'toppings': toppings,
      'side_options': options,
    };
  }
}

// -------------------------

class CartRequestModel {
  final List<CartModel> items;

  CartRequestModel({required this.items});

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

// -------------------------

class GetCartResponse {
  final int code;
  final String message;
  final CartData cartData;

  GetCartResponse({
    required this.code,
    required this.message,
    required this.cartData,
  });

  factory GetCartResponse.fromJson(Map<String, dynamic> json) {
    return GetCartResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      cartData: CartData.fromJson(json['data'] ?? {}),
    );
  }
}

// -------------------------

class CartData {
  final int id;
  final double totalPrice;
  final List<CartItemModel> items;

  CartData({
    required this.id,
    required this.totalPrice,
    required this.items,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['id'] ?? 0,
      totalPrice: double.tryParse(json['total_price']?.toString() ?? '0') ?? 0.0,
      items: (json['items'] as List? ?? [])
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
    );
  }
}

// -------------------------

class CartItemModel {
  final int productId;
  final String name;
  final int itemId;
  final String image;
  final int quantity;
  final String price;
  final double spicy;

  CartItemModel({
    required this.productId,
    required this.name,
    required this.itemId,
    required this.image,
    required this.quantity,
    required this.price,
    required this.spicy,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['product_id'] ?? 0,
      name: json['name'] ?? '',
      itemId: json['item_id'] ?? 0,
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 1,
      price: json['price']?.toString() ?? '0',
      spicy: double.tryParse(json['spicy']?.toString() ?? '0') ?? 0.0,
    );
  }
}
