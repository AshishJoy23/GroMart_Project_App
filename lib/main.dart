import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gromart_project/view/config/app_router.dart';
import 'package:gromart_project/view/config/theme.dart';
import 'package:gromart_project/view/config/utils.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:gromart_project/view/screens/splash/splash_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      title: 'GroMart',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: SplashScreen.routeName,
    );
  }
}



