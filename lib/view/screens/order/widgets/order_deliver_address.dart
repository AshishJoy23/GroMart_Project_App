import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';

class OrderDeliverAddress extends StatelessWidget {
  const OrderDeliverAddress({
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
          'Delivered To:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          order.address!.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          '${order.address!.house},',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          '${order.address!.street}, ${order.address!.city},',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          '${order.address!.state} - ${order.address!.pincode},',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'Phone : ${order.address!.phone}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}
