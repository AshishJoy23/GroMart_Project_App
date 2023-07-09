import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../models/models.dart';

class ProductNameAndPrice extends StatelessWidget {
  const ProductNameAndPrice({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xffC8E6C9).withAlpha(160),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        '\$${product.price}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '4.5 Rating',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  log('fav added');
                },
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
