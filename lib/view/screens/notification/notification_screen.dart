import 'package:flutter/material.dart';
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
      ),
    );
  }
}

