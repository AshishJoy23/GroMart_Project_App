import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gromart_project/blocs/blocs.dart';

import '../../../../models/models.dart';

class CartProductCard extends StatelessWidget {
  final int quantity;
  final ProductModel product;
  const CartProductCard({
    super.key,
    required this.quantity,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.18,
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              onPressed: (context) {
                BlocProvider.of<CartBloc>(context)
                    .add(CartProductDeleted(product));
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              icon: Icons.delete_rounded,
            ),
          ],
        ),
        child: Material(
          elevation: 12,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            height: height * 0.11,
            width: width / 1,
            decoration: const BoxDecoration(
              color: Color(0xffC8E6C9),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.imageUrls[0],
                      width: 80,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          '₹ ${product.price}',
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
                        onPressed: (quantity > 1)
                            ? () {
                                BlocProvider.of<CartBloc>(context)
                                    .add(CartProductRemoved(product));
                              }
                            : () => ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(5),
                                    backgroundColor: const Color(0xffC8E6C9),
                                    content: Text(
                                      'Minimum quantity of 1 is allowed.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                ),
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$quantity',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: (quantity < 10)
                            ? () {
                                BlocProvider.of<CartBloc>(context)
                                    .add(CartProductAdded(product));
                              }
                            : () => ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(5),
                                    backgroundColor: const Color(0xffC8E6C9),
                                    content: Text(
                                      'Maximum quantity of 10 is allowed.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                ),
                        icon: const Icon(
                          Icons.add_circle_outline,
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
        ),
      ),
    );
  }
}
