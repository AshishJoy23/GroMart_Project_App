import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/config/colors.dart';
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
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const CustomAppBarWidget(
        title: 'Product Details',
        actionList: [],
      ),
      body: ListView(
        children: [
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
          DetailsExpansionTileWidget(
              textData: product.description, titleData: 'Product Information'),
          DetailsExpansionTileWidget(
              textData: product.description, titleData: 'Delivery Information'),
        ],
      ),
      bottomNavigationBar: ProductBottomAppBar(
        product: product,
      ),
    );
  }
}
