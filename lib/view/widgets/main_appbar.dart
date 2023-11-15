import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/cart_model.dart';

class MainAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const MainAppBarWidget({
    super.key,
    required this.title,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        onPressed: () {
          scaffoldKey!.currentState!.openDrawer();
        },
      ),
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      actions: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(
                child: Transform.scale(
                  scale: 0.7,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                    backgroundColor: Colors.white,
                    color: Colors.black,
                  ),
                ),
              );
            }
            if (state is CartLoaded) {
              return GestureDetector(
                onTap: () {
                  log('shopping cart clicked');
                  Navigator.pushNamed(context, '/cart');
                },
                child: Stack(
                  children: [
                    const Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          CupertinoIcons.shopping_cart,
                          color: Colors.black,
                          size: 26,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        radius: 9.0,
                        child: Text(
                          state.cart.productsMap.keys.length.toString(),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
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
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
