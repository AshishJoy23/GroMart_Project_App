import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gromart_project/view/config/colors.dart';
import 'package:gromart_project/view/screens/home/home_screen.dart';
import 'package:gromart_project/view/screens/screens.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  static const String routeName = '/mainAppScreen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const MainAppScreen(),
    );
  }

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentselected = 0;

  final pages = [
    const HomeScreen(),
    const WishlistScreen(),
    const NotificationScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: kSecondaryColor,
      body: pages[currentselected],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        color: kSecondaryColor,
        child: GNav(
            duration: const Duration(milliseconds: 300),
            gap: size.width * 0.035,
            backgroundColor: kSecondaryColor,
            activeColor: kSecondaryColor,
            tabBackgroundColor: kPrimaryColor,
            iconSize: 26,
            // tabBackgroundGradient: LinearGradient(
            //   colors: [
            //     kButtonGradientColor.withOpacity(0.2),
            //     kPrimaryColor.withOpacity(0.2),
            //   ],
            // ),
            padding: EdgeInsets.all(size.width * 0.035),
            curve: Curves.easeInCirc,
            onTabChange: (index) {
              setState(() {
                log(index.toString());
                currentselected = index;
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                iconColor: Colors.black,
                // text: 'Home',
                // textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //       color: kPrimaryColor,
                //       fontWeight: FontWeight.bold,
                //     ),
              ),
              GButton(
                icon: CupertinoIcons.heart_fill,
                iconColor: Colors.black,
                // text: 'Wishlist',
                // textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //       color: kPrimaryColor,
                //       fontWeight: FontWeight.bold,
                //     ),
              ),
              GButton(
                icon: Icons.notifications,
                iconColor: Colors.black,
                // text: 'Notifications',
                // textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //       color: kPrimaryColor,
                //       fontWeight: FontWeight.bold,
                //     ),
              ),
              GButton(
                icon: CupertinoIcons.person_solid,
                iconColor: Colors.black,
                // text: 'Account',
                // textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //       color: kPrimaryColor,
                //       fontWeight: FontWeight.bold,
                //     ),
              ),
            ]),
      ),
    );
  }
}
