import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gromart_project/view/config/config.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  static const String routeName = '/settings';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => SettingsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const CustomAppBarWidget(title: 'Settings', actionList: []),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                color: Colors.amber,
                child: Text(
                  'GROMART',
                  style: GoogleFonts.qwigley(
                    textStyle: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )),
      bottomNavigationBar: Row(
        children: [
          MainButtonWidget(buttonText: 'Save Profile', onPressed: () {}),
        ],
      ),
    );
  }
}
