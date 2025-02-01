import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/category_model.dart';
import '../../../../core/network/api_endpoints.dart';

class CategoryRepository {
  Future<Category> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}/products/categories'),
      );

      if (response.statusCode == 200) {
        return Category.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
