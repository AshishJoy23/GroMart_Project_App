import 'dart:developer';

import 'package:flutter/material.dart';

import '../../models/models.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  final double widthFactor;
  final IconData iconData;
  const ProductCardWidget({
    super.key,
    required this.product,
    this.widthFactor = 2.8,
    this.iconData = Icons.favorite_border,
  });

  @override
  Widget build(BuildContext context) {
    var heightScrn = MediaQuery.of(context).size.height / 5;
    var widthScrn = MediaQuery.of(context).size.width / widthFactor;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: product,
        );
      },
      child: Stack(
        children: [
          SizedBox(
            width: widthScrn,
            height: heightScrn,
            child: Image.network(
              product.imageUrls[0],
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            child: Container(
              width: widthScrn,
              height: heightScrn,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(80),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: iconData == Icons.favorite_border
                      ? () {
                          log('fav added');
                        }
                      : () {
                          log('fav deleted');
                        },
                  icon: Icon(
                    iconData,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: widthScrn,
              height: heightScrn * 0.35,
              decoration: BoxDecoration(
                color: const Color(0xff388E3C).withAlpha(230),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          Text(
                            '\$${product.price}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_circle,
                            size: 26,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
