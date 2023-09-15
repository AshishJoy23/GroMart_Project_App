import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CartScreen(),
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
        appBar: const CustomAppBarWidget(
          title: 'Cart',
          actionList: [],
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            // if (state is CartLoading) {
            //   return const Center(
            //     child: CircularProgressIndicator(
            //       strokeWidth: 3,
            //       backgroundColor: Colors.white,
            //       color: Colors.black,
            //     ),
            //   );
            // }
            if (state is CartLoaded) {
              return (state.cart.productsMap.isEmpty)
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/cart_empty.png',
                            width: size.width,
                            height: size.height * 0.4,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            'Your Cart is Empty!',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            'Add items to cart and explore your shopping.',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: ListView(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.cart
                                            .freeDelivery(state.cart.subTotal),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/',
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'Add More Items',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 400,
                                    child: ListView.builder(
                                      itemCount:
                                          state.cart.productsMap.keys.length,
                                      itemBuilder: (context, index) {
                                        return CartProductCard(
                                          quantity: state
                                              .cart.productsMap.values
                                              .elementAt(index),
                                          product: state.cart.productsMap.keys
                                              .elementAt(index),
                                        );
                                      },
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                ],
                              ),
                              CartAmountWidget(
                                subTotal: state.cart.subTotal,
                                deliveryFee: state.cart.deliveryFee,
                                totalAmount: state.cart.grandTotal,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
            } else {
              return const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              );
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded) {
              return (state.cart.productsMap.isEmpty)
                  ? BottomAppBar(
                      child: MainButtonWidget(
                        buttonText: 'BACK TO SHOPPING',
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                    )
                  : BottomAppBar(
                      child: MainButtonWidget(
                        buttonText: 'GO TO CHECKOUT',
                        onPressed: () {
                          Navigator.pushNamed(context, '/checkout');
                        },
                      ),
                    );
            } else {
              return const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
