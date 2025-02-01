import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holool_ecommerce/src/features/cart/cubit/cart_cubit.dart';
import 'package:holool_ecommerce/src/features/cart/repositories/cart_repository.dart';
import 'package:holool_ecommerce/src/features/cart/screens/cart_screen.dart';
import 'package:holool_ecommerce/src/features/shop/cubit/category_cubit.dart';
import 'package:holool_ecommerce/src/features/shop/cubit/product_cubit.dart';
import 'package:holool_ecommerce/src/features/shop/repositories/category_repository.dart';
import 'package:holool_ecommerce/src/features/shop/repositories/product_repository.dart';
import 'package:holool_ecommerce/src/features/shop/shop_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final List screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryCubit(
            repository: CategoryRepository(),
          )..getCategories(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(
            repository: ProductRepository(),
          )..getProducts(),
        ),
      ],
      child: ShopScreen(),
    ),
    //** Cart Screen **/
    BlocProvider(
      create: (context) => CartCubit(repository: CartRepository())..getCart(),
      child: CartScreen(),
    )
  ];

  PageController controller = PageController(initialPage: 0);

  int currentScreenIndex = 0;

  void initState(int startPage) {
    controller = PageController(initialPage: startPage);
    currentScreenIndex = startPage;
  }

  void changeScreen(int newScreenIndex) {
    currentScreenIndex = newScreenIndex;

    // controller.animateToPage(newScreenIndex,
    //     duration: const Duration(milliseconds: 500),
    //     curve: Curves.easeInOutCirc);
    emit(NavigationChangeScreenState());
  }
}
