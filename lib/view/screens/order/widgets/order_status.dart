import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/order_model.dart';
import 'package:gromart_project/view/screens/screens.dart';

class OrderStatusWidget extends StatelessWidget {
  final String orderId;
  final int productId;
  const OrderStatusWidget({
    super.key,
    required this.orderId,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return Center(
            child: Transform.scale(
              scale: 0.7,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: Colors.white,
                color: Colors.black,
              ),
            ),
          );
        } else if (state is OrdersLoaded) {
          final OrderModel order =
              state.orders.firstWhere((order) => order.id == orderId);
          final Map<String, dynamic> orderProductDetails = order.orderDetailsMap
              .firstWhere((product) => product['productId'] == productId);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Order Status:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomEachOrderStatus(
                statusDate: order.placedAt,
                status: 'Order Placed',
                statusFlag: order.isPlaced,
                statusDescription:
                    'Your order is placed and will be confirm soon.',
                isConfirmed: !(orderProductDetails['isConfirmed']),
                isProcessed: !(orderProductDetails['isProcessed']),
                isShipped: !(orderProductDetails['isShipped']),
                isDelivered: !(orderProductDetails['isDelivered']),
                iscancel: !(orderProductDetails['isCancelled']),
              ),
              CustomVerticalDivider(
                statusFlag: orderProductDetails['isConfirmed'],
              ),
              (orderProductDetails['isCancelled'])
                  ? CustomEachOrderStatus(
                      statusDate: orderProductDetails['cancelledAt'],
                      status: 'Order Cancelled',
                      statusFlag: orderProductDetails['isCancelled'],
                      statusDescription: 'Your order is cancelled.',
                      isConfirmed: true,
                      isProcessed: true,
                      isShipped: true,
                      isDelivered: true,
                      isRed: true,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomEachOrderStatus(
                          statusDate: orderProductDetails['confirmedAt'],
                          status: 'Order Confirmed',
                          statusFlag: orderProductDetails['isConfirmed'],
                          statusDescription:
                              'Your order is confirmed and will be processed soon.',
                          isConfirmed: orderProductDetails['isConfirmed'],
                          isProcessed: !orderProductDetails['isProcessed'],
                          isShipped: !orderProductDetails['isShipped'],
                          isDelivered: !orderProductDetails['isDelivered'],
                        ),
                        CustomVerticalDivider(
                          statusFlag: orderProductDetails['isProcessed'],
                        ),
                        CustomEachOrderStatus(
                          statusDate: orderProductDetails['processedAt'],
                          status: 'Order Processed',
                          statusFlag: orderProductDetails['isProcessed'],
                          statusDescription:
                              'Your order is processed and will be shipped soon.',
                          isConfirmed: orderProductDetails['isConfirmed'],
                          isProcessed: orderProductDetails['isProcessed'],
                          isShipped: !orderProductDetails['isShipped'],
                          isDelivered: !orderProductDetails['isDelivered'],
                        ),
                        CustomVerticalDivider(
                          statusFlag: orderProductDetails['isShipped'],
                        ),
                        CustomEachOrderStatus(
                          statusDate: orderProductDetails['shippedAt'],
                          status: 'Order Shipped',
                          statusFlag: orderProductDetails['isShipped'],
                          statusDescription:
                              'Your order is shipped and will be delivered soon.',
                          isConfirmed: orderProductDetails['isConfirmed'],
                          isProcessed: orderProductDetails['isProcessed'],
                          isShipped: orderProductDetails['isShipped'],
                          isDelivered: !orderProductDetails['isDelivered'],
                        ),
                        CustomVerticalDivider(
                          statusFlag: orderProductDetails['isDelivered'],
                        ),
                        CustomEachOrderStatus(
                          statusDate: orderProductDetails['deliveredAt'],
                          status: 'Order Delivered',
                          statusFlag: orderProductDetails['isDelivered'],
                          statusDescription:
                              'Your order is shipped and will be delivered soon.',
                          isConfirmed: orderProductDetails['isConfirmed'],
                          isProcessed: orderProductDetails['isProcessed'],
                          isShipped: orderProductDetails['isShipped'],
                          isDelivered: orderProductDetails['isDelivered'],
                        ),
                      ],
                    ),
              const Divider(
                color: Colors.black,
              ),
            ],
          );
        } else {
          return const Icon(
            Icons.error,
            color: Colors.red,
          );
        }
      },
    );
  }
}

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({
    super.key,
    required this.statusFlag,
  });

  final bool statusFlag;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.356,
      height: size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          VerticalDivider(
            color: (statusFlag) ? const Color(0xff388E3C) : Colors.black26,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
