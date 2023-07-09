import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';
import '../../widgets/widgets.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  static const String routeName = '/wishlist';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const WishlistScreen(),
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
          title: 'Wishlist',
        ),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          itemCount: ProductModel.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.15,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Center(
              child: ProductCardWidget(
                product: ProductModel.products[index],
                widthFactor: 2.5,
                iconData: Icons.delete_forever_outlined,
              ),
            );
          },
        ),
        bottomNavigationBar: const MainBottomNavBar(),
      ),
    );
  }
}
