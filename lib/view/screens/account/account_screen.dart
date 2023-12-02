import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/view/config/config.dart';
import 'package:gromart_project/view/screens/screens.dart';
import '../../widgets/widgets.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  static const String routeName = '/account';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => AccountScreen(),
    );
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String? currentUser = FirebaseAuth.instance.currentUser!.email;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const MainAppBarWidget(
        title: 'Account',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            const ProfilePhotoWidget(),
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
              if (state is ProfileLoaded) {
                log('<<<<<<<<<<<account screenn>>>>>>>>>>>');
                log(state.profile.userName);
                log(state.profile.userImageUrl);
                log('============================;');
                log(state.profile.userImageUrl);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.profile.userName,
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                );
              } else {
                return const Icon(
                  Icons.error,
                  color: Colors.red,
                );
              }
            }),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 10.0,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.575,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CustomListTile(
                        tileText: 'Edit Profile',
                        tileIcon: Icons.person_outline,
                        tileOnTap: () {
                          BlocProvider.of<ProfileBloc>(context)
                              .add(ProfileGetLoaded(email: currentUser!));
                          Navigator.pushNamed(context, '/profile');
                        }),
                    CustomListTile(
                        tileText: 'Orders',
                        tileIcon: CupertinoIcons.cube_box,
                        tileOnTap: () {
                          Navigator.pushNamed(context, '/orders');
                        }),
                    CustomListTile(
                        tileText: 'Wishlist',
                        tileIcon: Icons.favorite_outline,
                        tileOnTap: () {
                          Navigator.pushNamed(context, '/wishlist');
                        }),
                    CustomListTile(
                        tileText: 'Addresses',
                        tileIcon: Icons.pin_drop_outlined,
                        tileOnTap: () {
                          Navigator.pushNamed(context, '/address');
                        }),
                    CustomListTile(
                        tileText: 'Settings',
                        tileIcon: Icons.settings_outlined,
                        tileOnTap: () {
                          Navigator.pushNamed(context, '/settings');
                        }),
                    const Spacer(),
                    Row(
                      children: [
                        MainButtonWidget(
                          heightFactor: 0.05,
                          buttonText: 'Exit App',
                          onPressed: () {
                            Utils.showAlertDialogBox(
                              context,
                              'Are You Sure?',
                              'You want to exit from the app.',
                              () {
                                SystemNavigator.pop();
                              },
                            );
                          },
                          isSubButton: true,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MainButtonWidget(
                          heightFactor: 0.05,
                          buttonText: 'Logout',
                          onPressed: () async {
                            //await FirebaseAuth.instance.signOut();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: const MainBottomNavBar(),
    );
  }
}
