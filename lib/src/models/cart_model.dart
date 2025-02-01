class Cart {
  final int id;
  final int userId;
  final DateTime date;
  final List<ProductOrder> products;
  final int v;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      products: (json['products'] as List)
          .map((item) => ProductOrder.fromJson(item))
          .toList(),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'products': products.map((item) => item.toJson()).toList(),
      '__v': v,
    };
  }
}

class CartList {
  final List<Cart> carts;

  CartList({required this.carts});

  factory CartList.fromJson(List<dynamic> json) {
    return CartList(
      carts: json.map((item) => Cart.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carts': carts.map((cart) => cart.toJson()).toList(),
    };
  }
}

class ProductOrder {
  final int productId;
  final int quantity;

  ProductOrder({
    required this.productId,
    required this.quantity,
  });

  factory ProductOrder.fromJson(Map<String, dynamic> json) {
    return ProductOrder(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
