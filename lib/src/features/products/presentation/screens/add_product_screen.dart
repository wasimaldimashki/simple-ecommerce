import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holool_ecommerce/src/models/rate_model.dart';
import 'package:holool_ecommerce/theme/color.dart';
import '../../cubit/add_product_cubit.dart';
import '../../../../models/product_model.dart';
import '../../../shop/cubit/category_cubit.dart';
import '../../../shop/cubit/category_state.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController(text: 'https://i.pravatar.cc');
  final _selectedCategory = ValueNotifier<String?>(null);

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate() && _selectedCategory.value != null) {
      final product = Product(
        id: 0, // This will be ignored by the API
        title: _titleController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        category: _selectedCategory.value!,
        image: _imageController.text,
        rating: Rate(rate: 0, count: 0), // This will be ignored by the API
      );

      context.read<AddProductCubit>().addProduct(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Product',
          style: TextStyle(
            color: AppColors.textPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios, color: AppColors.secondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<AddProductCubit, AddProductState>(
        listener: (context, state) {
          if (state is AddProductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product added successfully'),
                backgroundColor: AppColors.successColor,
              ),
            );
            Navigator.pop(context);
          } else if (state is AddProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorColor,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _imageController,
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    labelStyle: TextStyle(color: AppColors.textSecondaryColor),
                  ),
                  style: const TextStyle(color: AppColors.primaryColor),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter image URL' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    labelStyle: TextStyle(color: AppColors.textSecondaryColor),
                  ),
                  style: const TextStyle(color: AppColors.primaryColor),
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter product name'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    prefixText: '\$',
                    prefixStyle: TextStyle(color: AppColors.primaryColor),
                    labelStyle: TextStyle(color: AppColors.textSecondaryColor),
                  ),
                  style: const TextStyle(color: AppColors.primaryColor),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please enter price';
                    if (double.tryParse(value!) == null)
                      return 'Please enter a valid price';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    } else if (state is CategoryLoaded) {
                      return ValueListenableBuilder<String?>(
                        valueListenable: _selectedCategory,
                        builder: (context, selectedCategory, _) {
                          return DropdownButtonFormField<String>(
                            value: selectedCategory,
                            decoration: const InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor),
                              ),
                              labelStyle: TextStyle(
                                  color: AppColors.textSecondaryColor),
                            ),
                            items: state.categories.categories.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category,
                                  style: const TextStyle(
                                    color: AppColors.textPrimaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _selectedCategory.value = value;
                            },
                            validator: (value) => value == null
                                ? 'Please select a category'
                                : null,
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    labelStyle: TextStyle(color: AppColors.textSecondaryColor),
                  ),
                  style: const TextStyle(color: AppColors.primaryColor),
                  maxLines: 4,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter product description'
                      : null,
                ),
                const SizedBox(height: 24),
                BlocBuilder<AddProductCubit, AddProductState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is AddProductLoading
                          ? null
                          : () => _submitForm(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: state is AddProductLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Add Product',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
