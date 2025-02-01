import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holool_ecommerce/src/features/home/home_cubit/home_cubit.dart';
import 'package:holool_ecommerce/src/features/home/presentation/screens/home_screen.dart';
import 'package:holool_ecommerce/src/features/products/cubit/add_product_cubit.dart';
import 'package:holool_ecommerce/src/features/products/presentation/screens/add_product_screen.dart';
import 'package:holool_ecommerce/src/features/shop/cubit/category_cubit.dart';
import 'package:holool_ecommerce/src/features/shop/repositories/category_repository.dart';
import 'package:holool_ecommerce/src/features/splash/cubit/splash_cubit.dart';
import 'package:holool_ecommerce/src/features/splash/presentation/screens/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  // ======splash Screen=====//
  '/': (context) => BlocProvider(
        create: (context) => SplashCubit()..checkConnection(context: context),
        child: const SplashScreen(),
      ),
  // ======Home Screen=====//
  '/home_screen': (context) => BlocProvider(
        create: (context) => HomeCubit(),
        child: const HomeScreen(),
      ),
  // ======Add Product Screen=====//
  '/add_product_screen': (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AddProductCubit(),
          ),
          BlocProvider(
            create: (context) => CategoryCubit(repository: CategoryRepository())
              ..getCategories(),
          ),
        ],
        child: AddProductScreen(),
      ),
};
