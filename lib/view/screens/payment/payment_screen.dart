import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:pay/pay.dart';
import '../../widgets/widgets.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  static const String routeName = '/payment';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const PaymentScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
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
          title: 'Payments',
          actionList: [],
        ),
        body: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            if (state is PaymentLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            if (state is PaymentLoaded) {
              return ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  Platform.isIOS
                      ? RadioListTile(
                          activeColor: const Color(0xff388E3C),
                          value: PaymentMethod.apple_pay,
                          groupValue: state.paymentMethod,
                          onChanged: (value) {
                            log('1');
                          },
                          title: RawApplePayButton(
                            style: ApplePayButtonStyle.black,
                            type: ApplePayButtonType.inStore,
                            onPressed: () {
                              BlocProvider.of<PaymentBloc>(context).add(
                                const PaymentMethodSelected(
                                    paymentMethod: PaymentMethod.apple_pay),
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                  Platform.isAndroid
                      ? RadioListTile(
                          activeColor: const Color(0xff388E3C),
                          value: PaymentMethod.google_pay,
                          groupValue: state.paymentMethod,
                          onChanged: (value) {
                            log('2');
                          },
                          title: RawGooglePayButton(
                            type: GooglePayButtonType.pay,
                            onPressed: () {
                              BlocProvider.of<PaymentBloc>(context).add(
                                const PaymentMethodSelected(
                                    paymentMethod: PaymentMethod.google_pay),
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  RadioListTile(
                    activeColor: const Color(0xff388E3C),
                    value: PaymentMethod.razor_pay,
                    groupValue: state.paymentMethod,
                    onChanged: (value) {
                      log('3');
                    },
                    title: SizedBox(
                      height: height * 0.06,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                            Colors.black,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                height * 0.06,
                              ), // Adjust the value to control the border radius
                            ),
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<PaymentBloc>(context).add(
                            const PaymentMethodSelected(
                                paymentMethod: PaymentMethod.razor_pay),
                          );
                        },
                        child: Text(
                          'Pay with Razor Pay',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  RadioListTile(
                    activeColor: const Color(0xff388E3C),
                    value: PaymentMethod.cash_on_delivery,
                    groupValue: state.paymentMethod,
                    onChanged: (value) {
                      log('4');
                    },
                    title: SizedBox(
                      height: height * 0.06,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                            Colors.black,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                height * 0.06,
                              ), // Adjust the value to control the border radius
                            ),
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<PaymentBloc>(context).add(
                            const PaymentMethodSelected(
                                paymentMethod: PaymentMethod.cash_on_delivery),
                          );
                        },
                        child: Text(
                          'Cash on Delivery',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            if (state is PaymentLoaded) {
              if (state.paymentMethod == PaymentMethod.cash_on_delivery) {
                return BottomAppBar(
                  child: MainButtonWidget(
                    buttonText: 'PAY WITH COD',
                    onPressed: () {},
                  ),
                );
              }
              if (Platform.isAndroid &&
                  state.paymentMethod == PaymentMethod.google_pay) {
                return BottomAppBar(
                  child: GooglePay(
                      // products: state.products!,
                      // total: state.total!,
                      ),
                );
              }
              if (Platform.isIOS &&
                  state.paymentMethod == PaymentMethod.apple_pay) {
                return BottomAppBar(
                  child: ApplePay(
                      // products: state.products!,
                      // total: state.total!,
                      ),
                );
              } else {
                return BottomAppBar(
                  child: MainButtonWidget(
                    buttonText: 'CHOOSE PAYMENT',
                    onPressed: () {},
                  ),
                );
              }
            } else {
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            }
          },
        ),
      ),
    );
  }
}
