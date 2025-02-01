import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/product_repository.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository repository;

  ProductDetailsCubit({required this.repository}) : super(ProductDetailsInitial());

  Future<void> getProductDetails(int productId) async {
    try {
      emit(ProductDetailsLoading());
      final product = await repository.getProductDetails(productId);
      emit(ProductDetailsLoaded(product: product));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  void updateQuantity(int quantity) {
    if (state is ProductDetailsLoaded) {
      final currentState = state as ProductDetailsLoaded;
      if (quantity >= 1) {
        emit(currentState.copyWith(quantity: quantity));
      }
    }
  }

  void incrementQuantity() {
    if (state is ProductDetailsLoaded) {
      final currentState = state as ProductDetailsLoaded;
      emit(currentState.copyWith(quantity: currentState.quantity + 1));
    }
  }

  void decrementQuantity() {
    if (state is ProductDetailsLoaded) {
      final currentState = state as ProductDetailsLoaded;
      if (currentState.quantity > 1) {
        emit(currentState.copyWith(quantity: currentState.quantity - 1));
      }
    }
  }
}
