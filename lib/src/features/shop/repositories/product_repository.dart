import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/product_model.dart';
import '../../../../core/network/api_endpoints.dart';

class ProductRepository {
  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.products}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.productCategories}$category'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load category products');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<Product> getProductDetails(int productId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.productDetails}$productId'),
      );

      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
