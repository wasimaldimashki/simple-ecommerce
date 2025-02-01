import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holool_ecommerce/src/features/splash/cubit/splash_cubit.dart';
import 'package:holool_ecommerce/theme/color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SplashCubit>();
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoginState) {
            state.isLogIn == true
                ? Navigator.of(context).pushReplacementNamed('/home_screen')
                : Navigator.of(context).pushReplacementNamed('/home_screen');
            // : Navigator.of(context).pushReplacementNamed('/login_screen');
          }
        },
        builder: (context, state) {
          return Center(
            child: Image(
              image: const AssetImage('assets/icons/apple.png'),
              height: mediaQuery.height / 3,
              // width: mediaQuery.width,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.medium,
            ),
          );
        },
      ),
    );
  }
}
