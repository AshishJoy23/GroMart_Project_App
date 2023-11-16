import 'dart:developer';

import 'package:flutter/material.dart';
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const CustomAppBarWidget(title: 'Settings', actionList: []),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(size.width * 0.02),
                width: size.width * 0.45,
                height: size.height * 0.32,
                decoration: BoxDecoration(
                  color: Color(0xFF6CC51D),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: size.width * 0.45,
                height: size.height * 0.32,
                color: Color(0xFFAEDC81),
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
