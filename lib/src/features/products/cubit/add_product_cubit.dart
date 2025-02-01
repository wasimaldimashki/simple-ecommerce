import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import '../../../models/product_model.dart';
import '../../../../core/network/api_endpoints.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final Dio _dio;

  AddProductCubit({Dio? dio})
      : _dio = dio ?? Dio(),
        super(AddProductInitial());
  Dio dio = Dio();

  Future<void> addProduct(Product product) async {
    try {
      emit(AddProductLoading());

      final Map<String, dynamic> productData = {
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'image': product.image,
        'category': product.category,
      };
      print('Data Before :=> $productData');
      final response = await _dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.addProduct}',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Accept-Language': 'en',
          },
        ),
        data: productData,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(AddProductSuccess());
      } else {
        emit(AddProductError('Failed to add product. Please try again.'));
      }
    } catch (e) {
      print('General Error is :=> $e');
      emit(AddProductError('An error occurred. Error: ${e.toString()}'));
    }
  }
}
