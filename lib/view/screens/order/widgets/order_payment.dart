import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';

class OrderPaymentSummary extends StatelessWidget {
  const OrderPaymentSummary({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Summary:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Payment Method:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Text(
              order.paymentMethod,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Subtotal Amount:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Text(
              '${order.subTotal}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Delivery Charge:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Text(
              '${order.deliveryFee}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Total Amount:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              '${order.grandTotal}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}
