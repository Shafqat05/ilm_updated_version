import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:ilm_updated_version/repository/accounts_data_repo/accounts_data_repository.dart';
import 'package:ilm_updated_version/view/screens/splash_screen.dart';
import 'package:device_preview/device_preview.dart';

import 'global/localization_common.dart';

AccountDataRepository accountDataRepository = AccountDataRepository();
GetStorage storage = GetStorage();
 var navigatorKey = GlobalKey<NavigatorState>();


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translation',
        fallbackLocale: Locale('en'),
        startLocale: Locale('en'),
        child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {


  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeMode _themeMode = ThemeMode.light;
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: [Locale('en', 'US'), Locale('ar', 'IQ')],
      // locale: context.locale,
      // fallbackLocale: Locale('en', 'US'),

      translations: LocalString(),
      locale: Locale('en', 'US'),

      title: 'ilm Updated Version',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      //theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}


//class MyApp extends StatelessWidget {
  //const MyApp({super.key});
 // static var navigatorKey = GlobalKey<NavigatorState>();
  //ThemeMode _themeMode = ThemeMode.light;
   //static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();

   // void changeTheme(ThemeMode themeMode) {
   //   setState(() {
   //     _themeMode = themeMode;
   //   });
   // }

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       localizationsDelegates: context.localizationDelegates,
//       supportedLocales: [Locale('en', 'US'), Locale('ar', 'IQ')],
//       locale: context.locale,
//       fallbackLocale: Locale('en', 'US'),
//       title: 'Flutter Demo',
//       navigatorKey: navigatorKey,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//      // themeMode: _themeMode,
//       debugShowCheckedModeBanner: false,
//       useInheritedMediaQuery: true,
//       builder: DevicePreview.appBuilder,
//       //theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       home: const SplashScreen(),
//     );
//   }
// }
