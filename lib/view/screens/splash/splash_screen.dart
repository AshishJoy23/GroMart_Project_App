import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/getStarted');
    });
    return Scaffold(
      backgroundColor: const Color(0xff4CAF50),
      body: Center(
        child: Image.asset(
          'assets/images/gromart_splash.png',
        ),
      ),
    );
  }
}
