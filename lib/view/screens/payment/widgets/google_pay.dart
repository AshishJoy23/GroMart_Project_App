import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:pay/pay.dart';
import 'payment_configurations.dart' as payment_configurations;

class GooglePay extends StatelessWidget {
  const GooglePay({
    Key? key,
    // required this.total,
    // required this.products,
  }) : super(key: key);

  // final String total;
  // final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    //var _paymentItems = products
    //     .map(
    //       (product) => PaymentItem(
    //           label: product.name,
    //           amount: product.price.toString(),
    //           type: PaymentItemType.item,
    //           status: PaymentItemStatus.final_price),
    //     )
    //     .toList();

    // _paymentItems.add(
    //   PaymentItem(
    //     label: "Total",
    //     amount: 100.toString(),
    //     type: PaymentItemType.total,
    //     status: PaymentItemStatus.final_price,
    //   ),
    // );

    const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '99.99',
    status: PaymentItemStatus.final_price,
  )
];

    void onGooglePayResult(paymentResult) {
      log(paymentResult.toString());
    }

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: const Color(0xff388E3C),
              height: MediaQuery.of(context).size.height * 0.07,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: GooglePayButton(
                    paymentConfiguration: PaymentConfiguration.fromJsonString(
                        payment_configurations.defaultGooglePayConfigString),
                    onPaymentResult: onGooglePayResult,
                    paymentItems: _paymentItems,
                    //style: GooglePayButtonStyle.white,
                    type: GooglePayButtonType.pay,
                    margin: const EdgeInsets.only(top: 10),
                    loadingIndicator: const CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
