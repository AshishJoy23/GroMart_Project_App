import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/config/config.dart';
import '../../widgets/widgets.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  static const String routeName = '/wishlist';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const WishlistScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const MainAppBarWidget(
        title: 'Wishlist',
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          log('<<<<<<<<enter wishlist bloc>>>>>>>>');
          if (state is WishlistLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: Colors.white,
                color: Colors.black,
              ),
            );
          } else if (state is WishlistLoaded) {
            log('<<<<<<<wislist loaded>>>>>>>');
            return (state.wishlist.productList.isEmpty)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/orders_empty.png',
                          width: size.width,
                          height: size.height * 0.4,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          'Your Wishlist is Empty!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding:
                         EdgeInsets.symmetric(horizontal: size.width*0.03, vertical: size.width*0.01),
                    itemCount: state.wishlist.productList.length,
                    gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: size.width*0.05,
                      crossAxisSpacing: size.width*0.03,
                    ),
                    itemBuilder: (context, index) {
                      ProductModel product =
                          (BlocProvider.of<ProductBloc>(context).state
                                  as ProductLoaded)
                              .products
                              .firstWhere((item) =>
                                  item.id == state.wishlist.productList[index]);
                      return ProductCardWidget(
                        product: product,
                        iconData: CupertinoIcons.delete_solid,
                        isFavorite: true,
                      );
                    },
                  );
          } else {
            return const Icon(
              Icons.error,
              color: Colors.red,
            );
          }
        },
      ),
      bottomNavigationBar: const MainBottomNavBar(),
    );
  }
}
