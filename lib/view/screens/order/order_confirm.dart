import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/models/product_model.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';

  const OrderConfirmation({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OrderConfirmation(),
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
        bottomNavigationBar: BottomAppBar(
          child: MainButtonWidget(
            buttonText: 'BACK TO SHOPPING',
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const OrderConfirmedBanner(),
              BlocBuilder<OrdersBloc, OrdersState>(
                builder: (context, state) {
                  if (state is OrdersLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        backgroundColor: Colors.white,
                        color: Colors.black,
                      ),
                    );
                  } else if (state is OrdersLoaded) {
                    log('<<<<<<<<<confirm screen>>>>>>>>>');

                    final order = state.order; // Safely get the order

                    if (order != null) {
                      // Access the order properties only if it's not null
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OrderAddressWidget(
                              address: order.address!,
                            ),
                            const SizedBox(height: 10),
                            OrderDetailsWidget(
                              order: order,
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Handle the case where order is null (if needed)
                      return const Text('Order is null');
                    }
                    // log(state.order.toString());
                    // return Padding(
                    //   padding: const EdgeInsets.all(20.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       OrderAddressWidget(
                    //         address: state.order!.address!,
                    //       ),
                    //       const SizedBox(height: 10),
                    //       OrderDetailsWidget(
                    //         order: state.order!,
                    //       ),
                    //     ],
                    //   ),
                    // );
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
    );
  }
}
