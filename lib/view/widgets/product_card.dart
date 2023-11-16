
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/view/config/config.dart';

import '../../models/models.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  final IconData iconData;
  final bool isFavorite;
  const ProductCardWidget({
    super.key,
    required this.product,
    this.iconData = Icons.favorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final String? userEmail = FirebaseAuth.instance.currentUser!.email;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: product,
        );
      },
      child: Material(
        elevation: 8.0,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          padding: EdgeInsets.all(size.width * 0.02),
          width: size.width * 0.45,
          height: size.height * 0.32,
          decoration: BoxDecoration(
            color: kCardColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<WishlistBloc, WishlistState>(
                    builder: (context, state) {
                      if (state is WishlistLoading) {
                        return CircleAvatar(
                          //backgroundColor: Colors.grey,
                          backgroundColor: kSecondaryColor,
                          radius: 16.0,
                          child: Center(
                            child: Transform.scale(
                              scale: 0.5,
                              child: const CircularProgressIndicator(
                                strokeWidth: 3,
                                backgroundColor: Colors.white,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      } else if (state is WishlistLoaded) {
                        return InkWell(
                          onTap: (isFavorite)
                              ? () {
                                  Utils.showAlertDialogBox(
                                    context,
                                    'Are You Sure?',
                                    'You want to remove from wishlist.',
                                    () {
                                      BlocProvider.of<WishlistBloc>(context)
                                          .add(RemoveFromWishlist(
                                              email: userEmail!,
                                              productId: product.id));
                                      Navigator.pop(context);
                                      Utils.showSnackBar(
                                          'Product Removed from Wishlist',
                                          Colors.black87);
                                    },
                                  );
                                }
                              : (state.wishlist.productList
                                      .contains(product.id))
                                  ? () {
                                      BlocProvider.of<WishlistBloc>(context)
                                          .add(RemoveFromWishlist(
                                              email: userEmail!,
                                              productId: product.id));
                                      Utils.showSnackBar(
                                          'Product Removed from Wishlist',
                                          Colors.black87);
                                    }
                                  : () {
                                      BlocProvider.of<WishlistBloc>(context)
                                          .add(AddToWishlist(
                                              email: userEmail!,
                                              productId: product.id));
                                      Utils.showSnackBar(
                                          'Product Added to Wishlist',
                                          Colors.black87);
                                    },
                          child: CircleAvatar(
                            //backgroundColor: Colors.grey,
                            backgroundColor: kSecondaryColor,
                            radius: 16.0,
                            child: (isFavorite)
                                ? Icon(
                                    iconData,
                                    color: Colors.black54,
                                    size: 20,
                                  )
                                : Icon(
                                    iconData,
                                    size: 20.0,
                                    color: (state.wishlist.productList
                                            .contains(product.id))
                                        ? Colors.redAccent
                                        : Colors.grey,
                                  ),
                          ),
                        );
                      } else {
                        return const Icon(
                          Icons.error,
                          color: Colors.red,
                        );
                      }
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Image.network(
                      product.imageUrls[0],
                      width: size.width * 0.3,
                      height: size.height * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey,
                            height: 0.0,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 0.0,
                          ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹${product.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      height: 0.0,
                                    ),
                              ),
                              Text(
                                'units',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Colors.grey,
                                      height: 0.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<CartBloc, CartState>(
                              builder: (context, state) {
                                if (state is CartLoading) {
                                  return CircleAvatar(
                                    backgroundColor: kSecondaryColor,
                                    radius: 16.0,
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 0.5,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 3,
                                          backgroundColor: Colors.white,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (state is CartLoaded) {
                                  return InkWell(
                                    onTap: () {
                                      BlocProvider.of<CartBloc>(context).add(
                                          CartProductAdded(
                                              userEmail!, product));
                                      Utils.showSnackBar(
                                          'Product Added to Cart',
                                          Colors.black87);
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: kSecondaryColor,
                                      radius: 16.0,
                                      child: Icon(
                                        Icons.shopping_cart,
                                        color: Colors.black54,
                                        size: 20,
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  );
                                }
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
