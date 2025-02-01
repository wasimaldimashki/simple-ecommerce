import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:holool_ecommerce/core/constants/constants.dart';
import 'package:holool_ecommerce/theme/color.dart';
import '../../../widgets/products_card/network_image_with_loader.dart';
import '../../../widgets/rating_bar.dart';
import '../cubit/product_details_cubit.dart';
import '../cubit/product_details_state.dart';
import '../repositories/product_repository.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(
        repository: ProductRepository(),
      )..getProductDetails(productId),
      child: Scaffold(
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is ProductDetailsLoaded) {
              return CustomScrollView(
                slivers: [
                  // App Bar with Image
                  SliverAppBar(
                    expandedHeight: 300.h,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: state.product.image,
                        child: NetworkImageWithLoader(
                          state.product.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    leading: IconButton(
                      color: AppColors.primaryColor,
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  // Product Details
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              state.product.category,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Title
                          Text(
                            state.product.title,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          // Rating
                          RatingBar(
                            rating: state.product.rating.rate,
                            count: state.product.rating.count.toDouble(),
                            size: 20,
                          ),
                          SizedBox(height: 16.h),
                          // Price
                          Text(
                            '\$${state.product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Description
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.product.description,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          // Quantity
                          Row(
                            children: [
                              Text(
                                'Quantity:',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      color: AppColors.primaryColor,
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        context
                                            .read<ProductDetailsCubit>()
                                            .decrementQuantity();
                                      },
                                    ),
                                    Text(
                                      state.quantity.toString(),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      color: AppColors.primaryColor,
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        context
                                            .read<ProductDetailsCubit>()
                                            .incrementQuantity();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
        bottomNavigationBar:
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoaded) {
              return Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -4),
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle add to cart
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${state.quantity} item(s) added to cart',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add to Cart - \$${(state.product.price * state.quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.shimmerHighlightColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
