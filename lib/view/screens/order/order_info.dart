import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

class OrderInfoScreen extends StatelessWidget {
  final OrderModel order;
  final Map<String, dynamic> orderProductDetails;
  const OrderInfoScreen({
    super.key,
    required this.order,
    required this.orderProductDetails,
  });

  static const String routeName = '/order-info';

  static Route route(
      {required OrderModel order,
      required Map<String, dynamic> orderProductDetails}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => OrderInfoScreen(
        order: order,
        orderProductDetails: orderProductDetails,
      ),
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
        appBar: const CustomAppBarWidget(
          title: 'Order Info',
          actionList: [],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            order.id,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          order.placedAt,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                  ],
                ),
                OrderProductDetails(orderProductDetails: orderProductDetails),
                OrderStatusWidget(
                    order: order, orderProductDetails: orderProductDetails),
                // order status end here>>>>>>>>>>>>>>>>>>>>>>
                Column(
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
                ),
                OrderPaymentSummary(order: order),
                MainButtonWidget(buttonText: 'Cancel Order', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}