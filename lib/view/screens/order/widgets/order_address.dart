import 'package:flutter/material.dart';
import 'package:gromart_project/models/address_model.dart';

class OrderAddressWidget extends StatelessWidget {
  final AddressModel address;
  const OrderAddressWidget({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hi ${address.name},',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.black),
        ),
        const SizedBox(height: 10),
        Text(
          'BILLING ADDRESS',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.black),
        ),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.house,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '${address.street}, ${address.city}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '${address.state} - ${address.pincode}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Phone - ${address.phone}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
