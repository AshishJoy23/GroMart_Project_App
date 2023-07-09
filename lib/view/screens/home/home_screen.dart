import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
        key: scaffoldKey,
        appBar: MainAppBarWidget(
          title: 'Explore!!!',
          scaffoldKey: scaffoldKey,
        ),
        drawer: const CustomDrawerWidget(),
        body: ListView(
          children: [
            SearchBarWidget(),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.58,
                viewportFraction: 0.93,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                autoPlay: true,
              ),
              items: CategoryModel.categories
                  .map((category) => CarouselCardWidget(category: category))
                  .toList(),
            ),
            const SectionTitleWidget(
              title: 'RECOMMENDED',
            ),
            ProductCarouselWidget(
              products: ProductModel.products,
            ),
            const SectionTitleWidget(
              title: 'MOST POPULAR',
            ),
            ProductCarouselWidget(
              products: ProductModel.products,
            ),
            const SectionTitleWidget(
              title: 'TOP RATED',
            ),
            ProductCarouselWidget(
              products: ProductModel.products,
            ),
            const SectionTitleWidget(
              title: 'TODAY\'S SPECIAL',
            ),
            ProductCarouselWidget(
              products: ProductModel.products,
            ),
          ],
        ),
        bottomNavigationBar: const MainBottomNavBar(),
      ),
    );
  }
}


