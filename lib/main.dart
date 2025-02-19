import "package:holool_ecommerce/exports/main_exports.dart";

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
      },
    );
  }
}
