import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:pay/pay.dart';

class ApplePay extends StatelessWidget {
  const ApplePay({
    Key? key,
    // required this.total,
    // required this.products,
  }) : super(key: key);

  // final String total;
  // final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // var _paymentItems = products
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
    //     amount: '100',
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

    void onApplePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: ApplePayButton(
                paymentConfiguration: PaymentConfiguration.fromJsonString(
                    defaultApplePayConfigString),
                onPaymentResult: onApplePayResult,
                paymentItems: _paymentItems,
                style: ApplePayButtonStyle.white,
                type: ApplePayButtonType.inStore,
                margin: const EdgeInsets.only(top: 10),
                loadingIndicator: const CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
