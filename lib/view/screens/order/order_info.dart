import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/config/utils.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

class OrderInfoScreen extends StatelessWidget {
  final String orderId;
  final int productId;
  const OrderInfoScreen({
    super.key,
    required this.orderId,
    required this.productId,
  });

  static const String routeName = '/order-info';

  static Route route({required String orderId, required int productId}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => OrderInfoScreen(
        orderId: orderId,
        productId: productId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? currentUser = FirebaseAuth.instance.currentUser!.email;
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is OrdersLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    backgroundColor: Colors.white,
                    color: Colors.black,
                  ),
                );
              } else if (state is OrdersLoaded) {
                final OrderModel order =
                    state.orders.firstWhere((order) => order.id == orderId);
                final Map<String, dynamic> orderProductDetails =
                    order.orderDetailsMap.firstWhere(
                        (product) => product['productId'] == productId);
                return SingleChildScrollView(
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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
                      OrderProductDetails(
                          orderProductDetails: orderProductDetails),
                      OrderStatusWidget(
                          orderId: order.id,
                          productId: orderProductDetails['productId']),
                      // order status end here>>>>>>>>>>>>>>>>>>>>>>
                      OrderDeliverAddress(order: order),
                      OrderPaymentSummary(order: order),
                      (orderProductDetails['isShipped'])
                      ? const SizedBox()
                      : Row(
                        children: [
                          MainButtonWidget(
                              buttonText: (orderProductDetails['isCancelled'])
                                  ? 'Back To Orders'
                                  : 'Cancel Order',
                              onPressed: (orderProductDetails['isCancelled'])
                                  ? () => Navigator.pop(context)
                                  : () {
                                      Utils.showAlertDialogBox(
                                        context,
                                        'Are You Sure?',
                                        'You want to cancel this order.',
                                        () {
                                          BlocProvider.of<OrdersBloc>(context).add(
                                            OrderCancelled(
                                                email: currentUser!,
                                                productId: orderProductDetails[
                                                    'productId'],
                                                order: order),
                                          );
                                          Navigator.pop(context);
                                          Utils.showSnackBar(
                                              'Your order is Cancelled',
                                              Colors.redAccent);
                                        },
                                      );
                                    }),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Icon(
                  Icons.error,
                  color: Colors.red,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

