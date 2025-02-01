import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:holool_ecommerce/theme/color.dart';
import 'package:lottie/lottie.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Unknown page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'This page is currently unavailable.',
                  textStyle: TextStyle(
                    fontSize: 18.spMin,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 50),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 50),
              displayFullTextOnTap: true,
              stopPauseOnTap: false,
            ),
            Lottie.asset(
              reverse: true,
              'assets/lottie/not_found_page.json',
              fit: BoxFit.contain,
              width: mediaQuery.width / 2,
              height: mediaQuery.height / 2,
            ),
          ],
        ),
      ),
    );
  }
}
