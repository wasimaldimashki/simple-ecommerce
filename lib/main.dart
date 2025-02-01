import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:holool_ecommerce/core/app_observer/navigator_observer.dart';
import 'package:holool_ecommerce/core/app_observer/simple_bloc_observer.dart';
import 'package:holool_ecommerce/core/keys/app_keys.dart';
import 'package:holool_ecommerce/core/shared/local_network.dart';
import 'package:holool_ecommerce/routes/routes.dart';
import 'package:holool_ecommerce/src/features/unknown/screens/unknown_page.dart';
import 'package:holool_ecommerce/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashNetwork.cashInitialization();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = SimpleBlocObserver();
  runApp(
    await Phoenix(child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        ensureScreenSize: true,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Simple E-commerce',
            initialRoute: '/',
            routes: routes,
            onUnknownRoute: (routeName) =>
                MaterialPageRoute(builder: (context) => UnknownPage()),
            navigatorObservers: [MyNavigatorObserver()],
            navigatorKey: AppKeys.navigatorKey,
            theme: themeData,
          );
        });
  }
}
