import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

class CartBottomNavigation extends StatelessWidget {
  const CartBottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return (state.cart.productsMap.isEmpty)
              ? Row(
                  children: [
                    MainButtonWidget(
                      buttonText: 'Back To Shopping',
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                  ],
                )
              : BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, state) {
                    if (state is AddressLoadedSuccess) {
                      return (state.addresses.isEmpty)
                          ? Row(
                              children: [
                                MainButtonWidget(
                                  buttonText: 'Add New Address',
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/add_address');
                                  },
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                MainButtonWidget(
                                  buttonText: 'Go To Checkout',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/checkout');
                                  },
                                ),
                              ],
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
    );
  }
}

