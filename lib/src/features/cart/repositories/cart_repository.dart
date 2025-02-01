import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:holool_ecommerce/core/network/api_endpoints.dart';
import 'package:holool_ecommerce/src/models/cart_model.dart';
import 'package:holool_ecommerce/src/models/product_model.dart';

class CartRepository {
  Future<Cart> getCart() async {
    try {
      // Get cart list
      final cartResponse = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.cart}'),
      );

      if (cartResponse.statusCode != 200) {
        throw Exception('Failed to load cart');
      }

      final List<dynamic> cartList = json.decode(cartResponse.body);
      if (cartList.isEmpty) {
        return Cart(
          id: 0,
          userId: 0,
          date: DateTime.now(),
          products: [],
          v: 0,
        );
      }

      final Cart latestCart = CartList.fromJson(cartList)
          .carts
          .reduce((a, b) => a.date.isAfter(b.date) ? a : b);

      final List<ProductOrder> productsWithDetails = [];
      for (var product in latestCart.products) {
        try {
          final productResponse = await http.get(
            Uri.parse('${ApiEndpoints.baseUrl}/products/${product.productId}'),
          );

          if (productResponse.statusCode == 200) {
            final productData = json.decode(productResponse.body);
            final Product productDetails = Product.fromJson(productData);

            productsWithDetails.add(ProductOrder(
              productId: product.productId,
              quantity: product.quantity,
            ));
          }
        } catch (e) {
          print('Error fetching product ${product.productId}: $e');
          continue;
        }
      }

      return Cart(
        id: latestCart.id,
        userId: latestCart.userId,
        date: latestCart.date,
        products: productsWithDetails,
        v: latestCart.v,
      );
    } catch (e) {
      throw Exception('Failed to load cart: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.cart}'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to clear cart');
      }
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.cart}'),
        body: json.encode({
          'userId': 1,
          'date': DateTime.now().toIso8601String(),
          'products': [
            {
              'productId': productId,
              'quantity': quantity,
            }
          ],
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add to cart');
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }
}
