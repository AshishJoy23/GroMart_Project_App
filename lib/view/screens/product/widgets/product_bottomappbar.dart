import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/config/config.dart';

class ProductBottomAppBar extends StatelessWidget {
  final ProductModel product;
  const ProductBottomAppBar({
    required  this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String? userEmail = FirebaseAuth.instance.currentUser!.email;
    return BottomAppBar(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        kPrimaryColor,
                      ),
                    ),
                    onPressed: () {
                       BlocProvider.of<CartBloc>(context).add(
                                      CartProductAdded(userEmail!, product));
                                  Utils.showSnackBar(
                                      'Product Added to Cart', Colors.black87);
                    },
                    child: Text(
                      'Add To Cart',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        kPrimaryColor,
                      ),
                    ),
                    onPressed: () {
                      log('choose from camera');
                    },
                    child: Text(
                      'Buy Now',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
