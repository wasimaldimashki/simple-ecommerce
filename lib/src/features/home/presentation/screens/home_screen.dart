import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:holool_ecommerce/core/constants/constants.dart';
import 'package:holool_ecommerce/src/features/home/home_cubit/home_cubit.dart';
import 'package:holool_ecommerce/theme/color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.backgroundColor,
            title: Text('Shop App',
                style: TextStyle(color: AppColors.primaryColor)),
            actions: [
              IconButton(
                tooltip: 'Add Product',
                onPressed: () {
                  Navigator.of(context).pushNamed('/add_product_screen');
                },
                icon: svgIcon("assets/icons/Edit Square.svg",
                    color: AppColors.primaryColor),
              ),
              IconButton(
                tooltip: 'Search',
                onPressed: () {
                  Navigator.of(context).pushNamed('/search');
                },
                icon: svgIcon("assets/icons/Search.svg",
                    color: AppColors.primaryColor),
              ),
              IconButton(
                tooltip: 'Notification',
                onPressed: () {
                  Navigator.of(context).pushNamed('/notification');
                },
                icon: svgIcon("assets/icons/Notification.svg",
                    color: AppColors.primaryColor),
              ),
            ],
          ),
          body: PageTransitionSwitcher(
            duration: defaultDuration,
            transitionBuilder: (child, animation, secondaryAnimation) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: homeCubit.screens[homeCubit.currentScreenIndex],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: AppColors.borderColor, width: 1)),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              currentIndex: homeCubit.currentScreenIndex,
              onTap: (index) async {
                homeCubit.changeScreen(index);
              },
              backgroundColor: Colors.transparent,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: Colors.grey,
              elevation: 0.0,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon: svgIcon("assets/icons/Shop.svg",
                      color: AppColors.primaryColor),
                  label: "Shop",
                  tooltip: "Shop",
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon: svgIcon("assets/icons/Bag.svg",
                      color: AppColors.primaryColor),
                  label: "Cart",
                  tooltip: "Cart",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
