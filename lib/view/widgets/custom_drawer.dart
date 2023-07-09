import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
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
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xff388E3C),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(
                            width: 1.5, color: const Color(0xff388E3C))),
                    child: Image.asset('assets/images/profile.png'),
                  ),
                  Text(
                    'User Name',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            const DrawerListTileWidget(title: 'Profile',iconData: Icons.account_box_outlined,),
            const DrawerListTileWidget(title: 'My Cart',iconData: Icons.shopping_bag_outlined,),
            const DrawerListTileWidget(title: 'My Wishlist',iconData: Icons.favorite_border,),
            const DrawerListTileWidget(title: 'My Orders',iconData: Icons.track_changes,),
            const DrawerListTileWidget(title: 'Notification',iconData: Icons.notifications_outlined,),
            const DrawerListTileWidget(title: 'Settings',iconData: Icons.settings_outlined,),
            const SizedBox(
              height: 100,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 100,
              ),
              child: TextButton.icon(
                style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                    side: const BorderSide(
                      color: Color(0xff388E3C),
                      width: 1.5,
                    ),
                    minimumSize: const Size.fromHeight(54)),
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                },
                label: Text(
                  'Sign Out',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTileWidget extends StatelessWidget {
  final String title;
  final IconData iconData;
  const DrawerListTileWidget({
    super.key,
    required this.title,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.black54,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: () {
        // Handle drawer item tap for 'Home'
      },
    );
  }
}
