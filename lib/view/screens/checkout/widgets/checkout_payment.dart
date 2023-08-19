import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';

class CheckoutPaymentWidget extends StatefulWidget {
  const CheckoutPaymentWidget({super.key});

  @override
  State<CheckoutPaymentWidget> createState() => _CheckoutPaymentWidgetState();
}

class _CheckoutPaymentWidgetState extends State<CheckoutPaymentWidget> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if (state is PaymentLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        if (state is PaymentLoaded) {
          return Column(
            children: [
              RadioListTile(
                activeColor: const Color(0xff388E3C),
                value: PaymentMethod.razor_pay,
                groupValue: state.paymentMethod,
                onChanged: (value) {
                  BlocProvider.of<PaymentBloc>(context).add(
                    const PaymentMethodSelected(
                        paymentMethod: PaymentMethod.razor_pay),
                  );
                },
                title: SizedBox(
                  height: height * 0.06,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                        Colors.black,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                  BlocProvider.of<PaymentBloc>(context).add(
                    const PaymentMethodSelected(
                        paymentMethod: PaymentMethod.cash_on_delivery),
                  );
                },
                title: SizedBox(
                  height: height * 0.06,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                        Colors.black,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
    );
  }
}
