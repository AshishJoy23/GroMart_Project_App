import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/view/config/colors.dart';
import 'package:gromart_project/view/config/config.dart';
import 'package:gromart_project/view/screens/screens.dart';

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
    final String? userEmail = FirebaseAuth.instance.currentUser!.email;
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 5.0,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          height: height * 0.145,
          width: width / 1,
          decoration: const BoxDecoration(
            color: kCardColor,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    product.imageUrls[0],
                    width: size.width * 0.22,
                    height: size.height,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Utils.showAlertDialogBox(
                                context,
                                'Do you want to delete?',
                                'The product will be deleted from the cart',
                                () {
                                  BlocProvider.of<CartBloc>(context).add(
                                      CartProductDeleted(userEmail!, product));
                                  Navigator.pop(context);
                                  Utils.showSnackBar(
                                      'Product removed from the Cart',
                                      Colors.black87);
                                },
                              );
                            },
                            child: const CircleAvatar(
                              backgroundColor: kSecondaryColor,
                              radius: 16.0,
                              child: Icon(
                                CupertinoIcons.delete_solid,
                                color: Colors.black54,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '₹ ${product.price}',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      height: 0.0,
                                    ),
                          ),
                          Text(
                            ' / units',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.grey,
                                  height: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Divider(
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '₹ ${product.price * quantity}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                            ),
                          ),
                          CartQuantityUpdateButton(
                              quantity: quantity, product: product),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
