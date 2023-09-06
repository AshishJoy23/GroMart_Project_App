import 'package:flutter/material.dart';

class OrderConfirmedBanner extends StatelessWidget {
  const OrderConfirmedBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.green,
      width: double.infinity,
      height: size.height*0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height*0.05,),
          const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 34, 129, 39),
        radius: 50,
        child: Icon(
          Icons.done,
          size: 50,
          color: Colors.white,
        ),
      ),
      SizedBox(height: size.height*0.02,),
      Text(
        'Your order is complete!',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Colors.white),
      ),
        ],
      ),
    );
  }
}
