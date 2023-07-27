import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/screens/product/widgets/expansion_tile.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel product;
  const ProductScreen({
    super.key,
    required this.product,
  });

  static const String routeName = '/product';

  static Route route({required ProductModel product}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ProductScreen(
        product: product,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
        appBar: const CustomAppBarWidget(
          title: 'Product Details',
          actionList: [],
        ),
        body: ListView(
          children: [
            // CarouselSlider(
            //   options: CarouselOptions(
            //     aspectRatio: 1.45,
            //     viewportFraction: 0.96,
            //     enlargeCenterPage: true,
            //     enlargeStrategy: CenterPageEnlargeStrategy.height,
            //   ),
            //   items: [
            //     CarouselCardWidget(
            //       product: product,
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: size.height * 0.3,
                child: PageView.builder(
                  itemCount: product.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      product.imageUrls[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            ProductNameAndPrice(product: product),
            DetailsExpansionTileWidget(textData: product.description, titleData: 'Product Information'),
            DetailsExpansionTileWidget(textData: product.description, titleData: 'Delivery Information'),
          ],
        ),
        bottomNavigationBar: const ProductBottomAppBar(),
      ),
    );
  }
}

