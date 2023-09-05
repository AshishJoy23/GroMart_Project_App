import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gromart_project/blocs/blocs.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        isLeading: false,
        title: 'Order Confirmation',
        actionList: [],
      ),
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
            Stack(
              children: [
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 300,
                ),
                Positioned(
                  left: (size.width - 100) / 2,
                  top: 125,
                  child: SvgPicture.asset(
                    'assets/svgs/garlands.svg',
                    height: 100,
                    width: 100,
                  ),
                ),
                Positioned(
                  top: 250,
                  height: 100,
                  width: size.width,
                  child: Text(
                    'Your order is complete!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      backgroundColor: Colors.white,
                      color: Colors.black,
                    ),
                  );
                } else if (state is CheckoutLoaded) {
                  log('<<<<<<<<<confirm>>>>>>>>>');
                  log(state.address.toString());
                  log(state.cart.grandTotal.toString());
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi ${state.address!.name},',
                          style: Theme.of(context).textTheme.headlineSmall!
                        .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'YOUR ORDER DETAILS',
                          style: Theme.of(context).textTheme.titleLarge!
                        .copyWith(color: Colors.black),
                        ),
                        const Divider(thickness: 1,color: Colors.black,),
                        ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                elevation: 12,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  height: size.height * 0.11,
                                  width: size.width / 1,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffC8E6C9),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset('assets/images/product1.jpg',
                                            width: 80,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'name',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              Text(
                                                '₹ price',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              Text(
                                                'Qty : 2',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 10.0,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'SUBTOTAL',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    '₹ ${state.cart.subTotal}',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'DELIVERY FEE',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    '₹ ${state.cart.deliveryFee}',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'DELIVERY FEE',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    '₹ ${state.cart.grandTotal}',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              )
                            ],
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
          ],
        ),
      ),
    );
  }
}
