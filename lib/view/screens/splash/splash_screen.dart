import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gromart_project/view/config/colors.dart';
import 'package:gromart_project/view/screens/auth/get_started.dart';

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
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamed('/getStarted');
    });
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(180),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'GROMART',
                    style: GoogleFonts.fuggles(
                      textStyle: const TextStyle(
                        color: kSecondaryColor,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
