import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:gromart_project/view/widgets/widgets.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:status_alert/status_alert.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CheckoutScreen(),
    );
  }

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _razorpay = Razorpay();
  final currentUser = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    BlocProvider.of<CheckoutBloc>(context)
        .add(CheckoutConfirmed(email: currentUser!));
    StatusAlert.show(
      context,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      title: 'Order Placed',
      subtitle: 'Your order has been successfully placed!',
      configuration: const IconConfiguration(
        icon: Icons.done,
        color: Colors.green,
      ),
      maxWidth: 260,
    );
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/order-confirmation');
    });
    log('Payment successful');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    StatusAlert.show(
      context,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      title: 'Oops!',
      subtitle: 'Something  went wrong, try again!',
      configuration: const IconConfiguration(
        icon: Icons.clear,
        color: Colors.red,
      ),
      maxWidth: 260,
    );
    log('Payment failure');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    log('Payment from external wallet');
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
          title: 'Checkout',
          actionList: [],
        ),
        body: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                ),
              );
            }
            if (state is CheckoutLoaded) {
              log('<<<<<<<<<<<checxkout screen>>>>>>>>>>>');
              log(state.cart.grandTotal.toString());
              log(state.address.toString());
              //log(state.address!.name);
              log(state.paymentMethod.toString());
              log('<<<<<<<<<<//////////>>>>>>>>>>');
              return ListView(
                children: [
                  (state.address == null)
                      ? const SectionTitleWidget(
                          title: 'Delivery Address',
                        )
                      : SectionTitleWidget(
                          title: 'Delivery Address',
                          button: true,
                          buttonText: 'Change',
                          onPressed: () {
                            Navigator.pushNamed(context, '/address');
                          },
                        ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  (state.address == null)
                      ? const NewAddressCard()
                      : CheckoutAddressCard(
                          address: state.address!,
                        ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  const CheckoutPaymentWidget(),
                ],
              );
            } else {
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoaded) {
              if (state.paymentMethod == PaymentMethod.cash_on_delivery) {
                return BottomAppBar(
                  child: MainButtonWidget(
                    buttonText: 'PAY WITH COD',
                    onPressed: () async {
                      BlocProvider.of<CheckoutBloc>(context)
                          .add(CheckoutConfirmed(
                        email: currentUser!,
                      ));
                      StatusAlert.show(
                        context,
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.white,
                        title: 'Order Placed',
                        subtitle: 'Your order has been successfully placed!',
                        configuration: const IconConfiguration(
                          icon: Icons.done,
                          color: Colors.green,
                        ),
                        maxWidth: 260,
                      );
                      await Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushNamed(context, '/order-confirmation');
                      });
                    },
                  ),
                );
              } else if (state.paymentMethod == PaymentMethod.razor_pay) {
                return BottomAppBar(
                  child: MainButtonWidget(
                    buttonText: 'PAY WITH RAZOR PAY',
                    onPressed: () {
                      var options = {
                        'key': "rzp_test_VvxnqdV4Axfbfz",
                        //amount must be multiple of 100
                        'amount': state.cart.grandTotal * 100,
                        'name': 'GroMart',
                        'description': 'Sample Payment',
                        'timeout': 300, // in seconds
                        'prefill': {
                          'contact': '9746411339',
                          'email': 'gromart@razorpay.com'
                        }
                      };
                      _razorpay.open(options);
                      
                      // BlocProvider.of<CheckoutBloc>(context)
                      //     .add(CheckoutConfirmed(
                      //   email: currentUser!,
                      //));
                    },
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
