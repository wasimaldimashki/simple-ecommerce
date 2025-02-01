import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holool_ecommerce/core/constants/constants.dart';
import 'package:holool_ecommerce/src/features/cart/cubit/cart_cubit.dart';
import 'package:holool_ecommerce/src/features/cart/repositories/cart_repository.dart';
import 'package:holool_ecommerce/src/features/shop/repositories/product_repository.dart';
import 'package:holool_ecommerce/src/widgets/products_card/secondary_product_card.dart';
import 'package:holool_ecommerce/theme/color.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(
        repository: CartRepository(),
      )..getCart(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Cart Shopping',
              style: TextStyle(color: AppColors.primaryColor)),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoaded && state.cart.products.isNotEmpty) {
                  return IconButton(
                    onPressed: () {
                      context.read<CartCubit>().clearCart();
                    },
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Clear Cart',
                    color: AppColors.primaryColor,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartError) {
              return Center(child: Text(state.message));
            }
            if (state is CartLoaded) {
              if (state.cart.products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: defaultPadding),
                      Text(
                        'Cart is empty',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(defaultPadding),
                      itemCount: state.cart.products.length,
                      itemBuilder: (context, index) {
                        final product = state.cart.products[index];
                        return FutureBuilder(
                          future: ProductRepository()
                              .getProductDetails(product.productId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Padding(
                                padding:
                                    EdgeInsets.only(bottom: defaultPadding),
                                child: Card(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return const SizedBox();
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.only(bottom: defaultPadding),
                              child: SecondaryProductCard(
                                product: snapshot.data!,
                                quantity: product.quantity,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FutureBuilder(
                            future: Future.wait(
                              state.cart.products.map((product) =>
                                  ProductRepository()
                                      .getProductDetails(product.productId)),
                            ),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Text('جاري حساب المجموع...');
                              }

                              double totalPrice = 0;
                              for (var i = 0; i < snapshot.data!.length; i++) {
                                totalPrice += snapshot.data![i].price *
                                    state.cart.products[i].quantity;
                              }

                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'عدد المنتجات:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      Text(
                                        '${state.cart.products.length}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: defaultPadding / 2),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'المجموع:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Text(
                                        '\$${totalPrice.toStringAsFixed(2)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: defaultPadding),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Implement checkout
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.all(defaultPadding),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      defaultBorderRadious),
                                ),
                              ),
                              child: const Text('متابعة الدفع'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
