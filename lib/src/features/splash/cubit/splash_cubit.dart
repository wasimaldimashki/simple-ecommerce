import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:holool_ecommerce/core/network/connect.dart';
import 'package:holool_ecommerce/core/shared/local_network.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  int checkInternetCounter = -1;

  Future<void> checkConnection({required BuildContext context}) async {
    await Future.delayed(const Duration(seconds: 2));
    print('Found internet');
    checkLoginStatus(context: context);
    if (await checkInternet()) {
      checkLoginStatus(context: context);
    } else {
      checkInternetCounter++;
      emit(SplashNoInternetConnection());
    }
  }

  Future<void> checkLoginStatus({required BuildContext context}) async {
    try {
      String? token = CashNetwork.getCashData(key: 'token');

      if (token.isEmpty) {
        print('check state is => Don\'t found a token');
        // await Future.delayed(const Duration(seconds: 2));
        emit(SplashLoginState(isLogIn: false));
      } else {
        String? isVerified = CashNetwork.getCashData(key: 'is_verified');
        if (isVerified == 'false') {
          emit(SplashLoginState(isLogIn: false));
          return;
        }
        print('check state is => found a token : $token');
        // await Future.delayed(const Duration(seconds: 2));
        emit(SplashLoginState(isLogIn: true));
      }
    } catch (e) {
      print(e);
    }
  }
}
