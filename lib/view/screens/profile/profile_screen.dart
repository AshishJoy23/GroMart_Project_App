import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gromart_project/view/screens/screens.dart';
import '../../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ProfileScreen(),
    );
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff4CAF50),
            Color(0xffC8E6C9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const MainAppBarWidget(
          title: 'Profile',
        ),
        body: ListView(
          children: [
            const ProfilePhotoWidget(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Abcdefg Hijkl',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SectionTitleWidget(title: 'PERSONAL DETAILS'),
            CustomTextFormField(
              controller: controller,
              hintText: 'Enter your Name..',
              labelText: 'Abcdefg Hijkl',
              iconData: Icons.person,
            ),
            CustomTextFormField(
              controller: controller,
              hintText: 'Enter your Email..',
              labelText: 'Abcdefg Hijkl',
              iconData: Icons.email,
            ),
            CustomTextFormField(
              controller: controller,
              hintText: 'Enter your Phone..',
              labelText: 'Abcdefg Hijkl',
              iconData: Icons.phone,
            ),
            MainButtonWidget(buttonText: 'Save Changes',onPressed: () {
              
            },),
          ],
        ),
        bottomNavigationBar: const MainBottomNavBar(),
      ),
    );
  }
}

