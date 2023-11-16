import 'package:flutter/material.dart';
import 'package:gromart_project/view/config/colors.dart';
import 'package:gromart_project/view/screens/screens.dart';
import '../../widgets/widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const String routeName = '/notification';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const NotificationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const MainAppBarWidget(
        title: 'Notifications',
      ),
      body: ListView(
        children: [
          const SectionTitleWidget(
            title: 'All Notifications',
            button: true,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 14,
              itemBuilder: (context, index) {
                return NotificationTileWidget(
                  index: index,
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: const MainBottomNavBar(),
    );
  }
}
