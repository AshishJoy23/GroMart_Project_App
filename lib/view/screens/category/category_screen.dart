import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/screens/category/widgets/category_card.dart';
import '../../widgets/widgets.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const String routeName = '/category';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CategoryScreen(),
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
          title: 'Category',
        ),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          itemCount:  CategoryModel.categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.15,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Center(
              child: CategoryCardWidget(category: CategoryModel.categories[index])
            );
          },
        ),
        bottomNavigationBar: const MainBottomNavBar(),
      ),
    );
  }
}
