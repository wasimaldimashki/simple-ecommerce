import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holool_ecommerce/src/features/cart/repositories/cart_repository.dart';
import 'package:holool_ecommerce/src/models/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;

  CartCubit({required this.repository}) : super(CartInitial());

  Future<void> getCart() async {
    try {
      emit(CartLoading());
      final cart = await repository.getCart();
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> clearCart() async {
    try {
      emit(CartLoading());
      await repository.clearCart();
      emit(CartLoaded(cart: Cart(
        id: 0,
        userId: 0,
        date: DateTime.now(),
        products: [],
        v: 0,
      )));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    try {
      emit(CartLoading());
      await repository.addToCart(productId, quantity);
      final updatedCart = await repository.getCart();
      emit(CartLoaded(cart: updatedCart));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
