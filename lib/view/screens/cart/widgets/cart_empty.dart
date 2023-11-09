import 'package:flutter/material.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/cart_empty.png',
              width: size.width,
              height: size.height * 0.4,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Your Cart is Empty!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Add items to cart and explore your shopping.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
  }
}
