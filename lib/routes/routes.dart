import "package:holool_ecommerce/exports/routes_export.dart";

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
