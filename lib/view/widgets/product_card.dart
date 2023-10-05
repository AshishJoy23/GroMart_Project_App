import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/view/config/config.dart';

import '../../models/models.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  final double widthFactor;
  final IconData iconData;
  final bool isFavorite;
  const ProductCardWidget({
    super.key,
    required this.product,
    this.widthFactor = 2.8,
    this.iconData = Icons.favorite_border,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    var heightScrn = MediaQuery.of(context).size.height / 5;
    var widthScrn = MediaQuery.of(context).size.width / widthFactor;
    final String? userEmail = FirebaseAuth.instance.currentUser!.email;
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
                child: BlocBuilder<WishlistBloc, WishlistState>(
                  builder: (context, state) {
                    if (state is WishlistLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor: Colors.white,
                          color: Colors.black,
                        ),
                      );
                    } else if (state is WishlistLoaded) {
                      return IconButton(
                        onPressed: (isFavorite)
                            ? () {
                                Utils.showAlertDialogBox(
                                  context,
                                  'Are You Sure?',
                                  'You want to remove from wishlist.',
                                  () {
                                    BlocProvider.of<WishlistBloc>(context).add(
                                        RemoveFromWishlist(
                                            email: userEmail!,
                                            productId: product.id));
                                    Navigator.pop(context);
                                    Utils.showSnackBar(
                                        'Product Removed from Wishlist',
                                        Colors.black87);
                                  },
                                );
                              }
                            : (state.wishlist.productList.contains(product.id))
                                ? () {
                                    BlocProvider.of<WishlistBloc>(context).add(
                                        RemoveFromWishlist(
                                            email: userEmail!,
                                            productId: product.id));
                                    Utils.showSnackBar(
                                        'Product Removed from Wishlist',
                                        Colors.black87);
                                  }
                                : () {
                                    BlocProvider.of<WishlistBloc>(context).add(
                                        AddToWishlist(
                                            email: userEmail!,
                                            productId: product.id));
                                    Utils.showSnackBar(
                                        'Product Added to Wishlist',
                                        Colors.black87);
                                  },
                        icon: (isFavorite)
                            ? Icon(
                                iconData,
                                color: Colors.white,
                                size: 24,
                              )
                            : Icon(
                                iconData,
                                color: (state.wishlist.productList
                                        .contains(product.id))
                                    ? Colors.redAccent
                                    : Colors.white,
                              ),
                      );
                    } else {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                      );
                    }
                  },
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
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoading) {
                          return Center(
                            child: Transform.scale(
                              scale: 0.6,
                              child: const CircularProgressIndicator(
                                strokeWidth: 3,
                                backgroundColor: Colors.white,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }
                        if (state is CartLoaded) {
                          return Expanded(
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<CartBloc>(context).add(
                                      CartProductAdded(userEmail!, product));
                                  Utils.showSnackBar(
                                      'Product Added to Cart', Colors.black87);
                                },
                                icon: const Icon(
                                  Icons.add_circle,
                                  size: 26,
                                  color: Colors.white,
                                )),
                          );
                        } else {
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        }
                      },
                    ),
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
