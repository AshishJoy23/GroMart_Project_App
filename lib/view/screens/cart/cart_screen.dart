import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CartScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        appBar: const CustomAppBarWidget(
          title: 'Cart',
          actionList: [],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            const CartModel().freeDeliveryStatus,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/',
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Add More Items',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: CartModel.products.length,
                          itemBuilder: (context, index) {
                            return CardProductCard(
                                product: CartModel.products[index]);
                          },
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                  CartAmountWidget(),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          child: MainButtonWidget(buttonText: 'GO TO CHECKOUT'),
        ),
      ),
    );
  }
}
