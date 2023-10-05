import 'package:flutter/material.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';

  const OrderConfirmation({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OrderConfirmation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff4CAF50),
            Color(0xffC8E6C9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/order_confirm.png',
                width: size.width * 0.9,
                height: size.height * 0.4,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Successfully!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Your order has been placed.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                children: [
                  MainButtonWidget(
                    buttonText: 'View Orders',
                    onPressed: () {
                      Navigator.pushNamed(context, '/orders');
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  MainButtonWidget(
                    buttonText: 'Back To Home',
                    isSubButton: true,
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
