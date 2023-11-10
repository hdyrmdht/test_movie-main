import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Core/config/page_route_name.dart';
import 'Core/config/routes.dart';
import 'Core/config/theme.dart';
import 'Core/services/bloc_observer.dart';
import 'Core/services/cache_helper.dart';
import 'Core/services/loading_service.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  configLoading();
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: EasyLoading.init(),
          title: 'Flutter Demo',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          initialRoute: PageRouteName.initial,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
