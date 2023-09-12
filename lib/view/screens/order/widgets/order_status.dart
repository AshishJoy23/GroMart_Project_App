import 'package:flutter/material.dart';
import 'package:gromart_project/models/order_model.dart';

class OrderStatusWidget extends StatelessWidget {
  final OrderModel order;
  final Map<String, dynamic> orderProductDetails;
  const OrderStatusWidget({
    super.key,
    required this.order,
    required this.orderProductDetails,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Status:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Row(
          children: [
            SizedBox(
              width: size.width * 0.3,
              child: Text(
                order.placedAt,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xff388E3C),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.1,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Placed',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  (!(orderProductDetails['isConfirmed']) &&
                          !(orderProductDetails['isProcessed']) &&
                          !(orderProductDetails['isShipped']) &&
                          !(orderProductDetails['isDelivered']) &&
                          !(orderProductDetails['isCancelled']))
                      ? Text(
                          'Your order is placed and will be confirm soon.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
        CustomVerticalDivider(
          statusFlag: orderProductDetails['isConfirmed'],
          isCancel: orderProductDetails['isCancelled'],
        ),
        (orderProductDetails['isCancelled'])
            ? Row(
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    child: Text(
                      orderProductDetails['cancelledAt'],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Cancelled',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Your order is cancelled.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
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
  }
}

class CustomEachOrderStatus extends StatelessWidget {
  const CustomEachOrderStatus({
    super.key,
    required this.statusDate,
    required this.status,
    required this.statusFlag,
    required this.statusDescription,
    required this.isConfirmed,
    required this.isProcessed,
    required this.isShipped,
    required this.isDelivered,
  });

  final String statusDate;
  final String status;
  final bool statusFlag;
  final String statusDescription;
  final bool isConfirmed;
  final bool isProcessed;
  final bool isShipped;
  final bool isDelivered;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.3,
          child: Text(
            statusDate,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        (statusFlag)
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Color(0xff388E3C),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              )
            : const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black26,
                ),
              ),
        SizedBox(
          width: size.width * 0.1,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
                style: (statusFlag)
                    ? Theme.of(context).textTheme.titleMedium
                    : Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black26),
              ),
              ((isConfirmed) && (isProcessed) && (isShipped) && (isDelivered))
                  ? Text(
                      statusDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({
    super.key,
    required this.statusFlag,
    this.isCancel = false,
  });

  final bool statusFlag;
  final bool isCancel;

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
            color: (isCancel)
                ? Colors.red
                : (statusFlag)
                    ? const Color(0xff388E3C)
                    : Colors.black26,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
