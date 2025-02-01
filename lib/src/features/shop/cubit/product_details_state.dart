import 'package:equatable/equatable.dart';
import '../../../models/product_model.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final Product product;
  final int quantity;

  const ProductDetailsLoaded({
    required this.product,
    this.quantity = 1,
  });

  ProductDetailsLoaded copyWith({
    Product? product,
    int? quantity,
  }) {
    return ProductDetailsLoaded(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [product, quantity];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
