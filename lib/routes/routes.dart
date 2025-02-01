import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holool_ecommerce/src/features/home/home_cubit/home_cubit.dart';
import 'package:holool_ecommerce/src/features/home/presentation/screens/home_screen.dart';
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
};
