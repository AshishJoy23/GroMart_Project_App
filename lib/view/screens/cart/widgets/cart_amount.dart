import 'package:flutter/material.dart';

import '../../../../models/models.dart';

class CartAmountWidget extends StatelessWidget {
  const CartAmountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 10.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SUBTOTAL',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '\$.subTotalString}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'DELIVERY FEE',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '\$CartModel().deliveryFeeString}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              )
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                  color: const Color(0xff388E3C).withAlpha(100)),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xff388E3C),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOTAL',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      '\$.totalAmountString}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
