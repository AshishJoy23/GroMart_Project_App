import 'package:flutter/material.dart';
import 'package:gromart_project/view/screens/screens.dart';

class CheckoutNavCardWidget extends StatelessWidget {
  const CheckoutNavCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Material(
        elevation: 10,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: height * 0.142,
          width: width / 1,
          decoration: const BoxDecoration(
            color: Color(0xffC8E6C9),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              width * 0.02,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: const [
                      Spacer(),
                      CheckoutNavButtonWidget(
                        colorValue: 0xff388E3C,
                        number: '1',
                        title: 'CART',
                      ),
                      CheckoutNavButtonWidget(
                        colorValue: 0xff757575,
                        number: '2',
                        title: 'ADDRESS',
                      ),
                      CheckoutNavButtonWidget(
                        colorValue: 0xff757575,
                        number: '3',
                        title: 'PAYMENT',
                        isPayment: true,
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


