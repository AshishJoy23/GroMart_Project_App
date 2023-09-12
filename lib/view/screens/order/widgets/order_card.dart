import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/screens/screens.dart';

class OrderProductCardWidget extends StatelessWidget {
  const OrderProductCardWidget({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: order.orderDetailsMap.length,
            itemBuilder: (context, index) {
              ProductModel product = (BlocProvider.of<ProductBloc>(context)
                      .state as ProductLoaded)
                  .products
                  .firstWhere((product) =>
                      product.id == order.orderDetailsMap[index]['productId']);
              Map<String, dynamic> orderProductDetails =
                  order.orderDetailsMap[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Material(
                  elevation: 12,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        OrderInfoScreen.route(
                          order: order, // Pass your OrderModel object
                          orderProductDetails:
                              orderProductDetails, // Pass your Map object
                        ),
                      );
                    },
                    child: Container(
                      height: size.height * 0.16,
                      width: size.width / 1,
                      decoration: const BoxDecoration(
                        color: Color(0xffC8E6C9),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                product.imageUrls[0],
                                width: size.height * 0.14,
                                height: size.height * 0.15,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (order.orderDetailsMap[index]
                                            ['isCancelled'])
                                        ? 'Cancelled'
                                        : (order.orderDetailsMap[index]
                                                ['isDelivered'])
                                            ? 'Delivered'
                                            : (order.orderDetailsMap[index]
                                                    ['isShipped'])
                                                ? 'Shipped'
                                                : (order.orderDetailsMap[index]
                                                        ['isProcessed'])
                                                    ? 'Processed'
                                                    : (order.orderDetailsMap[
                                                                index]
                                                            ['isConfirmed'])
                                                        ? 'Confirmed'
                                                        : 'Placed',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const Spacer(),
                                  Text(
                                    product.name,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${order.orderDetailsMap[index]['quantity']} x ${product.price}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                      Text(
                                        '${order.orderDetailsMap[index]['quantity'] * product.price}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          (order.orderDetailsMap[index]
                                                  ['isCancelled'])
                                              ? 'Cancelled on :'
                                              : (order.orderDetailsMap[index]
                                                      ['isDelivered'])
                                                  ? 'Delivered on :'
                                                  : (order.orderDetailsMap[
                                                          index]['isShipped'])
                                                      ? 'Shipped on :'
                                                      : (order.orderDetailsMap[
                                                                  index]
                                                              ['isProcessed'])
                                                          ? 'Processed on :'
                                                          : (order.orderDetailsMap[
                                                                      index][
                                                                  'isConfirmed'])
                                                              ? 'Confirmed on :'
                                                              : 'Placed on :',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                      Text(
                                        (order.orderDetailsMap[index]
                                                ['isCancelled'])
                                            ? '${order.orderDetailsMap[index]['cancelledAt']}'
                                            : (order.orderDetailsMap[index]
                                                    ['isDelivered'])
                                                ? '${order.orderDetailsMap[index]['deliveredAt']}'
                                                : (order.orderDetailsMap[index]
                                                        ['isShipped'])
                                                    ? '${order.orderDetailsMap[index]['shippedAt']}'
                                                    : (order.orderDetailsMap[
                                                                index]
                                                            ['isProcessed'])
                                                        ? '${order.orderDetailsMap[index]['processedAt']}'
                                                        : (order.orderDetailsMap[
                                                                    index]
                                                                ['isConfirmed'])
                                                            ? '${order.orderDetailsMap[index]['confirmedAt']}'
                                                            : order.placedAt,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
