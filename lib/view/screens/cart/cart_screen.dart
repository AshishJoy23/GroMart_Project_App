import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/view/config/colors.dart';
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
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const CustomAppBarWidget(
        title: 'Cart',
        actionList: [],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            return (state.cart.productsMap.isEmpty)
                ? const CartEmptyWidget()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.cart.freeDelivery(state.cart.subTotal),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            (state.cart.subTotal < 100)
                                ? InkWell(
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
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: ListView.builder(
                            itemCount: state.cart.productsMap.keys.length,
                            itemBuilder: (context, index) {
                              return CartProductCard(
                                quantity: state.cart.productsMap.values
                                    .elementAt(index),
                                product: state.cart.productsMap.keys
                                    .elementAt(index),
                              );
                            },
                          ),
                        ),
                        //const Spacer(),
                        const Divider(
                          thickness: 2,
                        ),
                        CartAmountWidget(
                          subTotal: state.cart.subTotal,
                          deliveryFee: state.cart.deliveryFee,
                          totalAmount: state.cart.grandTotal,
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
      bottomNavigationBar: const CartBottomNavigation(),
    );
  }
}
