import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff4CAF50),
            Color(0xffC8E6C9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
            }
            else if (state is WishlistLoaded){
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              itemCount: state.wishlist.productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                ProductModel product = (BlocProvider.of<ProductBloc>(context)
                      .state as ProductLoaded)
                  .productsl
                  .firstWhere((item) =>
                      item.id == state.wishlist.productList[index]);
                return Center(
                  child: ProductCardWidget(
                    product: product,
                    iconData: Icons.delete,
                    isFavorite: true,
                  ),
                );
              },
            );
            }
            else{
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            }
          },
        ),
        bottomNavigationBar: const MainBottomNavBar(),
      ),
    );
  }
}
