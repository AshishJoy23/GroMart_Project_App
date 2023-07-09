import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../models/models.dart';

class CardProductCard extends StatelessWidget {
  final ProductModel product;
  const CardProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: Colors.white.withAlpha(140),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                product.imageUrl,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${product.price}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      log('fav added');
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '1',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      log('fav added');
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
