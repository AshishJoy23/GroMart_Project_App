import 'dart:developer';

import 'package:flutter/material.dart';

class CheckoutNavButtonWidget extends StatelessWidget {
  final int colorValue;
  final String number;
  final String title;
  final bool isPayment;
  const CheckoutNavButtonWidget({
    super.key,
    required this.colorValue,
    required this.number,
    required this.title,
    this.isPayment = false,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Row(
      children: [
        InkWell(
          onTap: () {
            log('clicked nav');
          },
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Color(colorValue),
                radius: 30,
                child: Text(
                  number,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        (isPayment==false)
        ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width / 5,
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color(colorValue),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
          ],
        )
        : const SizedBox(),
      ],
    );
  }
}
