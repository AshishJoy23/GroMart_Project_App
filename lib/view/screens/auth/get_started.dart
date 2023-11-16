import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gromart_project/view/config/colors.dart';
import 'package:gromart_project/view/screens/screens.dart';

class GetStartedPage extends StatelessWidget {
  static const String routeName = '/getStarted';

  const GetStartedPage({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const GetStartedPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    Text(
                      'Something went wrong!!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const AuthPage();
            }
          }),
    );
  }
}
